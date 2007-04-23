From: Adrian Bunk <bunk@stusta.de>
Subject: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Mon, 23 Apr 2007 23:49:09 +0200
Message-ID: <20070423214909.GD3468@stusta.de>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: discuss@x86-64.org, Mikael Pettersson <mikpe@it.uu.se>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, John Stultz <johnstul@us.ibm.com>, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org, Guilherme Schroeder <guilherme@centralinf.com.br>, Thomas Gleixner <tglx@linutronix.de>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : HPET enabled freeze my machine at boot
             workaround: clocksource=acpi_pm
References : http://lkml.org/lkml/2007/4/19/370
Submitter  : Guilherme Schroeder <guilherme@centralinf.com.br>
Caused-By  : Thomas Gleixner <tglx@linutronix.de>
             commit 5d8b34fdcb384161552d01ee8f34af5ff11f9684
Handled-By : John Stultz <johnstul@us.ibm.com>
Status     : problem is being debugged


Subject    : acpi_pm clocksource loses time on x86-64
References : http://lkml.org/lkml/2007/4/17/143
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : John Stultz <johnstul@us.ibm.com>
Status     : problem is being debugged


Subject    : suspend to disk hangs  (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/3/25/217
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown


Subject    : ThinkPad X60: resume no longer works  (PCI related?)
             workaround: CONFIG_FB_BACKLIGHT=n
References : http://lkml.org/lkml/2007/3/13/3
Submitter  : Dave Jones <davej@redhat.com>
Caused-By  : PCI merge
             commit 78149df6d565c36675463352d0bfe0000b02b7a7
Handled-By : Eric W. Biederman <ebiederm@xmission.com>
             Rafael J. Wysocki <rjw@sisk.pl>
             Antonino A. Daplas <adaplas@gmail.com>
Status     : unknown


Subject    : suspend to disk works only once
             workaround: "echo shutdown > /sys/power/disk"
References : http://lkml.org/lkml/2007/4/13/240
Submitter  : Tobias Diedrich <ranma+kernel@tdiedrich.de>
Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
             commit ed746e3b18f4df18afa3763155972c5835f284c5
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
             Dmitry Torokhov <dtor@insightbb.com>
Status     : problem is being debugged
