From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add TI SCI PM Domains
Date: Thu, 27 Oct 2016 12:02:50 +0300
Message-ID: <8724b41d-158a-f52c-8df6-4e8913b4094a@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
 <20161019203347.17893-3-d-gerlach@ti.com>
 <20161026220457.kvbd4wgtizdbndf3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161026220457.kvbd4wgtizdbndf3@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 27/10/16 01:04, Rob Herring wrote:
> On Wed, Oct 19, 2016 at 03:33:45PM -0500, Dave Gerlach wrote:
>> Add a generic power domain implementation, TI SCI PM Domains, that
>> will hook into the genpd framework and allow the TI SCI protocol to
>> control device power states.
>>
>> Also, provide macros representing each device index as understood
>> by TI SCI to be used in the device node power-domain references.
>> These are identifiers for the K2G devices managed by the PMMC.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 54 +++++++++++++
>>  MAINTAINERS                                        |  2 +
>>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>>  3 files changed, 146 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>  create mode 100644 include/dt-bindings/genpd/k2g.h
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>> new file mode 100644
>> index 000000000000..32f38a349656
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>> @@ -0,0 +1,54 @@
>> +Texas Instruments TI-SCI Generic Power Domain
>> +---------------------------------------------
>> +
>> +Some TI SoCs contain a system controller (like the PMMC, etc...) that is
>> +responsible for controlling the state of the IPs that are present.
>> +Communication between the host processor running an OS and the system
>> +controller happens through a protocol known as TI-SCI [1]. This pm domain
>> +implementation plugs into the generic pm domain framework and makes use of
>> +the TI SCI protocol power on and off each device when needed.
>> +
>> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +
>> +PM Domain Node
>> +==============
>> +The PM domain node represents the global PM domain managed by the PMMC,
>> +which in this case is the single implementation as documented by the generic
>> +PM domain bindings in Documentation/devicetree/bindings/power/power_domain.txt.
>> +
>> +Required Properties:
>> +--------------------
>> +- compatible: should be "ti,sci-pm-domain"
>> +- #power-domain-cells: Must be 0.
>> +- ti,sci: Phandle to the TI SCI device to use for managing the devices.
>> +
>> +Example:
>> +--------------------
>> +k2g_pds: k2g_pds {
>> +        compatible = "ti,sci-pm-domain";
>> +        #power-domain-cells = <0>;
>> +        ti,sci = <&pmmc>;
>> +};
>
> Why not just make the PMMC node be the power-domain provider itself? If
> not that, then make this a child node of it. The same comment applies to
> all the SCI functions, but I guess I've already acked some of them.

This seems to be a bug in this documentation actually. ti,sci handle is 
no longer supported, and all the sci stuff must be under the parent sci 
node.

>
> I really don't like reviewing all these TI SCI bindings one by one. Each
> one on its own seems fine, but I don't see the full picture.

The full picture is represented under the documentation for the main 
protocol support itself. See this patch:

https://patchwork.kernel.org/patch/9383281/

Copy pasted here as ref:

Example (K2G):
-------------
         pmmc: pmmc {
                 compatible = "ti,k2g-sci";
                 ...

                 my_clk_node: clk_node {
                         ...
                         ...
                 };

                 my_pd_node: pd_node {
                         ...
                         ...
                 };
         };
