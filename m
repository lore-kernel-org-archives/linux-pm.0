From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 31 Oct 2016 19:25:58 +0800
Message-ID: <CAMz4ku++FGbTyA=1Nen+XzYicBTDVJzE5a5rPdTrO8m9Zjc+WA@mail.gmail.com>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <20161028170302.au73yu2fplfig36a@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028170302.au73yu2fplfig36a@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: NeilBrown <neilb@suse.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, dev
List-Id: linux-pm@vger.kernel.org

On 29 October 2016 at 01:03, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 28, 2016 at 08:51:41PM +0800, Baolin Wang wrote:
>> On 28 October 2016 at 06:00, NeilBrown <neilb@suse.com> wrote:
>
>> > 1/ I think we agreed that it doesn't make sense for there to be
>> >  two chargers registered in a system.
>
>> Yes, until now...
>
>> >  However usb_charger_register() still allows that, and assigns
>> >  and arbitrary name to each based on discovery order.
>> >  This *cannot* make sense.
>
>> Fine, I can change that to allow only one charger to register.
>
> Yeah, it's a reasonable change.  I'm not sure the prior discussion was
> 100% conclusive on the issue (I remember there being some debate about
> leaving things there to avoid any need for future refactoring to touch
> the interface).

I think we should leave these things to avoid refactoring in future.

>
>> > 2/ Why do you have usb_charger_set_current()??
>> >   No code ever calls it.
>> >   This updates the min and max current which are defined in a
>> >   standard.  It never makes sense to change the min and max
>> >   for a particular cable type.
>
>> Mark, do we have some scenarios which want to change the current
>> limitation? If not, okay, I agree with you to remove this function.
>
> I'm not aware of any, we can always add it back if the need arises.

OK.

>
>> >  Related:  I don't like charger_type_show().  I don't think
>> >  the usb-charger should export that information to user-space because
>> >  extcon already does that, and duplication is confusing and pointless.
>
>> I think we should combine all charger related information into one
>> place for user. Moreover if we don't get charger type from extcon, we
>> should also need one place to export the charger type.
>
> I had also thought there was some software negotation as well as the
> physical charger in cases where the device is plugged into an active
> host?  I could be wrong.
>
>> > 5/ There is no convincing example usage of this framework.
>> >   wm8931x_power.c just scratches the surface.
>> >   If it is so good, it should be easy to convert a lot of other
>> >   drivers over to it.  If you did that it would be much easier
>> >   to see how it works and what the strengths/weaknesses were.
>
>> Jun have send out one patchset[1] based on my patchset, and he tested
>> mypatchset. Thanks for your comments.
>> [1]http://www.spinics.net/lists/linux-usb/msg139809.html
>
> I think it's a good idea to pick up Jun's patches into your patch set,
> that way Jun doesn't need to rebase and it might help with review of
> your patches too.

Yes, I think so. I will ask for Jun's help.


-- 
Baolin.wang
Best Regards
