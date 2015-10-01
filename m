From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/2] PM / sleep: Go direct_complete if driver has no callbacks
Date: Fri, 02 Oct 2015 00:23:16 +0200
Message-ID: <2611471.DTHhsJrc8q@vostro.rjw.lan>
References: <1443607098-26666-1-git-send-email-tomeu.vizoso@collabora.com> <13396826.8glsaARCUj@vostro.rjw.lan> <CAPDyKFqGL_=wRauQhXO3rgjc4-UgwJQ0xwgdyQa9LsR98qYstA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51567 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750789AbbJAVyy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 17:54:54 -0400
In-Reply-To: <CAPDyKFqGL_=wRauQhXO3rgjc4-UgwJQ0xwgdyQa9LsR98qYstA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On Thursday, October 01, 2015 11:04:17 AM Ulf Hansson wrote:
> On 30 September 2015 at 23:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, September 30, 2015 03:59:48 PM Tomeu Vizoso wrote:
> >> On 30 September 2015 at 15:05, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Wednesday, September 30, 2015 01:33:29 PM Ulf Hansson wrote:
> >> >> On 30 September 2015 at 11:58, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> >> >> > @@ -1369,6 +1372,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
> >> >> >
> >> >> >         genpd_free_dev_data(dev, gpd_data);
> >> >> >
> >> >> > +       device_check_pm_callbacks(dev);
> >> >> > +
> >> >> >         return 0;
> >> >>
> >> >> I can't tell whether this is an interesting feature to use for devices
> >> >> that gets attached to the ACPI PM domain. Although, you currently
> >> >> doesn't deal with that case, and too me I think this looks a bit
> >> >> weird/unsymmetrical.
> >> >
> >> > Good point.
> >> >
> >> > It needs to be done in every situation where a PM domain is or can be used.
> >> >
> >> > I guess we might require all PM domains to be attached to devices after
> >> > a successful probe at the latest (no PM domains should be attached/detached
> >> > after probe succeeds IOW), in which case it should be sufficient to do the
> >> > device_check_pm_callbacks() thing each time after probe successds.
> >> >
> >> > Thoughts?
> >>
> >> Sound good to me. How were you thinking of doing that? Manually
> >> checking that that's currently the case and adding a WARN() if a
> >> pm_domain is attached to a device that has been probed already?
> >
> > I guess we need a function for setting/clearing the pm_domain pointer that
> > will check whether or not the device has been probed and WARN() in that case.
> >
> > Then, convert all users of PM domains to use that function instead of
> > manipulating the pointer directly.
> 
> Why would ever a device be fully probed without first having its PM
> domain pointer assigned?
> 
> To me that wouldn't even work, as the device would rather depend on
> that the PM domain is power up to succeed being probed (at least in
> general case), and unless the PM domain pointer is set we can't
> control that.

That generally is the case, but then I can imagine a situation in which setting
the pm_domain pointer after probe may work for somebody and my point is that
we should enforce things that we are going to rely on for correctness rather
then hope that everybody will do them just because they make sense.

Thanks,
Rafael

