From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH 0/7] sched/cpuidle: Idle loop rework
Date: Tue, 6 Mar 2018 08:50:30 -0800
Message-ID: <000a01d3b56b$3fd8b050$bf8a10f0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: sc97eXGePpApssc9CeDAYz
In-Reply-To: sc97eXGePpApssc9CeDAYz
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Peter Zijlstra' <peterz@infradead.org>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.04 14:22 Rafael J. Wysocki wrote:

...[snip]...

> I have tested these patches on a couple of machines, including the very laptop
> I'm sending them from, without any obvious issues, but please give them a go
> if you can, especially if you have an easy way to reproduce the problem they
> are targeting.  The patches are on top of 4.16-rc3 (if you need a git branch
> with them for easier testing, please let me know).

I am having some troubles with the patch set.
My test server takes anywhere between nominal (about 30 seconds) and 10X nominal
(about 5 minutes) time to boot.
I have booted 5 times:

1. took about 5 minutes to boot. No test data acquired. Kern.log excerpt:
	[    5.760740] Btrfs loaded, crc32c=crc32c-intel
	[    5.779522] random: crng init done
	[  336.185559] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
	[  346.823627] Loading iSCSI transport class v2.0-870.

2. took about 5 minutes to boot. Minimal test data acquired. Kern.log excerpt:
	[    8.963959] async_tx: api initialized (async)
	[    9.001124] Btrfs loaded, crc32c=crc32c-intel
	[    9.024652] random: crng init done
	[  332.768025] clocksource: timekeeping watchdog on
			 CPU3: Marking clocksource 'tsc' as unstable because the
			 skew is too large:
	[  332.768128] clocksource: 'hpet' wd_now: 1c082869 wd_last:
			 a5053b0 mask: ffffffff
	[  332.768129] clocksource: 'tsc' cs_now: 11a0d3a34be cs_last:
			 1b534f1252 mask: ffffffffffffffff
	[  332.768129] tsc: Marking TSC unstable due to clocksource watchdog
	[  332.768145] TSC found unstable after boot, most likely due to
			 broken BIOS. Use 'tsc=unstable'.	

	Observe 25.14 average processor package watts. 100% load on CPU 7.
	Test Duration 2.5 hours.
	Reference: K4.16-rc3: Not done yet.
	Reference: K4.15-rc1: 27.34 Watts
	Reference: K4.15-rc1, idle states 0-3 disabled: 23.92 Watts
	Reference: This kernel, idle states 0-3 disabled: ~23.65 Watts

3. crashed during boot. No useful log info.

4. booted kernel 4.16-rc3 stock. Booted normally in about 30 seconds.

5. took about 30 seconds to boot. Minimal test data acquired.
	Observe 24.77 average processor package watts. 100% load on CPU 7.
	Test duration 15 hours. Peak power 32.8 watts.
	There is a graph. I'll send it off-list.

Oh, I see a version 2 of the patch set. I'll move on to version 2.

... Doug
