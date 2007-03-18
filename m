From: Adrian Bunk <bunk@stusta.de>
Subject: [4/6] 2.6.21-rc4: known regressions
Date: Sun, 18 Mar 2007 19:49:23 +0100
Message-ID: <20070318184923.GX752@stusta.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
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
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomas Janousek <tomi@nomi.cz>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Thomas Meyer <thomas@m3y3r.de>, Milan Broz <mbroz@redhat.com>
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : suspend/resume hangs (until keypress)  (CONFIG_NO_HZ)
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8181
             http://lkml.org/lkml/2007/3/11/112
Submitter  : Tomas Janousek <tomi@nomi.cz>
             Thomas Meyer <thomas@m3y3r.de>
             Milan Broz <mbroz@redhat.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Patch      : http://lkml.org/lkml/2007/3/16/406
Status     : patch available


Subject    : system doesn't come out of suspend  (CONFIG_NO_HZ)
References : http://lkml.org/lkml/2007/2/22/391
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
             Soeren Sonnenburg <kernel@nn7.de>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
             Tejun Heo <htejun@gmail.com>
             Rafael J. Wysocki <rjw@sisk.pl>
Status     : problem is being debugged


Subject    : first disk access after resume takes several minutes
             ('date' does not advance after resume from RAM, CONFIG_NO_HZ=
=3Dn)
References : http://lkml.org/lkml/2007/3/8/117
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Ingo Molnar <mingo@elte.hu>
Status     : problem is being debugged


Subject    : after resume: X hangs after drawing a couple of windows
References : http://lkml.org/lkml/2007/3/8/117
Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
Status     : unknown
