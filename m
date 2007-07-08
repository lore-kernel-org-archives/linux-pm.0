From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OLPC rtc-cmos support
Date: Sat, 7 Jul 2007 22:13:40 -0700
Message-ID: <200707072213.41028.david-b__3700.05690861053$1183872475$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<20070402165511.GD5024@cosmic.amd.com> <20070708035504.GC19633@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708035504.GC19633@dmt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 07 July 2007, Marcelo Tosatti wrote:
> 
> Hi,
> 
> The following patch implements the hooks necessary for OLPC to use the
> rtc-cmos driver. This is necessary since we do not want CONFIG_PNP.
> 
> This makes it possible to control rtc wakeup via
> /sys/devices/platform/rtc_cmos/power/wakeup.
> 
> Comments?

Looks almost right ... though I'd have expected the RTC to
support alarms more than just 24 hours into the future!

It's more complicated than necessary.  It'd be much simpler
to just declare a static platform_device with pre-initted
platform_data.  Then call device_init_wakeup() on that before
calling the usual platform_device_register() routine.

That way you wouldn't need to have two different init sections
just to set up one device, where one of them is spending most
of its time working around the possibility that the other one
failed.  And you'd also pretty much eliminate the possibility
that the (now) single init section fails.  :)

- Dave
