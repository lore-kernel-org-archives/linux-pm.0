From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v4 04/12] thermal: armada: Clarify control registers
 accesses
Date: Tue, 19 Dec 2017 07:51:54 +0200
Message-ID: <20171219055154.f23leaob3zndmmqo@sapphire.tkos.co.il>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-5-miquel.raynal@free-electrons.com>
 <20171218203542.msnswjqeyuudyusz@tarshish>
 <20171219013233.319365c4@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171219013233.319365c4@xps13>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Miquèl,

On Tue, Dec 19, 2017 at 01:32:33AM +0100, Miquel RAYNAL wrote:
> On Mon, 18 Dec 2017 22:35:42 +0200
> Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> > On Mon, Dec 18, 2017 at 03:36:35PM +0100, Miquel Raynal wrote:
> > > Bindings were incomplete for a long time by only exposing one of
> > > the two available control registers. To ease the migration to the
> > > full bindings (already in use for the Armada 375 SoC), rename the
> > > pointers for clarification. This way, it will only be needed to add
> > > another pointer to access the other control register when the time
> > > comes.
> > > 
> > > This avoids dangerous situations where the offset 0 of the control
> > > area can be either one register or the other depending on the
> > > bindings used. After this change, device trees of other SoCs could
> > > be migrated to the "full" bindings if they may benefit from
> > > features from the unaccessible register, without any change in the
> > > driver.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
> > > +	 * the same resource, which is then of size 8 instead of 4.
> > > +	 */
> > > +	if (resource_size(res) == LEGACY_CONTROL_MEM_LEN) {
> > > +		/* ->control0 unavailable in this configuration */
> > > +		priv->control1 = control + LEGACY_CONTROL1_OFFSET;
> > > +	} else {
> > > +		priv->control0 = control + CONTROL0_OFFSET;
> > > +		priv->control1 = control + CONTROL1_OFFSET;
> > > +	}  
> > 
> > The needs_control0 field that you mentioned in the cover page is
> > missing here.
> 
> Yes, at this point nobody actually *needs* control0 so the limitation
> is added with the patch that introduce ap806 support as it is the first
> compatible that needs both control0 and control1 to work correctly.
> Does this bother you?

No. It is just that we agreed to have a verification here that the size of the 
control registers resource matches the binding. I thought that the 
needs_control0 field that you mention in the cover page is meant to implement 
that. But I'm not sure all that is strictly necessary. It would just make sure 
that no one introduces a DT with the wrong resource size.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
