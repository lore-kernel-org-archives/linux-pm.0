From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OLPC rtc-cmos support
Date: Sun, 8 Jul 2007 13:47:34 -0700
Message-ID: <200707081347.35231.david-b__16496.621099259$1183927704$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707081210.51145.david-b@pacbell.net>
	<20070708201747.GA13115@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708201747.GA13115@dmt>
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


> > > +	(void)platform_device_register(&olpc_rtc_device);
> > > +
> > > +	device_init_wakeup(&olpc_rtc_device.dev, 1);
> > 
> > ... do the init_wakeup before registering the device, so
> > there can never be confusion about whether a probe() will
> > see that part of device config ...
> 
> For some reason doing things in that order causes wake_on/wake_off
> to not be called...

I see ... because platform_device_register() will device_initialize()
which clobbers that state, before doing platform_device_add().  I
wonder what bugs are lurking thereby.  :(


> Thanks again for the comments.

This last version looks clean and OK, so long as the driver registers
after that arch_initcall().

Really, no day field in the alarm for that particular southbridge?
Too bad.  And a bit surprising ... I thought current versions of
ACPI required the up-to-one-month enhancement to mc146818.

- Dave
