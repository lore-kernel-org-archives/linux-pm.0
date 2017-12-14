From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 06/11] thermal: armada: Add support for Armada CP110
Date: Thu, 14 Dec 2017 13:24:20 +0100
Message-ID: <20171214132420.20de4c64@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-7-miquel.raynal@free-electrons.com>
        <87tvwto96y.fsf@free-electrons.com>
        <20171214123301.1729df4f@xps13>
        <87a7ylo803.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87a7ylo803.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 14 Dec 2017 12:37:32 +0100
Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Miquel,
>  
>  On jeu., déc. 14 2017, Miquel RAYNAL
> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > On Thu, 14 Dec 2017 12:11:49 +0100
> > Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >  
> >> Hi Miquel,
> >>  
> >>  On jeu., déc. 14 2017, Miquel Raynal
> >> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >>   
> >> > From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> >> >
> >> > The CP110 component is integrated in the Armada 8k and 7k lines
> >> > of processors.
> >> >
> >> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> >> > [<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: renamed the register
> >> > pointers]    
> >> 
> >> Actually you did more thant this see below
> >> 
> >>   
> >> > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> > ---
> >> >  drivers/thermal/armada_thermal.c | 30
> >> > ++++++++++++++++++++++++------ 1 file changed, 24 insertions(+),
> >> > 6 deletions(-)
> >> >
> >> > diff --git a/drivers/thermal/armada_thermal.c
> >> > b/drivers/thermal/armada_thermal.c index
> >> > 279d01937bb8..f5c911524656 100644 ---
> >> > a/drivers/thermal/armada_thermal.c +++
> >> > b/drivers/thermal/armada_thermal.c @@ -37,7 +37,6 @@
> >> >  #define A375_UNIT_CONTROL_MASK		0x7
> >> >  #define A375_READOUT_INVERT		BIT(15)
> >> >  #define A375_HW_RESETn			BIT(8)
> >> > -#define A380_HW_RESET			BIT(8)
> >> >  
> >> >  /* Legacy bindings */
> >> >  #define LEGACY_CONTROL_MEM_LEN		0x4
> >> > @@ -52,6 +51,10 @@
> >> >  #define CONTROL0_TSEN_RESET		BIT(1)
> >> >  #define CONTROL0_TSEN_ENABLE		BIT(2)
> >> >  
> >> > +/* EXT_TSEN refers to the external temperature sensors, out of
> >> > the AP */ +#define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
> >> > +#define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)    
> >> You added or rename these values
> >>   
> >> > +
> >> >  struct armada_thermal_data;
> >> >  
> >> >  /* Marvell EBU Thermal Sensor Dev Structure */
> >> > @@ -153,11 +156,10 @@ static void armada380_init_sensor(struct
> >> > platform_device *pdev, u32 reg = readl_relaxed(priv->control1);
> >> >  
> >> >  	/* Reset hardware once */
> >> > -	if (!(reg & A380_HW_RESET)) {
> >> > -		reg |= A380_HW_RESET;
> >> > -		writel(reg, priv->control1);
> >> > -		msleep(10);
> >> > -	}
> >> > +	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
> >> > +	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
> >> > +	writel(reg, priv->control1);    
> >> 
> >> And here you modified the behavior of this function.
> >> Did you checked that it is valid for Armada 38x?  
> >
> > There is nothing about it the documentation and anyway this register
> > can be accessed later, so writing it is harmless ayway.
> >  
> >> 
> >> Given the comment we had, I thought we should not do anything if
> >> CONTROL1_EXT_TSEN_HW_RESETn was not set.  
> >
> > That is the opposite, if it is not set (ie. reset is active), you
> > have to set it (reset is then disabled).  
> 
> Actually I was concerned by the "once" for me it means "only one
> time", but maybe it just meant it was useless to reset it again but
> not harmful.

This:

    reg |= CONTROL1_EXT_TSEN_HW_RESETn;

does not reset the IP, instead it cancels the reset, if one is
happening. So no, doing it unconditionally is not harmful.

Miquèl


> 
> Gregory
> 
> >  
> >> 
> >> By the way, if the new sequence is valid, this comment should be
> >> removed or at least updated.  
> >
> > That's right, I will in v4.
> >
> > Thanks for reviewing,
> > Miquèl
> >
> >  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
