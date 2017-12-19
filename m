From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 01/12] dt-bindings: thermal: Describe Armada AP806
 and CP110
Date: Tue, 19 Dec 2017 08:44:56 +0100
Message-ID: <20171219084456.0b8a75a8@xps13>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
        <20171218143643.7714-2-miquel.raynal@free-electrons.com>
        <20171218203324.ftyqrgjawkujvhmn@tarshish>
        <20171219014320.182d2522@xps13>
        <20171219060918.nr4ojwpmqf6ju6od@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171219060918.nr4ojwpmqf6ju6od-MwjkAAnuF3khR1HGirfZ1z4kX+cae0hd@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Baruch,

On Tue, 19 Dec 2017 08:09:18 +0200
Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:

> Hi Miquèl,
> 
> On Tue, Dec 19, 2017 at 01:43:20AM +0100, Miquel RAYNAL wrote:
> > On Mon, 18 Dec 2017 22:33:24 +0200
> > Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:  
> > > On Mon, Dec 18, 2017 at 03:36:32PM +0100, Miquel Raynal wrote:  
> > > > From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > > > 
> > > > Add compatible strings for AP806 and CP110 that are part of the
> > > > Armada 8k/7k line of SoCs.
> > > > 
> > > > Add a note on the differences in the size of the control area in
> > > > different bindings. This is an existing difference between the
> > > > Armada 375 binding and the other boards already supported. The
> > > > new AP806 and CP110 bindings are similar to the existing Armada
> > > > 375 in this regard.
> > > > 
> > > > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > > > [<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: reword, additional details]
> > > > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > > ---
> > > >  .../devicetree/bindings/thermal/armada-thermal.txt | 24
> > > > +++++++++++++++++----- 1 file changed, 19 insertions(+), 5
> > > > deletions(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > index 24aacf8948c5..9b7b2c03cc6f 100644 ---
> > > > a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > +++
> > > > b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > @@ -7,17 +7,31 @@ Required properties:
> > > > marvell,armada375-thermal marvell,armada380-thermal
> > > > marvell,armadaxp-thermal
> > > > +		marvell,armada-ap806-thermal
> > > > +		marvell,armada-cp110-thermal
> > > >  
> > > >  - reg:		Device's register space.
> > > >  		Two entries are expected, see the examples
> > > > below.
> > > > -		The first one is required for the sensor
> > > > register;
> > > > -		the second one is required for the control
> > > > register
> > > > -		to be used for sensor initialization (a.k.a.
> > > > calibration).
> > > > +		The first one points to the status register
> > > > (4B).
> > > > +		The second one points to the control registers
> > > > (8B).
> > > > +		Note: with legacy bindings, the second entry
> > > > pointed
> > > > +		only to the so called "control MSB" ("control
> > > > 1"), was
> > > > +		4B wide and did not let the possibility to
> > > > reach the
> > > > +		"control LSB" ("control 0") register. This is
> > > > only
> > > > +		allowed for compatibility reasons in Armada
> > > > +		370/375/38x/XP DT nodes.    
> > > 
> > > "allowed" is not the right term, IMO. Legacy compatibles MUST
> > > point to the MSB control register to preserve compatibility with
> > > existing DTs.
> > > 
> > > The original patch had a list of legacy and non-legacy
> > > compatibles. I think we need to keep them.  
> > 
> > Maybe I should reword this paragraph because we both agree on the
> > meaning:
> > 
> > "
> > Note: Legacy bindings are only supported with Armada 370/375/38x/XP
> > compatibles. The second memory resource entry only points to
> > "control MSB/control 1", is 4 bytes wide and is preventing any
> > access to "control LSB/control 0".
> > "
> > 
> > Does this sounds better to you?  
> 
> I think we need to explicitly list the affected compatible strings.
> Something like:

I thought listing the SoCs directly would have been acceptable
but I am really not against listing them explicitly :)

> 
>   For backwards compatibility reasons, the compatibles 
>   marvell,armada370-thermal, marvell,armada380-thermal, and 
>   marvell,armadaxp-thermal must point to "control MSB/control 1",
> with size of 4. All other compatibles must point to "control
> LSB/control 0" with size of 8.
> 
> But I think you are right that we can use the size of the control
> registers to tell whether e.g. marvell,armada380-thermal is of the
> old binding of the new one. So maybe the "allow" language is more
> correct. But let's make it explicit to avoid any doubt. How about:
> 
>   The compatibles marvell,armada370-thermal,
> marvell,armada380-thermal, and marvell,armadaxp-thermal must point to
> "control MSB/control 1", with size of 4 (deprecated binding), or
> point to "control LSB/control 0" with size of 8 (current binding).
> All other compatibles must point to "control LSB/control 0" with size
> of 8.

This version looks good to me!

Thank you,
Miquèl

> 
> baruch
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
