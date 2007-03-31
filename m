From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.21-rc5: known regressions with patches (v2)
Date: Sat, 31 Mar 2007 20:19:40 +0200
Message-ID: <20070331181940.GV14134@stusta.de>
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
Cc: Robert Hancock <hancockr@shaw.ca>, tigran@aivazian.fsnet.co.uk, Tejun Heo <htejun@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Kay Sievers <kay.sievers@vrfy.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Mathieu =?utf-8?Q?B=C3=A9rard?= <Mathieu.Berard@crans.org>, Ingo Molnar <mingo@elte.hu>, jgarzik@pobox.com
List-Id: linux-pm@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.20
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : hung bootup in various drivers
References : http://lkml.org/lkml/2007/3/30/68
Submitter  : Ingo Molnar <mingo@elte.hu>
Handled-By : Kay Sievers <kay.sievers@vrfy.org>
Patch      : http://lkml.org/lkml/2007/3/30/323
Status     : patch available


Subject    : NCQ problem with ahci and Hitachi drive
References : http://lkml.org/lkml/2007/3/4/178
             http://lkml.org/lkml/2007/3/9/475
             http://lkml.org/lkml/2007/2/22/8
Submitter  : Mathieu B=E9rard <Mathieu.Berard@crans.org>
Handled-By : Tejun Heo <htejun@gmail.com>
             Robert Hancock <hancockr@shaw.ca>
Patch      : http://lkml.org/lkml/2007/2/22/8
Status     : possible patch available


Subject    : suspend to disk hangs  (microcode driver)
References : http://lkml.org/lkml/2007/3/16/126
Submitter  : Maxim Levitsky <maximlevitsky@gmail.com>
Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
             commit e3c7db621bed4afb8e231cb005057f2feb5db557
             commit ed746e3b18f4df18afa3763155972c5835f284c5
             commit 259130526c267550bc365d3015917d90667732f1
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Patch      : http://lkml.org/lkml/2007/3/25/71
Status     : patch available
