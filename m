From: Adrian Bunk <bunk@stusta.de>
Subject: [6/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 13:50:25 +0100
Message-ID: <20070313125025.GW18731@stusta.de>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
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
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Emil Karlson <jkarlson@cc.hut.fi>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Stephane Casset <sept@logidee.com>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : Dynticks and High resolution Timer hanging the system
References : http://lkml.org/lkml/2007/3/7/504
Submitter  : Stephane Casset <sept@logidee.com>
Caused-By  : Thomas Gleixner <tglx@linutronix.de>
Status     : unknown


Subject    : Clocksource tsc unstable (delta =3D -154983451 ns)
References : http://lkml.org/lkml/2007/3/9/271
Submitter  : Jiri Slaby <jirislaby@gmail.com>
Status     : unknown


Subject    : hrtimer_switch_to_hres():
             wrong tick_init_highres() return value handling
References : http://lkml.org/lkml/2007/3/6/262
Submitter  : Linus Torvalds <torvalds@linux-foundation.org>
Caused-By  : Thomas Gleixner <tglx@linutronix.de>
             commit 54cdfdb47f73b5af3d1ebb0f1e383efbe70fde9e
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : unknown


Subject    : soft lockup detected on CPU#0
References : http://lkml.org/lkml/2007/3/3/152
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
Status     : unknown


Subject    : dynticks makes ksoftirqd1 use unreasonable amount of cpu time
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8100
Submitter  : Emil Karlson <jkarlson@cc.hut.fi>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : problem is being debugged


Subject    : system doesn't come out of suspend  (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/2/22/391
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
             Soeren Sonnenburg <kernel@nn7.de>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
             Tejun Heo <htejun@gmail.com>
             Rafael J. Wysocki <rjw@sisk.pl>
Status     : problem is being debugged
