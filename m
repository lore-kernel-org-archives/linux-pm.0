From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpupower: fix breakage from libpci API change
Date: Wed, 29 Apr 2015 02:05:51 +0200
Message-ID: <1570425.exvS3HhT9c@vostro.rjw.lan>
References: <1428956641-7765-1-git-send-email-dev@lynxeye.de> <6742910.A5LcpWTI3L@skinner> <1430249209.10090.0.camel@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430249209.10090.0.camel@lynxeye.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 28, 2015 09:26:49 PM Lucas Stach wrote:
> So, who is going to pick up this patch?

Should be in the Linus' tree already, isn't it?

I pick up PM tools patches if ACKed by their respective maintainers as a rule.

turbostat is an exception.


> Am Dienstag, den 14.04.2015, 18:28 +0200 schrieb Thomas Renninger:
> > Hi,
> > 
> > On Monday, April 13, 2015 10:24:01 PM Lucas Stach wrote:
> > > libpci 3.3.0 introduced an additional member in the pci_filter struct
> > > which needs to be initialized to -1 to get the same behavior as before
> > > the API change.
> > Sounds not that clever, but there probably is a reason for this...
> > 
> > I am not that familiar with the pci lib and its recent changes, but
> > below patch looks reasonable.
> > 
> > Acked-by: Thomas Renninger <trenn@suse.de>
> > 
> > 
> > > The libpci internal helpers got updated accordingly,
> > > but as the cpupower pci helpers initialized the struct themselves the
> > > behavior changed.
> > > 
> > > Use the libpci helper pci_filter_init() to fix this and guard against
> > > similar breakages in the future.
> > > 
> > > This fixes probing of the AMD fam12h/14h cpuidle monitor on systems
> > > with libpci >= 3.3.0.
> > > 
> > > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > > ---
> > >  tools/power/cpupower/utils/helpers/pci.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/power/cpupower/utils/helpers/pci.c
> > > b/tools/power/cpupower/utils/helpers/pci.c index 9690798..8b27898 100644
> > > --- a/tools/power/cpupower/utils/helpers/pci.c
> > > +++ b/tools/power/cpupower/utils/helpers/pci.c
> > > @@ -25,14 +25,21 @@
> > >  struct pci_dev *pci_acc_init(struct pci_access **pacc, int domain, int bus,
> > > int slot, int func, int vendor, int dev)
> > >  {
> > > -	struct pci_filter filter_nb_link = { domain, bus, slot, func,
> > > -					     vendor, dev };
> > > +	struct pci_filter filter_nb_link;
> > >  	struct pci_dev *device;
> > > 
> > >  	*pacc = pci_alloc();
> > >  	if (*pacc == NULL)
> > >  		return NULL;
> > > 
> > > +	pci_filter_init(*pacc, &filter_nb_link);
> > > +	filter_nb_link.domain	= domain;
> > > +	filter_nb_link.bus	= bus;
> > > +	filter_nb_link.slot	= slot;
> > > +	filter_nb_link.func	= func;
> > > +	filter_nb_link.vendor	= vendor;
> > > +	filter_nb_link.device	= dev;
> > > +
> > >  	pci_init(*pacc);
> > >  	pci_scan_bus(*pacc);
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
