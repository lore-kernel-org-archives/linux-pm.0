From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 00:24:02 +0200
Message-ID: <20060615222402.GH2255@elf.ucw.cz>
References: <20060614221235.GA7751@elf.ucw.cz>
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
Content-Disposition: inline
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
Cc: Linus Torvalds <torvalds@osdl.org>, Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On P=E1 16-06-06 08:17:01, Paul Mackerras wrote:
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

Are you sure your second phase is same second phase Linus is talking
about?

What Linus actually wants is another phase before stopping
userland. That's okay -- that is basically unordered, so simple
notifier list is okay. Its just... I did not yet seen driver that
_needs_ that kind of notifier, so I simply did not add it, yet.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
