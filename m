From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v0 0/2] Introduce on-chip interconnect API
Date: Fri, 3 Mar 2017 00:21:45 -0600
Message-ID: <20170303062145.zpa4oblwgx2ecgv7@rob-hp-laptop>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170301182235.19154-1-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, davidai@quicinc.com, skannan@codeaurora.org, khilman@baylibre.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 01, 2017 at 08:22:33PM +0200, Georgi Djakov wrote:
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a lot
> of data flowing through the on-chip interconnects. These interconnect buses
> could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
> 
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or cpu intensive tasks.
> 
> Having an API to control the requirement of the system in term of bandwidth
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
> the interconnect controllers and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Below is a simplified diagram of a real-world SoC topology. The interconnect
> providers are the memory front-end and the NoCs.
> 
> +----------------+    +----------------+
> | HW Accelerator |--->|      M NoC     |<---------------+
> +----------------+    +----------------+                |
>                         |      |                    +------------+
>           +-------------+      V       +------+     |            |
>           |                +--------+  | PCIe |     |            |
>           |                | Slaves |  +------+     |            |
>           |                +--------+     |         |   C NoC    |
>           V                               V         |            |
> +------------------+   +------------------------+   |            |   +-----+
> |                  |-->|                        |-->|            |-->| CPU |
> |                  |-->|                        |<--|            |   +-----+
> |      Memory      |   |         S NoC          |   +------------+
> |                  |<--|                        |---------+    |
> |                  |<--|                        |<------+ |    |   +--------+
> +------------------+   +------------------------+       | |    +-->| Slaves |
>    ^     ^    ^           ^                             | |        +--------+
>    |     |    |           |                             | V
> +-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
> | CPU |  |  | GPU |    | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> +-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
>          |
>      +-------+
>      | Modem |
>      +-------+
> 
> This RFC does not implement all features but only main skeleton to check the
> validity of the proposal. Currently it only works with device-tree and platform
> devices.
> 
> TODO:
>  * Constraints are currently stored in internal data structure. Should PM QoS
>  be used instead?
>  * Rework the framework to not depend on DT as frameworks cannot be tied
>  directly to firmware interfaces. Add support for ACPI?

I would start without DT even. You can always have the data you need in 
the kernel. This will be more flexible as you're not defining an ABI as 
this evolves. I think it will take some time to have consensus on how to 
represent the bus master view of buses/interconnects (It's been 
attempted before). 

Rob
