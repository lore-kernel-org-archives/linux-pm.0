From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Thu, 06 Jul 2017 17:38:53 -0700
Message-ID: <1499387933.22531.15.camel@linux.intel.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
         <CA+55aFyBfHVyh=TMifF+0KGEVy6JEyDz=gbHdP7nM2roa++X4Q@mail.gmail.com>
         <CA+b4Kqd9qV0Pc7wJ2eHKcA-7+a23tY9gfe2Abm4=Bd08SKkh8w@mail.gmail.com>
         <1908911.91yT2N6t2f@aspire.rjw.lan>
         <1498580081.7952.91.camel@linux.intel.com>
         <CA+b4Kqd5qO2Q6drnfvhCyj_q33Hjg1nT7vbgm-uoc+wjpX=e3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+b4Kqd5qO2Q6drnfvhCyj_q33Hjg1nT7vbgm-uoc+wjpX=e3Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tom Lanyon <tom@oneshoeco.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-07-06 at 21:41 +1000, Tom Lanyon wrote:
> Sorry for the slow response - I've just had a chance to run some more
> tests.
> 
> I tried to disable the SD card reader in the BIOS as suggested
> earlier
> in the thread, but that didn't seem to make a significant change.
> More inline below.
> 
> On Tue, 2017-06-27 at 17:03 +0200, Rafael J. Wysocki wrote:
> > 
> > I would carry out s2idle under turbostat to see how much PC10
> > residency is there while suspended.  That may be a significant
> > factor.
> > 
> > Most likely there is a device preventing the SoC from reaching its
> > deepest low-power states under Linux on your system and it needs to
> > be
> > identified and dealt with.
> I'm not entirely sure how turbostat records metrics so wasn't sure
> how
> to measure correctly.  I kept turbostat running while performing a
> s2idle and recorded the output:
> 
> https://gist.githubusercontent.com/tomlanyon/3238e742a155e7fa27658aa0
> 960bdee4/raw/98b5f050e5eb2f88af47b2afd17080e7dd85d20f/turbostat
> 
> I'm not familiar with the output format - I see some high percentages
> of C10, but nothing in Pkg%pc10. Which is of interest in this
> scenario?
I see that you do have Pkg%pc10 of 86.56 in one interval. The system
was in Pkg%pc8 for multiple intervals before Pkg%pc10. So can you try
this also before your test?

# cd /sys/kernel/debug/pmc_core
# for i in {0..32}; do echo $i > ltr_ignore; done

Thanks,
Srinivas	

> 
> On 28 June 2017 at 02:14, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Also make sure that you have no FW loading error for i915.
> > #dmesg | grep i915
> > It will display that Guc FW was loaded etc..
> > The latest FW can be downloaded from
> > https://01.org/linuxgraphics/downloads/firmware
> > 
> > If you don't see PC10 residency, we can try something more.
> I've confirmed that there's no FW errors for the i915.
