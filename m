From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Tue, 10 Nov 2015 10:30:51 -0800
Message-ID: <20151110183049.GB5240@localhost.localdomain>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
 <87d1vili9c.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdWSMsVZYF2jswCoRB217n_3OR8uikNtBYOfQHkQs3oWSA@mail.gmail.com>
 <CAPDyKFqW=PEiijHN8cPaLK8oPRn9WdAYsLug1dbMpitKmNNKjw@mail.gmail.com>
 <CAMuHMdX_mAd1PVv5_UCJJZ2U5EjYUbqQ36zaEgP5KdUuZiGQMQ@mail.gmail.com>
 <CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35084 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbKJSaz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 13:30:55 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?utf-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi,

On Tue, Nov 10, 2015 at 02:00:38PM +0100, Ulf Hansson wrote:
> +Rafael, Alan
> 
> On 10 November 2015 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Ulf,
> >
> > On Tue, Nov 10, 2015 at 10:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 10 November 2015 at 09:18, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> On Tue, Nov 10, 2015 at 3:12 AM, Kuninori Morimoto
> >>> <kuninori.morimoto.gx@renesas.com> wrote:
> >>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>>
> >>>> It is using pm_runtime_get_sync() on probe(). Let's use
> >>>> pm_runtime_put_sync() instead of pm_runtime_put(). Otherwise thermal
> >>>> sensor doesn't work after unbind/re-bind
> >>>>
> >>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>> ---
> >>>>  drivers/thermal/rcar_thermal.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> >>>> index 13d01ed..f7cf2d7 100644
> >>>> --- a/drivers/thermal/rcar_thermal.c
> >>>> +++ b/drivers/thermal/rcar_thermal.c
> >>>> @@ -373,7 +373,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
> >>>>                 thermal_zone_device_unregister(priv->zone);
> >>>>         }
> >>>>
> >>>> -       pm_runtime_put(dev);
> >>>> +       pm_runtime_put_sync(dev);
> >>>>         pm_runtime_disable(dev);
> >>
> >> For the reasons explained by Geert, this is to me also a "workaround".
> >>
> >> I would replace pm_runtime_put() and pm_runtime_disable() with a call
> >> to pm_runtime_force_suspend().
> >>
> >> In that way, you will make sure you device get runtime suspended
> >> (clock domain will gate the clock). Additionally, the runtime PM
> >> status will properly reflect the status of the device.
> >
> > That still sounds like a workaround to me, which we have to apply to all
> > drivers relying on Runtime PM?
> 
> Definitely not all drivers, but those that runs pm_runtime_get_sync()
> during ->probe() and expects the ->runtime_resume() callback to always
> be invoked because of that. I guess we need to check upon which
> drivers that may suffer from this.
> 
> I wouldn't be surprised if at least a subset of those cases we find,
> are poorly designed from PM point of view and won't even probe
> successfully unless CONFIG_PM is set. Whatever that means...


Yeah, if it is the case this is a bug in runtime pm core, I would prefer
this to be properly fixed, and not only this driver benefits of it.

Rafael? Any thoughts?

BR,

Eduardo Valentin
