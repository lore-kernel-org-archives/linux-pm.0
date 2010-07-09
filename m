From: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Sat, 10 Jul 2010 01:04:08 +0900
Message-ID: <20100709160408.GU30043__5558.11883318729$1278708758$gmane$org@gamma.logic.tuwien.ac.at>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
	<AANLkTiknnzWyVpqnPCpyiEVHLgkewd0zaGzLInABRe2G@mail.gmail.com>
	<20100709081239.4eb8fddd@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100709081239.4eb8fddd@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Jesse,

(stripping some people from Cc, hopefully not too many)

On Fr, 09 Jul 2010, Jesse Barnes wrote:
> > > Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D=
16179
> > > Subject =A0 =A0 =A0 =A0 : 2.6.35-rc2 completely hosed on intel gfx?
> > > Submitter =A0 =A0 =A0 : Norbert Preining <preining@logic.at>
> > > Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-06 11:55 (33 days old)
> > > Message-ID =A0 =A0 =A0: <20100606115534.GA9399@gamma.logic.tuwien.ac.=
at>
> > > References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D127582=
534931581&w=3D2  =

> > =

> > Hmm. That one is the vt.c bug coupled with another problem, which in
> > turn got opened as a separate bugzilla entry:
> > =

> >    http://bugzilla.kernel.org/show_bug.cgi?id=3D16252
> > =

> > which in turn then got closed. I dunno.
> =

> Yeah, this is weird.  Norbert, do you still see this?  Have you tried
> to bisect it?

I wrote in my last comment of this bug that in *most* of the cases
the =

	echo "mem" > /sys/power/state
works perfectly, and I'm using it permanently now.

The problem seems to be in combination with some pm-utils scripts.
I still haven't been able to pin-point the actual pm-utils script that
causes the problem, since that is something not 100% reproducible.

Futhermore, *once* (only once!) the echo mem > method failed as written in
the bug report with :
[16273.....] PM: resume of devices complete after 2115.046 msecs
[16273.....] Restarting tasks ... done
[16273.....] video LNXVIDEO:00: Restoring backlight state
hanging here, but only once, not any time again.

It is hard to say what the culprit is, some new pm-utils script maybe,
since it happens even when I switch pm-utils to use the kernel method
(echo mem) to suspend, and not uswsusp (s2ram prog).

I would suggest keeping that bug closed until I have found the pm-utils
or a specific culprit, then I can reopen it or open a new bug.

(more disturbing are iwlagn bugs, they are a PITA without any progress)

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
BLEAN
Scientific measure of luminosity : 1 glimmer =3D 100,000
bleans. Usherettes' torches are designed to produce between 2.5 and 4
bleans, enabling them to assist you in falling downstairs, treading on
people or putting your hand into a Neapolitan tub when reaching for
change.
			--- Douglas Adams, The Meaning of Liff
