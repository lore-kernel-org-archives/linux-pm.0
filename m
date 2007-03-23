From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [3/5] 2.6.21-rc4: known regressions (v2)
Date: Fri, 23 Mar 2007 21:53:51 +0100
Message-ID: <200703232153.53239.rjw@sisk.pl>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<20070323185022.GQ752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070323185022.GQ752@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Harris <atarimike@wavecable.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 23 March 2007 19:50, Adrian Bunk wrote:
> This email lists some known regressions in Linus' tree compared to 2.6.20.
> =

> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way
> possibly involved with one or more of these issues.
> =

> Due to the huge amount of recipients, please trim the Cc when answering.
> =

[--snip--]
> Subject    : suspend to disk hangs
> References : http://lkml.org/lkml/2007/3/16/126
> Submitter  : Maxim Levitsky <maximlevitsky@gmail.com>
> Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
>              commit e3c7db621bed4afb8e231cb005057f2feb5db557
>              commit ed746e3b18f4df18afa3763155972c5835f284c5
>              commit 259130526c267550bc365d3015917d90667732f1
> Status     : unknown

The problem has been identified as the known issue related to the XFS freez=
able
workqueues.  There is a patch available (http://lkml.org/lkml/2007/3/21/328=
),
that has been merged.

Still, there is a problem with the microcode update driver that's being wor=
ked
on.

The reporters of the resume problems who use the microcode driver, please
check if the problems go away if you unload the driver before the suspend.

Greetings,
Rafael
