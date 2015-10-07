From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 22:57:01 +0530
Message-ID: <20151007172701.GF4557@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
 <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
 <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux>
 <20151007171949.GB9702@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32995 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbbJGR1H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 13:27:07 -0400
Received: by pacex6 with SMTP id ex6so27181810pac.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 10:27:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151007171949.GB9702@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07-10-15, 18:19, Greg Kroah-Hartman wrote:
> Ok, then stop exporting it in debugfs and everyone will be happy :)

Hehe, not really. See I am not happy :(

So, what do you suggest? Should we create debugfs_create_ulong()? And
how to implement that? With existing u32/u64 APIs or from scratch?

-- 
viresh
