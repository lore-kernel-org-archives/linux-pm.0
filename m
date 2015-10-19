From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Mon, 19 Oct 2015 08:40:09 -0700
Message-ID: <20151019154009.20687.41178@quantum>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux> <5308760.2G5KJFF9Pi@wuerfel>
 <20151008074828.GF4570@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36367 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbJSPkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 11:40:14 -0400
Received: by pacfv9 with SMTP id fv9so98855425pac.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2015 08:40:13 -0700 (PDT)
In-Reply-To: <20151008074828.GF4570@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Quoting Viresh Kumar (2015-10-08 00:48:28)
> On 07-10-15, 21:12, Arnd Bergmann wrote:
> > I think it clearly makes sense to have a fixed length for each of these
> > members:
> >
> > either 32 bit is enough to represent all possible values, then
> > there is no need to make them 'long' on 64-bit architectures, or 32 bit
> > is not enough and then the code is broken on 32-bit architectures today
> > and should be fixed.
> 
> I agree.
> 
> But I am not 100% sure why it was done this way to start with.
> Probably this is the logic behind that:
> - Max clock rate supported by a u32 is ~ 4.295 GHz
> - People expected that, we will not reach this rate for 32 bit systems
>   but for 64 bit ones.
> - If above is true, then making it u64 for all will generate not very
>   optimized code for 32bit systems, as we need to fetch two 32bit
>   values everytime then.
> - And making it u32 for 64 bit systems wouldn't be great as well, as
>   we need to mask out half of the read value.
> 
> Ofcourse, Mike and Stephen can correct me here :)

I chose unsigned long for the common clock framework _implemenation_,
because the long-standing clk.h _api_ returns this type for clk_get_rate
and passes this type in for clk_set_rate and clk_round_rate.

> 
> > In my patch, I assumed that if 32-bit architectures work fine today, then
> > we don't need more range on 64-bit architectures either.
> 
> The problem here is that we haven't fixed it properly.
> - clock framework expects it to be unsigned long
> - DT is sending a 64 bit value in Hz
> - But we are storing and exposing it in u32

Don't forget cpufreq is using unsigned int for KHz.

> 
> That's weird, isn't it?

Yes it is.

> 
> So, either we update clock API and other similar APIs to u64 or u32
> (which may not be the right thing to do), Or we keep it unsigned long
> here as well and add debugfs_create_ulong().

This comes up every now and then. I'm still trying to figure out if
sub-Hertz quantities should be considered (e.g. representing freqs in
milliHertz).

Regards,
Mike

> 
> -- 
> viresh
