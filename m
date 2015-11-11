From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Wed, 11 Nov 2015 01:11:33 +0100
Message-ID: <2630860.ogDBScTvgp@vostro.rjw.lan>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com> <CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com> <20151110183049.GB5240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63882 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750950AbbKJXmP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 18:42:15 -0500
In-Reply-To: <20151110183049.GB5240@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?utf-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>

On Tuesday, November 10, 2015 10:30:51 AM Eduardo Valentin wrote:
> Hi,
> 
> On Tue, Nov 10, 2015 at 02:00:38PM +0100, Ulf Hansson wrote:
> > +Rafael, Alan
> > 
> > On 10 November 2015 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Hi Ulf,
> > >
> > > On Tue, Nov 10, 2015 at 10:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >> On 10 November 2015 at 09:18, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>> On Tue, Nov 10, 2015 at 3:12 AM, Kuninori Morimoto
> > >>> <kuninori.morimoto.gx@renesas.com> wrote:
> > >>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >>>>
> > >>>> It is using pm_runtime_get_sync() on probe(). Let's use
> > >>>> pm_runtime_put_sync() instead of pm_runtime_put(). Otherwise thermal
> > >>>> sensor doesn't work after unbind/re-bind
> > >>>>
> > >>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >>>> ---
> > >>>>  drivers/thermal/rcar_thermal.c | 2 +-
> > >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > >>>> index 13d01ed..f7cf2d7 100644
> > >>>> --- a/drivers/thermal/rcar_thermal.c
> > >>>> +++ b/drivers/thermal/rcar_thermal.c
> > >>>> @@ -373,7 +373,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
> > >>>>                 thermal_zone_device_unregister(priv->zone);
> > >>>>         }
> > >>>>
> > >>>> -       pm_runtime_put(dev);
> > >>>> +       pm_runtime_put_sync(dev);
> > >>>>         pm_runtime_disable(dev);
> > >>
> > >> For the reasons explained by Geert, this is to me also a "workaround".
> > >>
> > >> I would replace pm_runtime_put() and pm_runtime_disable() with a call
> > >> to pm_runtime_force_suspend().
> > >>
> > >> In that way, you will make sure you device get runtime suspended
> > >> (clock domain will gate the clock). Additionally, the runtime PM
> > >> status will properly reflect the status of the device.
> > >
> > > That still sounds like a workaround to me, which we have to apply to all
> > > drivers relying on Runtime PM?
> > 
> > Definitely not all drivers, but those that runs pm_runtime_get_sync()
> > during ->probe() and expects the ->runtime_resume() callback to always
> > be invoked because of that. I guess we need to check upon which
> > drivers that may suffer from this.

Generally, calling pm_runtime_get_sync() in ->probe() and expecting the
driver's ->runtime_resume() to be always be invoked is a mistake.  I know
nothing about any guarantees that this will always happen.

If you want your ->runtime_resume() to be invoked no matter what, you really
need to figure out what the current state of things is, change it to your
expectations with runtime PM disabled and enable runtime PM after that. 

Still, that also needs to be done with care as the bus type/PM domain may be
affected by it.

> > 
> > I wouldn't be surprised if at least a subset of those cases we find,
> > are poorly designed from PM point of view and won't even probe
> > successfully unless CONFIG_PM is set. Whatever that means...
> 
> 
> Yeah, if it is the case this is a bug in runtime pm core, I would prefer
> this to be properly fixed, and not only this driver benefits of it.
> 
> Rafael? Any thoughts?

First off, it's not a bug in the runtime PM core, as that code is agnostic
to what should or should not happen to devices during ->probe, ->remove etc.

Second, as I said above (and elsewhere), the driver is just a piece of the
puzzle in many cases.

Thanks,
Rafael

