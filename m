From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Wed, 11 Nov 2015 12:03:52 +0100
Message-ID: <CAPDyKFpzHjHfJjxupaSDabmSQzCD8M9enAFQDe0NnMn6-9g0pg@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdX_mAd1PVv5_UCJJZ2U5EjYUbqQ36zaEgP5KdUuZiGQMQ@mail.gmail.com>
	<CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com>
	<2060819.A5Wq9BbBOH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36566 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbKKLDx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 06:03:53 -0500
Received: by ykdr82 with SMTP id r82so42439600ykd.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 03:03:52 -0800 (PST)
In-Reply-To: <2060819.A5Wq9BbBOH@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>

On 11 November 2015 at 00:57, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, November 10, 2015 02:00:38 PM Ulf Hansson wrote:
>> +Rafael, Alan
>>
>> On 10 November 2015 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > Hi Ulf,
>> >
>
> [cut]
>
>> >>
>> >> The problem is that the runtime PM status of the device isn't
>> >> correctly updated at ->remove(). The effect is that the the
>> >> pm_runtime_get_sync() in ->probe() at re-bind will *not* trigger the
>> >> ->runtime_resume() callbacks to be invoked, as the runtime PM core
>> >> believes the device is already runtime resumed.
>> >
>> > So that's where it should be fixed?
>>
>> That would be a more generic approach, although I am not sure how the
>> driver/PM core should be able to take the correct decision in this
>> phase. Devices may be runtime PM managed also without a driver bound.
>>
>> Perhaps when __device_release_driver() finds a bounded driver for the
>> device, it could after all actions been performed to unbind the
>> driver, check if runtime PM is enabled. If it isn't, it could set the
>> runtime PM status to suspended!?
>>
>> I have no idea if that would introduce other issues as it would kind
>> of force the runtime PM status of the device to suspend, without
>> actually knowing if it's the correct thing to do.
>
> IMO, that needs to depend on the bus type.  If the bus type has a way
> to manage PM for devices without drivers, it should be allowed to do so.

By following my suggestion above, we would allow the bus/driver's
->remove() to manage whether runtime PM should be enabled/disabled for
the device, before __device_release_driver() checks that.
Don't you think that the driver core could rely on that information?

I realize that it would be a kind of policy decision for runtime PM,
but it's quite similar as when register/unregister devices when we set
the runtime PM status to suspended.

If you don't think this is a good idea, I guess we need to deal with
this from subsystem level code somehow instead.

>
> Of course, the platform bus type is somewhat special in that respect,
> but it looks like we simply need some sort of a convention in there too
> (the expectations should be the same for everybody).
>
> Thanks,
> Rafael
>

Kind regards
Uffe
