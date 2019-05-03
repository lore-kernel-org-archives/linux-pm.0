From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
Date: Fri, 03 May 2019 14:08:20 -0700
Message-ID: <155691770027.200842.16164651681407381397@swboyd.mtv.corp.google.com>
References: <20190430112012.4514-1-roger.lu@mediatek.com>
 <20190430112012.4514-2-roger.lu@mediatek.com>
 <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
 <1556777971.12123.35.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556777971.12123.35.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Lu <roger.lu@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Angus.Lin@mediatek.com, devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy-YT.Liu@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Roger Lu (2019-05-01 23:19:31)
> On Tue, 2019-04-30 at 13:31 -0700, Stephen Boyd wrote:
> > Quoting Roger Lu (2019-04-30 04:20:10)
> > > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > new file mode 100644
> > > index 000000000000..355329db74ba
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
[..]
> > > +
> > > +               svs_gpu: svs_gpu {
> > > +                       compatible = "mediatek,mt8183-svs-gpu";
> > > +                       power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> > > +                       operating-points-v2 = <&gpu_opp_table>;
> > > +               };
> > 
> > It looks like you need multiple OPPs for a single device, because it has
> > different independent power supplies it wants to associate the OPP
> > tables with?
> Yes. SVS has different controllers inside the hardware in order to
> calculate and optimize different OPP table voltage part.

So is there more than one SVS register region that needs certain devices
to be powered on or at least have their power domain enabled so that the
SVS hardware can read the voltage and adjust accordingly? I should read
the driver I suppose.

> 
> > Why can't these OPP tables be attached to the devices that
> > use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices don't
> > have OPP tables that this hardware block can look up somehow.
> Those OPP tables are attached by our DVFS node (please refers below
> patch). SVS just shares with their OPP table and help optimize these OPP
> tables' voltage part.
> 
> Add cpufreq DTS node to the mt8183 and mt8183-evb
> https://patchwork.kernel.org/patch/10921675/

Cool thanks for the pointer.

> 
> 
> > Similarly,
> > the power domains should probably be part of the devices that are using
> > them and not these sub-nodes that are mirroring the other hardware
> > blocks in the system?
> Oh. There is a svs controller in GPU power-domain. We need to turn on
> GPU power so that svs controller can work functionally. Therefore, we
> add GPU power-domains in our svs_gpu sub-node.
> 
> 

Sorry, I'm not really following what you're saying too closely. I think
I get it but it sounds complicated.

I'm mostly wondering if having properties like svs-gpu = <&gpu_node>,
and svs-cci = <&cci_node> would work for you. The idea would be to link
this hardware block to the nodes that it's going to adjust the OPPs of.
Once you have the node, use some sort of OPP API to get the OPP table
for a device_node and adjust it at runtime for the current OPP. It
sounds like it might be a little more complicated if the hardware goes
haywire when the device like GPU is powered down and the power domain is
shut off. Hopefully it isn't though, so that the driver can mostly sit
on top of the SVS hardware and poke OPP every once and a while when the
voltage needs to change, regardless of the power state of the device.
