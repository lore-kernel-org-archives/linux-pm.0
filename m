From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console
	handling	during	suspend/resume
Date: Fri, 16 Jun 2006 11:17:45 +1000
Message-ID: <1150420666.7725.70.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
	<17553.56413.332136.737946@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <17553.56413.332136.737946@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-06-16 at 08:17 +1000, Paul Mackerras wrote:
> Linus Torvalds writes:
> =

> > See? WE DO NOT DO THIS. I told people we needed to do this _years_ ago.=
 I =

> > tried to push through the two-phase suspend. I tried to explain why. I =

> > clearly failed, because we do _nothing_of_the_sort_ right now.
> =

> We have had working suspend-to-ram on powerbooks since 1998, and we
> have always done a two-phase suspend.  We have been as unsuccessful
> as you at convincing people on the PC side that two-phase suspend is
> good. :-P  Hopefully we'll get further this time.

Well, we didn't do _that_ sort of 2 phase suspend... again we can't
separate saving state and suspending for all the reasons I just
explained to Linus (and I can do it again, I know the problem well and
while I would love to be convinced it's possible, I yet have to be
proven wrong).

What we did was to have a first phase called "prepare" suspend which was
about informing drivers that things like GFP_KERNEL memory allocations
were not possible any more, etc... that sort of thing (discussed in
another mail I sent today). It allows driver that needed to allocate
large amount of memory for example to do so before the suspend "dance"
starts and the swap device goes offline.

This is a completely different issue.

Ben.
