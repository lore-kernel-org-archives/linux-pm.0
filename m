From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 04/11] thermal: armada: Rationalize register accesses
Date: Mon, 18 Dec 2017 13:37:09 +0100
Message-ID: <20171218133709.24c49719@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-5-miquel.raynal@free-electrons.com>
        <20171216221838.v6gtaoqy2xhozapp@tarshish>
        <20171217220235.4uwy4nw77gf3kvfp@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171217220235.4uwy4nw77gf3kvfp@tarshish>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Dec 2017 00:02:35 +0200
Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:

> Hi Miquèl,
> 
> On Sun, Dec 17, 2017 at 12:18:38AM +0200, Baruch Siach wrote:
> > On Thu, Dec 14, 2017 at 11:30:04AM +0100, Miquel Raynal wrote:  
> > > Bindings were incomplete for a long time by only exposing one of
> > > the two available control registers. To ease the migration to the
> > > full bindings (already in use for the Armada 375 SoC), rename the
> > > pointers for clarification. This way, it will only be needed to
> > > add another pointer to access the other control register when the
> > > time comes.
> > > 
> > > This avoids dangerous situations where the offset 0 of the control
> > > area can be either one register or the other depending on the
> > > bindings used. After this change, device trees of other SoCs
> > > could be migrated to the "full" bindings if they may benefit from
> > > features from the unaccessible register, without any change in
> > > the driver.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---  
> > 
> > [...]
> >   
> > > +	/*
> > > +	 * Legacy DT bindings only described "control1" register
> > > (also referred
> > > +	 * as "control MSB" on old documentation). New bindings
> > > cover
> > > +	 * "control0/control LSB" and "control1/control MSB"
> > > registers within
> > > +	 * the same resource, which is then of size 8 instead of
> > > 4.
> > > +	 */
> > > +	if ((res->end - res->start) == LEGACY_CONTROL_MEM_LEN) {
> > > +		/* ->control0 unavailable in this configuration
> > > */
> > > +		priv->control1 = control +
> > > LEGACY_CONTROL1_OFFSET;
> > > +	} else {
> > > +		priv->control0 = control + CONTROL0_OFFSET;
> > > +		priv->control1 = control + CONTROL1_OFFSET;
> > > +	}  
> > 
> > I think we need to add a check here that the control registers area
> > size matches the expected value given the compatible string. In
> > case of mismatch probe should fail.  

Ok I will check here for the bindings used.

Still, in the a380_init() I will have to check if control0 is
valid or not because this function should handle both bindings.

> 
> One more thing. You should probably use resource_size() instead of
> open coding it. resource_size() does "res->end - res->start + 1". Are
> you sure your code is correct?

It is not regarding the implementation of resource_size() (which I'm
gonna use).

> 
> > >  	priv->data = (struct armada_thermal_data *)match->data;
> > >  	priv->data->init_sensor(pdev, priv);  
> 
> baruch
> 

Thank you,
Miquèl
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
