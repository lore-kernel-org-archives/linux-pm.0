From: Adrian Bunk <bunk@stusta.de>
Subject: [5/5] 2.6.21-rc5: known regressions
Date: Tue, 27 Mar 2007 03:59:54 +0200
Message-ID: <20070327015954.GC16477@stusta.de>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
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
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, =?utf-8?B?RnLDqWTDqXJpYw==?= Riss <frederic.riss@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, John Stultz <johnstul@us.ibm.com>, Stephane Casset <sept@logidee.com>, Tino Keitel <tino.keitel@gmx.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mike Harris <atarimike@wavecable.com>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : MacMini doesn't come out of suspend to ram  (i386 clockevents)
             (CONFIG_HPET_TIMER)
References : http://lkml.org/lkml/2007/3/21/374
Submitter  : Fr=E9d=E9ric Riss <frederic.riss@gmail.com>
             Tino Keitel <tino.keitel@gmx.de>
Caused-By  : Thomas Gleixner <tglx@linutronix.de>
             commit e9e2cdb412412326c4827fc78ba27f410d837e6e
Status     : unknown


Subject    : MacBook Core Duo: suspend to disk hangs
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8224
Submitter  : Mike Harris <atarimike@wavecable.com>
Status     : unknown


Subject    : Dynticks and High resolution Timer hang boot during IDE detect=
ion
             workaround: clocksource=3Dacpi_pm
References : http://lkml.org/lkml/2007/3/7/504
Submitter  : Stephane Casset <sept@logidee.com>
Caused-By  : John Stultz <johnstul@us.ibm.com>
             commit 6bb74df481223731af6c7e0ff3adb31f6442cfcd
Handled-By : John Stultz <johnstul@us.ibm.com>
Patch      : http://lkml.org/lkml/2007/3/22/287
Status     : workaround-patch available


Subject    : after resume: X hangs after drawing a couple of windows
             workaround: clocksource=3Dacpi_pm
References : http://lkml.org/lkml/2007/3/8/117
             http://lkml.org/lkml/2007/3/25/20
             http://lkml.org/lkml/2007/3/26/151
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : problem is being debugged


Subject    : first disk access after resume takes several minutes
             resume from RAM broken
             'date' does not advance after resume from RAM  (CONFIG_HPET_TI=
MER)
References : http://lkml.org/lkml/2007/3/8/117
             http://lkml.org/lkml/2007/3/25/20
             http://lkml.org/lkml/2007/3/26/18
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
             Jeff Chua <jeff.chua.linux@gmail.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
Status     : problem is being debugged


Subject    : system doesn't come out of suspend  (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/2/22/391
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
             Soeren Sonnenburg <kernel@nn7.de>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
             Tejun Heo <htejun@gmail.com>
             Rafael J. Wysocki <rjw@sisk.pl>
Status     : unknown


Subject    : suspend to disk hangs  (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/3/25/217
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown
