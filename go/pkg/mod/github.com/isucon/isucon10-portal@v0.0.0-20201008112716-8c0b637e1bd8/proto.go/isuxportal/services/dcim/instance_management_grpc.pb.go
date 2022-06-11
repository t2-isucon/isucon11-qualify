// Code generated by protoc-gen-go-grpc. DO NOT EDIT.

package dcim

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion7

// InstanceManagementClient is the client API for InstanceManagement service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type InstanceManagementClient interface {
	InformInstanceStateUpdate(ctx context.Context, in *InformInstanceStateUpdateRequest, opts ...grpc.CallOption) (*InformInstanceStateUpdateResponse, error)
}

type instanceManagementClient struct {
	cc grpc.ClientConnInterface
}

func NewInstanceManagementClient(cc grpc.ClientConnInterface) InstanceManagementClient {
	return &instanceManagementClient{cc}
}

var instanceManagementInformInstanceStateUpdateStreamDesc = &grpc.StreamDesc{
	StreamName: "InformInstanceStateUpdate",
}

func (c *instanceManagementClient) InformInstanceStateUpdate(ctx context.Context, in *InformInstanceStateUpdateRequest, opts ...grpc.CallOption) (*InformInstanceStateUpdateResponse, error) {
	out := new(InformInstanceStateUpdateResponse)
	err := c.cc.Invoke(ctx, "/isuxportal.proto.services.dcim.InstanceManagement/InformInstanceStateUpdate", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// InstanceManagementService is the service API for InstanceManagement service.
// Fields should be assigned to their respective handler implementations only before
// RegisterInstanceManagementService is called.  Any unassigned fields will result in the
// handler for that method returning an Unimplemented error.
type InstanceManagementService struct {
	InformInstanceStateUpdate func(context.Context, *InformInstanceStateUpdateRequest) (*InformInstanceStateUpdateResponse, error)
}

func (s *InstanceManagementService) informInstanceStateUpdate(_ interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(InformInstanceStateUpdateRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return s.InformInstanceStateUpdate(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     s,
		FullMethod: "/isuxportal.proto.services.dcim.InstanceManagement/InformInstanceStateUpdate",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return s.InformInstanceStateUpdate(ctx, req.(*InformInstanceStateUpdateRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// RegisterInstanceManagementService registers a service implementation with a gRPC server.
func RegisterInstanceManagementService(s grpc.ServiceRegistrar, srv *InstanceManagementService) {
	srvCopy := *srv
	if srvCopy.InformInstanceStateUpdate == nil {
		srvCopy.InformInstanceStateUpdate = func(context.Context, *InformInstanceStateUpdateRequest) (*InformInstanceStateUpdateResponse, error) {
			return nil, status.Errorf(codes.Unimplemented, "method InformInstanceStateUpdate not implemented")
		}
	}
	sd := grpc.ServiceDesc{
		ServiceName: "isuxportal.proto.services.dcim.InstanceManagement",
		Methods: []grpc.MethodDesc{
			{
				MethodName: "InformInstanceStateUpdate",
				Handler:    srvCopy.informInstanceStateUpdate,
			},
		},
		Streams:  []grpc.StreamDesc{},
		Metadata: "isuxportal/services/dcim/instance_management.proto",
	}

	s.RegisterService(&sd, nil)
}