From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 22:06:59 +0530
Message-ID: <20151007163659.GB4557@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
 <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
 <20151007163309.GM21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151007163309.GM21513@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 07-10-15, 17:33, Russell King - ARM Linux wrote:
> Don't you even think about doing that - that's totally broken no matter
> what, and this is a good example of why casts are Bad.
> 
> debugfs_create_u64() will create a debugfs object that will want to
> access a 64-bit value, but the value pointed to is only 32-bit.  The
> net result is that the debugfs file ends up reading or writing the
> neigbouring 32-bits, which may potentially be unaligned.

Yeah, that's what I was also saying. Its broken.

> The variable pointed to for debugfs_create_u64() must be a 64-bit
> value.  No casts allowed.
> 
> An alternative would be to have debugfs_create_ulong()

And that's what I suggested.

-- 
viresh
