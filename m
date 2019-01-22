From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Date: Tue, 22 Jan 2019 13:42:04 +0100
Message-ID: <20190122124204.GA26969@kroah.com>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, abailon@baylibre.com, maxime.ripard@bootlin.com, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
> 
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
> 
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
> 
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Below is a simplified diagram of a real-world SoC topology. The interconnect
> providers are the NoCs.
> 
> +----------------+    +----------------+
> | HW Accelerator |--->|      M NoC     |<---------------+
> +----------------+    +----------------+                |
>                         |      |                    +------------+
>  +-----+  +-------------+      V       +------+     |            |
>  | DDR |  |                +--------+  | PCIe |     |            |
>  +-----+  |                | Slaves |  +------+     |            |
>    ^ ^    |                +--------+     |         |   C NoC    |
>    | |    V                               V         |            |
> +------------------+   +------------------------+   |            |   +-----+
> |                  |-->|                        |-->|            |-->| CPU |
> |                  |-->|                        |<--|            |   +-----+
> |     Mem NoC      |   |         S NoC          |   +------------+
> |                  |<--|                        |---------+    |
> |                  |<--|                        |<------+ |    |   +--------+
> +------------------+   +------------------------+       | |    +-->| Slaves |
>   ^  ^    ^    ^          ^                             | |        +--------+
>   |  |    |    |          |                             | V
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
>           |
>       +-------+
>       | Modem |
>       +-------+
> 
> It's important to note that the interconnect API, in contrast with devfreq,
> is allowing drivers to express their needs in advance and be proactive.
> Devfreq is using a reactive approach (e.g. monitor performance counters and
> reconfigure bandwidth when the bottleneck had already occurred), which is
> suboptimal and might not work well. The interconnect API is designed to
> deal with multi-tiered bus topologies and aggregating constraints provided
> by drivers, while the devfreq is more oriented towards a device like GPU
> or CPU, that controls the power/performance of itself and not other devices.
> 
> Some examples of how interconnect API is used by consumers:
> https://lkml.org/lkml/2018/12/20/811
> https://lkml.org/lkml/2019/1/9/740
> https://lkml.org/lkml/2018/10/11/499
> https://lkml.org/lkml/2018/9/20/986
> 
> Platform drivers for different SoCs are available:
> https://lkml.org/lkml/2018/11/17/368
> https://lkml.org/lkml/2018/8/10/380

All now queued up, thanks.

greg k-h
