From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190
 battery charger
Date: Thu, 17 Aug 2017 17:16:48 -0700
Message-ID: <20170818001648.GD3930@atomide.com>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net>
 <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
 <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com>
 <20170812164233.won7fairxmrnblps@earth>
 <CAKvHMgR+GxSqhy+iwdYmku2600HzoF__oXV7_w72ZJg-aK7O-Q@mail.gmail.com>
 <20170816154701.GR3930@atomide.com>
 <CAKvHMgTvVMsvmyi0o89m1SfS9A4U1GbNuU05Tkt6C0ARR9NyWw@mail.gmail.com>
 <20170816210644.GX3930@atomide.com>
 <CAKvHMgTJjTxffoP4Kt=KzGvCQ-BihLeQn3i4TaF4OBSXV7i6TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgTJjTxffoP4Kt=KzGvCQ-BihLeQn3i4TaF4OBSXV7i6TA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

* Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> [170816 14:16]:
> On Wed, Aug 16, 2017 at 2:06 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > If the kernel does not need to do anything about it, how about
> > just leave it out of the binding docs then?
> 
> It seemed useful to document the OTG pin DT config for boards that
> have it wired to a gpio... Is that not wise?

Well maybe just add a comment to the driver about it until we know
how we want to handle it?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
