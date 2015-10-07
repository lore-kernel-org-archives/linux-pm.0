From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 23:30:12 +0530
Message-ID: <20151007180012.GH4557@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
 <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
 <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux>
 <20151007171949.GB9702@kroah.com>
 <20151007172701.GF4557@linux>
 <20151007173934.GB10665@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35855 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbJGSAU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:00:20 -0400
Received: by pablk4 with SMTP id lk4so27805705pab.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 11:00:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151007173934.GB10665@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07-10-15, 18:39, Greg Kroah-Hartman wrote:
> Why not?  Why does this have to be exported in debugfs?  Just delete it,
> who cares about it?  It's just "debugging".

It is really useful to see all the freq/voltage combinations on which
a device can work on, specially the CPU. And there are some serious
users of it as well..

Android has hacked the cpufreq layer today, to export something
similar in a hacky way, as they wanted to estimate power ratings based
on Hz/uV values. This will kill them as well..

And its really useful for debugging as well, to see if all went well.

Maybe debugfs is not really the best place for this, but yeah, this is
very useful.

-- 
viresh
