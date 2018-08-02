From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 1/8] interconnect: Add generic on-chip interconnect API
Date: Wed, 1 Aug 2018 17:05:44 -0700
Message-ID: <fc7fd938-0e87-b88e-b2f2-ca8fd4134746@infradead.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731161340.13000-2-georgi.djakov@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/31/2018 09:13 AM, Georgi Djakov wrote:
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.rst |  96 ++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   2 +
>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>  include/linux/interconnect-provider.h       | 125 +++++
>  include/linux/interconnect.h                |  42 ++
>  8 files changed, 847 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
> 
> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
> new file mode 100644
> index 000000000000..e628881ee218
> --- /dev/null
> +++ b/Documentation/interconnect/interconnect.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +GENERIC SYSTEM INTERCONNECT SUBSYSTEM
> +=====================================
> +
> +Introduction
> +------------
> +
> +This framework is designed to provide a standard kernel interface to control
> +the settings of the interconnects on a SoC. These settings can be throughput,

I would say:                         on an SoC.

Do you pronounce that as "sock" or the letters S.O.C.?


> +latency and priority between multiple interconnected devices or functional
> +blocks. This can be controlled dynamically in order to save power or provide
> +maximum performance.
> +
> +The interconnect bus is a hardware with configurable parameters, which can be

                    bus is hardware

> +set on a data path according to the requests received from various drivers.
> +An example of interconnect buses are the interconnects between various
> +components or functional blocks in chipsets. There can be multiple interconnects
> +on a SoC that can be multi-tiered.

      an SoC

> +
> +Below is a simplified diagram of a real-world SoC interconnect bus topology.
> +
> +::
> +
> + +----------------+    +----------------+
> + | HW Accelerator |--->|      M NoC     |<---------------+
> + +----------------+    +----------------+                |
> +                         |      |                    +------------+
> +  +-----+  +-------------+      V       +------+     |            |
> +  | DDR |  |                +--------+  | PCIe |     |            |
> +  +-----+  |                | Slaves |  +------+     |            |
> +    ^ ^    |                +--------+     |         |   C NoC    |
> +    | |    V                               V         |            |
> + +------------------+   +------------------------+   |            |   +-----+
> + |                  |-->|                        |-->|            |-->| CPU |
> + |                  |-->|                        |<--|            |   +-----+
> + |     Mem NoC      |   |         S NoC          |   +------------+
> + |                  |<--|                        |---------+    |
> + |                  |<--|                        |<------+ |    |   +--------+
> + +------------------+   +------------------------+       | |    +-->| Slaves |
> +   ^  ^    ^    ^          ^                             | |        +--------+
> +   |  |    |    |          |                             | V
> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> + | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> +           |
> +       +-------+
> +       | Modem |
> +       +-------+
> +
> +Terminology
> +-----------
> +
> +Interconnect provider is the software definition of the interconnect hardware.
> +The interconnect providers on the above diagram are M NoC, S NoC, C NoC, P NoC
> +and Mem NoC.
> +
> +Interconnect node is the software definition of the interconnect hardware
> +port. Each interconnect provider consists of multiple interconnect nodes,
> +which are connected to other SoC components including other interconnect
> +providers. The point on the diagram where the CPUs connect to the memory is
> +called an interconnect node, which belongs to the Mem NoC interconnect provider.
> +
> +Interconnect endpoints are the first or the last element of the path. Every
> +endpoint is a node, but not every node is an endpoint.
> +
> +Interconnect path is everything between two endpoints including all the nodes
> +that have to be traversed to reach from a source to destination node. It may
> +include multiple master-slave pairs across several interconnect providers.
> +
> +Interconnect consumers are the entities which make use of the data paths exposed
> +by the providers. The consumers send requests to providers requesting various
> +throughput, latency and priority. Usually the consumers are device drivers, that
> +send request based on their needs. An example for a consumer is a video decoder
> +that supports various formats and image sizes.
> +
> +Interconnect providers
> +----------------------
> +
> +Interconnect provider is an entity that implements methods to initialize and
> +configure a interconnect bus hardware. The interconnect provider drivers should

   configure interconnect bus hardware.
(i.e., drop the "a")

> +be registered with the interconnect provider core.
> +
> +The interconnect framework provider API functions are documented in
> +.. kernel-doc:: include/linux/interconnect-provider.h

What do you want that to do?  and does that happen?

The .. kernel-doc:: line won't be printed.  It will just be expanded to the
contents of that header file, so the preceding sentence fragment will look/sound
odd.

> +
> +Interconnect consumers
> +----------------------
> +
> +Interconnect consumers are the clients which use the interconnect APIs to
> +get paths between endpoints and set their bandwidth/latency/QoS requirements
> +for these interconnect paths.
> +
> +The interconnect framework consumer API functions are documented in
> +.. kernel-doc:: include/linux/interconnect.h

same as above.


-- 
~Randy
