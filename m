From: Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 0/4] drivers/qcom: add RPMH communication support
Date: Thu, 18 Jan 2018 17:01:53 -0700
Message-ID: <20180119000157.7380-1-ilina@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This set of patches add the ability for platform drivers to make use of shared
resources in newer Qualcomm SoCs like SDM845. Resources that are shared between
different processors in a SoC are generally controlled by a dedicated remote
processor. The remote processor (Resource Power Manager or RPM in previous QCOM
SoCs) receives requests for resource state from other processors using the
shared resource, aggregates the request and applies the result on the shared
resource. SDM845 advances this concept and uses h/w (hardened I/P) blocks for
aggregating requests and applying the result on the resource. The resources
could be clocks, regulators or bandwidth requests for buses. This new
architecture is called RPM-hardened or RPMH in short.

Since this communication mechanism is completely hardware driven without a
processor intervention on the remote end, existing mechanisms like RPM-SMD are
no longer useful. Also, there is no serialization of data or is data is written
to a shared memory in this new format. The data used is different, unsigned 32
bits are used for representing an address, data and header. Each resource's
property is a unique u32 address and have pre-defined set of property specific
valid values. A request that comprises of <header, addr, data> is sent by
writing to a set of registers from Linux and transmitted to the remote slave
through an internal bus. The remote end aggregates this request along with
requests from other processors for the <addr> and applies the result.

The hardware block that houses this functionality is called Resource State
Coordinator or RSC. Inside the RSC are set of slots for sending RPMH requests
called Trigger Commands Sets (TCS). The set of patches are for writing the
requests into these TCSes and sending them to hardened IP blocks.

The driver design is split into two components. The RSC driver housed in
rpmh-rsc.c and the set of library functions in rpmh.c that frame the request and
transmit it using the controller. This first set of patches allow a simple
synchronous request to be made by the platform drivers. Future patches will add
more functionality that cater to complex drivers and use cases.

Thanks,
Lina

Lina Iyer (4):
  drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
  dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
  drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
  drivers: qcom: rpmh: add RPMH helper functions

 .../devicetree/bindings/arm/msm/rpmh-rsc.txt       | 134 ++++
 drivers/soc/qcom/Kconfig                           |   7 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpmh-internal.h                   |  26 +
 drivers/soc/qcom/rpmh-rsc.c                        | 686 +++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                            | 264 ++++++++
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |  16 +
 include/soc/qcom/rpmh.h                            |  41 ++
 include/soc/qcom/tcs.h                             |  38 ++
 include/trace/events/rpmh.h                        |  89 +++
 10 files changed, 1302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/soc/qcom/rpmh.h
 create mode 100644 include/soc/qcom/tcs.h
 create mode 100644 include/trace/events/rpmh.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
