From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 16:51:49 +0530
Message-ID: <20151007112149.GB22530@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
 <20151007110755.GA6601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151007110755.GA6601@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 07-10-15, 12:07, Greg Kroah-Hartman wrote:
> Why would you be wanting to create a "unsigned long" as an api anyway?
> Just force it to be u64 all the time, can't you do that?

Okay, so the variable in question (lets say frequency) is an 'unsigned
long' and that's how all the APIs of clock framework expect/define
it.

And you are probably saying that we do this:

unsigned long freq;

debugfs_create_u64((u64 *)&freq);

Right? Or are you asking to update clock APIs to be converted to u64?

This will break things on a 32 bit architecture where unsigned long is
32 bits long, as doing this will overwrite the next 32 bits:

*freq = XYZ;

-- 
viresh
