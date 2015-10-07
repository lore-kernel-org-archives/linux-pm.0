From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 16:33:02 +0530
Message-ID: <20151007110302.GD9892@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35492 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbbJGLDI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 07:03:08 -0400
Received: by pacfv12 with SMTP id fv12so18951094pac.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 04:03:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151007105911.GC9892@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07-10-15, 16:29, Viresh Kumar wrote:
> What about adding something like debugfs_create_unsigned_long() for
> such cases?

And that can be as simple (or ugly, not sure if its buggy) as:

debugfs_create_unsigned_long()
{
        if (sizeof(unsigned long) == sizeof(u32))
                return debugfs_create_u32();
        if (sizeof(unsigned long) == sizeof(u64))
                return debugfs_create_u64();

        return -EINVAL;
}

-- 
viresh
