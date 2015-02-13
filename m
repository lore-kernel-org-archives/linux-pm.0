From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/5] pm: domains: quieten down generic pm domains
Date: Fri, 13 Feb 2015 11:54:08 +0000
Message-ID: <20150213115408.GA25698@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <10021780.rnCkCYmgZH@vostro.rjw.lan>
 <CAPDyKFpKnhcttY-BWDEG=XTYsKHro0t5G7YBao-+F=o3ez3grA@mail.gmail.com>
 <1412882.XTDX0QPJ6V@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412882.XTDX0QPJ6V-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 05, 2014 at 12:36:25AM +0200, Rafael J. Wysocki wrote:
> On Friday, May 02, 2014 11:24:45 AM Ulf Hansson wrote:
> > On 1 May 2014 01:46, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> > > On Sunday, April 27, 2014 02:28:50 PM Russell King wrote:
> > >> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > >
> > > Acked-by: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> > >
> > > Since you need this one and [2/5] for the rest of the patchset, please feel
> > > free to take them through your tree if that's convenient.
> > 
> > Unless it complicates things for Russell, I would prefer if this could
> > go via Rafael's tree.
> > 
> > I have a quite big patchset for the PM domain, it would help me if I
> > have a single point to base my work upon.
> 
> No problem for me, but I'm not sure about what Russell things.

Well, it seems nothing happened with these patches, and they're still
something I have (and I've just updated them to changes in 3.19.)

What are we going to do about them?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
