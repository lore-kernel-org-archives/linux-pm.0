From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Fri, 8 Sep 2017 11:15:53 -0700
Message-ID: <CAKdAkRRwATwfVXA4HN-cOR-FBjt7BKHdY4Bu1SSZh3QrBVgjLA@mail.gmail.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <20161119034158.GA26405@localhost.localdomain> <20161119053014.GA58324@google.com>
 <1479801145.2360.24.camel@intel.com> <20161122110045.GB2018@localhost.localdomain>
 <20161122222712.GA53509@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122222712.GA53509@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Guenter Roeck <groeck@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 2:27 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Tue, Nov 22, 2016 at 03:00:47AM -0800, Eduardo Valentin wrote:
>> On Tue, Nov 22, 2016 at 03:52:25PM +0800, Zhang Rui wrote:
>> > On Fri, 2016-11-18 at 21:30 -0800, Brian Norris wrote:
>> > > On Fri, Nov 18, 2016 at 07:41:59PM -0800, Eduardo Valentin wrote:
>> > > > I would prefer we consider the patch I sent
>> > > > some time ago:
>> > > > https://patchwork.kernel.org/patch/7876381/
>> > > Honestly I didn't look that deeply into the framework here (and I
>> > > also
>> > > don't use CONFIG_THERMAL_EMULATION), I was just fixing something that
>> > > was obviously wrong.
>>
>> Yeah, but that is why we need people to look the code considering all
>> features. :-)
>
> Well, there are bugfixes and there are features. My patch fixed the bug
> in the simplest way possible; it didn't break CONFIG_THERMAL_EMULATION
> any further than it already was, and it'll still work if get_temp()
> doesn't return an error.
>
> I'd say your patch is essentially adding a feature, and IMO that's not
> the best way to fix a bug. You can fix the bug and *then* add the
> feature.
>
> Anyway, I'm not going to tell you how to run your subsystem. If your
> patch goes through, that's probably just as well.
>
> [...]
>
>> > hmmm, I forgot why I missed this one in the end.
>> > Eduardo,
>> > would you mind refresh and resend the patch?
>>
>> Yeah sure. I have at least three extra patch sets on thermal core on
>> my queue. But I would like to get first the thermal sysfs reorg in
>> first. This fix is one of the changes that will go on top of the thermal
>> sysfs reorg.
>
> So, the bugfix depends on feature work? I guess I'll check back in
> another year to see what the status of the bugfix is :)

Not quite a year, but the status is still the same ;)

By the way, I do not quite understand why we want to mess with
emulated temperature when hardware reports errors. I'd say when
get_temp() fails we need to let upper layers know right away. Only
when we read temperature successfully and we are sure that the
temperature is not above critical level we should allow reporting
emulated value.

Can we please apply the patch?

Thanks.

-- 
Dmitry
