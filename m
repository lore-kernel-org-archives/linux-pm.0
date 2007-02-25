From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.21-rc1: known regressions (part 2)
Date: Sun, 25 Feb 2007 18:55:59 +0100
Message-ID: <20070225175559.GC12392@stusta.de>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in 2.6.21-rc1 compared to 2.6.20
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ThinkPad T60: system doesn't come out of suspend to RAM
             (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/2/22/391
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
             Thomas Gleixner <tglx@linutronix.de>
Handled-By : Ingo Molnar <mingo@elte.hu>
Status     : unknown


Subject    : kernel BUG at kernel/time/tick-sched.c:168  (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/2/16/346
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : problem is being debugged


Subject    : BUG: soft lockup detected on CPU#0
             NOHZ: local_softirq_pending 20
References : http://lkml.org/lkml/2007/2/20/257
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
Status     : problem is being debugged


Subject    : i386: no boot with nmi_watchdog=3D1  (clockevents)
References : http://lkml.org/lkml/2007/2/21/208
Submitter  : Daniel Walker <dwalker@mvista.com>
Caused-By  : Thomas Gleixner <tglx@linutronix.de>
             commit e9e2cdb412412326c4827fc78ba27f410d837e6e
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : problem is being debugged
