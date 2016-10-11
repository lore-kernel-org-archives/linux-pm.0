From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 2/9] hwmon: (core) New hwmon registration API
Date: Tue, 11 Oct 2016 14:29:17 +0200
Message-ID: <20161011142917.26482970@endymion>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
        <1469417552-9749-3-git-send-email-linux@roeck-us.net>
        <1475570759.3052.22.camel@chaos.suse>
        <20161004193713.GA26304@roeck-us.net>
        <20161007143213.0ba633fe@endymion>
        <20161010234822.GA11563@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbcJKM32 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Oct 2016 08:29:28 -0400
In-Reply-To: <20161010234822.GA11563@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, 10 Oct 2016 16:48:22 -0700, Guenter Roeck wrote:
> On Fri, Oct 07, 2016 at 02:32:13PM +0200, Jean Delvare wrote:
> > On Tue, 4 Oct 2016 12:37:13 -0700, Guenter Roeck wrote:
> > > On Tue, Oct 04, 2016 at 10:45:59AM +0200, Jean Delvare wrote:
> > > > May I ask if any other subsystem is already doing anything like that?
> > > > 
> > > Depends what you mean with "anything like that". The API is inspired by
> > > the iio API and a little by the thermal API. The details are probably
> > > unique, though.
> > 
> > I meant the idea of describing the device capabilities and letting the
> > core code generate the device attributes (or anything else) based on
> > that data. The benefits are obvious, but it has a complexity and
> > run-time cost so I am wondering how popular this approach is.
> 
> The goal of this patch series was to provide abstraction between driver
> and userspace ABI. I think this is quite common in the kernel.

Yes, you are right. I am so used to the (wrong) way hwmon did that I
did not realize all other subsystems already provided some form of
abstraction for their device drivers. Even i2c does, so I should know.

> I am not sure I undersatand the run-time cost concern. The main run-time
> cost occurs during device instantiation and only happens once. Other
> abstraction APIs in the kernel have a much higher runtime cost, and
> instantiation tends to be quite costly as well.

I'm not too worried about this one, except for the memory allocations
as mentioned previously.

I am more concerned about the per-sysfs read overhead. Compared to the
old model, you have another indirection call for each access. And for
each driver, you end up with a single function to read from all
attributes. You will inevitably end up with a huge switch/case
statement to figure out what value to return. This smells like linear
search? Not sure if the compiler can optimize it. I was also wondering
how cache-friendly such a large function can be.

But anyway, I didn't measure anything, it's pure speculation on my
side. And it's probably irrelevant as your change has many benefits
anyway. And I wouldn't even ask myself the question if things had been
implemented right in the first place. So just ignore me ^^

> The new API has the addd benefit of reducing driver size, in some cases
> significantly. Maybe I am off, but I considered this important, which is
> why I mentioned it. Maybe I should not have mentioned it at all, and
> instead have focused on abstraction alone.

You were very right mentioning it, I mention it every time a patch of
mine reduces binary size. That's one of the actual benefits of the
change, no reason to silent it.

> > You mean at the binary level?
> > 
> > Have you considered the case where several devices exist for the same
> > driver? Static attributes are shared between devices, but with the
> > generated ones this is no longer the case, right?
>
> As mentioned above, I considered static sizes to be more important.
> Sure, there are situations where multiple instances of a driver are
> loaded, but those are not typically memory size limited. But, again,
> I guess maybe I should not have mentioned driver size impact at all.

I did not make any measurement, and I won't take the time to make them.
So I have no idea how the various costs compare to each other. Which in
turn means I don't have any point here, and we can go with what you
have ;-)

Really I was only commenting out loud while reviewing. Doesn't mean
much...

> > > > (...)
> > > > This is adding a 4th and 5th way to register a hwmon device. Starts
> > > > being a bit messy... Do you have any plans to get rid of some of the
> > > > other functions to make things more consistent and efficient?
> > >
> > > Would be nice, but then someone would have to spend the time cleaning
> > > up the old drivers to replace the old API, and for the most part we would
> > > not be able to test the result. Are you sure that is worth the risk ?
> > 
> > What I had in mind was rather along the lines of marking the function
> > as __deprecated, adding a run-time notice message when it is called,
> > and let whoever uses these driver contribute the fix. Call me an
> > optimistic :-) There are 54 drivers still using
> > hwmon_device_register(), out of 157.
>
> For most of those testing was not possible, otherwise I would have converted
> them by now.
> 
> I am not sure about deprecated; doesn't that mean a failure to compile with
> -Werror ? That would not help much.

It causes gcc to generate a warning, so I guess it would indeed break
with -Werror. But this option isn't enabled by default, and I doubt
anyone can actually build a general-purpose kernel with that option
enabled. If it's a custom kernel then maybe there's one hwmon driver
enabled, and if that one needs conversion, then you've just found your
tester ;-)

If you are worried about build-time __deprecated, you can also just
spit a message in the logs when hwmon_device_register() is called.
Won't break anything and may get you some tester, or even someone to
convert the driver for you.

But then again, you are pretty much in charge of the hwmon subsystem by
now (and you are doing that very well, thank you very much) so I'm
really only making suggestions, which you are totally free to ignore if
they seem irrelevant to you.

-- 
Jean Delvare
SUSE L3 Support
