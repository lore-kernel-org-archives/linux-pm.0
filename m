From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 10/10] ARM: mvebu: Enable the thermal sensor in
 Armada 380/385 SoC
Date: Mon, 28 Apr 2014 14:33:27 -0400
Message-ID: <20140428183327.GA28159@titan.lakedaemon.net>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1398371004-15807-11-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140428164403.GA17824@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140428164403.GA17824@arch.cereza>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 28, 2014 at 01:44:03PM -0300, Ezequiel Garcia wrote:
> On Apr 24, Ezequiel Garcia wrote:
> > This commit enables the thermal sensor found in Armada 380/385 SoCs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > index a064f59..02c6139 100644
> > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > @@ -346,6 +346,12 @@
> >  				clock-output-names = "nand";
> >  			};
> >  
> > +			thermal@e8078 {
> > +				compatible = "marvell,armada380-thermal";
> > +				reg = <0xe4078 0x4>, <0xe404 0x4>;
> 
> Dammit, there's a stupid typo in the register offset. I never noticed this, because
> the initialization sequence does not do much, and this register is not really used
> (for now). The fix is this:
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 02c6139..370220f 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -348,7 +348,7 @@
>  
>  			thermal@e8078 {
>  				compatible = "marvell,armada380-thermal";
> -				reg = <0xe4078 0x4>, <0xe404 0x4>;
> +				reg = <0xe4078 0x4>, <0xe4074 0x4>;
>  				status = "okay";
>  			};
>  
> Want me to send a follow-up patch?

Nope, I squashed it in and pushed it out.

thx,

Jason.
