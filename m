From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Thu, 22 Nov 2012 00:02:47 +0900
Message-ID: <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com> <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival> <50ACB59B.4090404@iki.fi> <20121121114018.GA31576@avionic-0098.adnet.avionic-design.de>
 <50ACC341.3090204@ti.com> <20121121130039.GA12191@avionic-0098.adnet.avionic-design.de>
 <50ACD7DC.5060405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50ACD7DC.5060405-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Tomi Valkeinen <tomba-X3B1VOXEql0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Mmmm so maybe I am misinterpreting things, but it looks like we
have just buried the power sequences here, haven't we?

Alex.

On Wed, Nov 21, 2012 at 10:32 PM, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> wrote:
> On 2012-11-21 15:00, Thierry Reding wrote:
>> On Wed, Nov 21, 2012 at 02:04:17PM +0200, Tomi Valkeinen wrote:
>>> On 2012-11-21 13:40, Thierry Reding wrote:
>>>> On Wed, Nov 21, 2012 at 01:06:03PM +0200, Tomi Valkeinen wrote:
>>>
>>> (sorry for bouncing back and forth with my private and my @ti addresses.
>>> I can't find an option in thunderbird to only use one sender address,
>>> and I always forget to change it when responding...)
>>>
>>>>> My suggestion would be to go forward with an in-driver solution, and
>>>>> look at the DT based solution later if we are seeing an increasing bloat
>>>>> in the drivers.
>>>>
>>>> Assuming we go with your approach, what's the plan? We're actually
>>>> facing this problem right now for Tegra. Basically we have a DRM driver
>>>> that can drive the panel, but we're still missing a way to hook up the
>>>> backlight and panel enabling code. So we effectively can't support any
>>>> of the LVDS devices out there without this series.
>>>
>>> Could you describe the hardware setup you have related to the LCD and
>>> backlight? Is it a public board with public schematics?
>>
>> I don't think any of the schematics are public. The Tamonten Evaluation
>> Carrier is available publicly from our website and the schematics are
>> available on demand as well. If required I can probably arrange to send
>> you a copy.
>
> No need, I think your answer below is enough.
>
>>> I've understood that you don't have anything special in your board, just
>>> an LCD and a backlight, and the power sequences are related to powering
>>> up the LCD and the backlight, without anything board specific. If so,
>>> there's no need for board specific code, but just improving the panel
>>> and backlight drivers to support the models you use.
>>
>> Correct. Basically we have two GPIOs that each enable the panel or the
>> backlight respectively and one PWM to control the brightness. Are the
>
> The panel GPIO goes to the panel hardware device, and enables the panel?
> And similarly for the PWM GPIO, it goes to the PWM hardware device? Just
> making sure there are no other components involved.
>
>> panel drivers that you refer to those in drivers/video? I'm not sure if
>> adding more ad-hoc drivers there just to move them to a generic
>> framework in the next cycle is a good idea. I'd rather spend some time
>> on helping to get the framework right and have drivers for that instead.
>
> We have panel drivers for omap in drivers/video/omap2/displays/. I'm not
> sure if other platforms have their own versions of panel drivers, but
> probably adding a simple panel driver system for a platform would not be
> too difficult. It could even be quite hardcoded, i.e. embedded directly
> into the display subsystem driver, just to get something working until
> the common panel framework is available.
>
> Yes, I agree it's not good idea to add more platform specific panel
> drivers. But it's unclear when CPF will be merged, so if you need to get
> the panel working now, I don't see a simple ad-hoc driver as too
> horrible. But, of course, I'm not the one making the decision whether to
> merge or not =).
>
>> From what I understand by looking at the OMAP display drivers, they also
>> provide the timings for the displays. Steffen's videomode helpers can be
>> used to represent these easily in DT, but I suppose if all of those per-
>
> Right. Note that I didn't present omap panel drivers as perfect
> examples, just examples =).
>
>> panel specifics are represented in the drivers then that won't be needed
>> anymore either.
>
> Yes, for most panels with just one native mode and nothing else, the
> panel driver can contain the timings.
>
> However, this subject has been discussed earlier a few times. If the
> panel in question doesn't need any special power-on/off sequences, just,
> perhaps, one gpio or such, we could still use DT video modes. This would
> simplify the cases where you have lots of different very simple panels.
>
> Obviously the same questions apply to DT video modes than to the power
> sequences, and while I do think it's better to handle the timings inside
> the driver, I'm not too much against video timings in DT. The reason
> being that the video modes are quite clear, simple and stable data,
> versus the much more complex and open-ended power sequences.
>
>>> I don't see any problem with adding small Tegra specific panel drivers
>>> for the time being, with the intention of converting to common panel
>>> framework when that's available.
>>
>> I can take a look at how such a driver could be implemented, but again,
>
> Don't look at the mainline omap panel drivers, at least not too closely
> =). They contain hackery that will be cleaned up with CPF.
>
> I think there are two methods to implements simple panel drivers:
>
> The hardcoded one, where the display subsystem driver manages a few
> different panel models. This is obviously not very expandable or
> "correct", but should probably work just fine for a few models, until
> CPF is usable.
>
> Something like CPF will have: have the panel device/driver as a platform
> device/driver, which will register itself to the display subsystem. And
> with "itself" I mean some kind of struct panel_entity, with a few ops
> implemented by the panel driver.
>
> Well, this goes a bit out of subject. If you want to discuss panel
> drivers more, please start a new thread. Laurent's upcoming CPF v2
> should give you good ideas what the model will be.
>
>  Tomi
>
>
