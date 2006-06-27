From: "Matt Sealey" <matt@genesi-usa.com>
Subject: PowerPC cpufreq using ICTC
Date: Tue, 27 Jun 2006 09:56:06 -0500
Message-ID: <023301c699f9$d3e0a860$99dfdfdf@bakuhatsu.net>
Reply-To: matt@genesi-usa.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Hello,

After a little discussion on linux-ppc kernel mailing list I got pointed he=
re.

I am investigating more generic power management (cpufreq) for PowerPC, both
in terms of DFS and the G3 dual-PLL feature (which is already implemented in
the PowerMac driver) and also using the G3/G4 "ICTC" register which stalls
the instruction fetch for 1-255 clocks in order to allow the execution unit=
s to
go into dynamic power management (when DPM is enabled). This should, by all
documentation, reduce the power consumption of the CPU.

I'm looking at it from the point of view of the Pegasos (www.pegasosppc.com)
because right now we only have G3 (750CXe) and G4 (7447) processor cards
which do not support DFS. The G3 is fanless so there is no scope to reduce
noise dynamically or turn the fan off, and the G4 fan has no controller so
the same applies. We also do not support batteries, so you're always on an
AC power supply, but it WOULD be an interesting project to see if it could
improve the lifetime of a system running off one of these:

http://www.freeplayenergy.com/index.php?section=3Dproducts&subsection=3Dfre=
echargeportable

It is merely an exercise in whether it can be done effectively (notwithstan=
ding
the possibility of turning a 1GHz G4 into a 4MHz G4 :) and an interesting t=
est
of whether the feature works "as advertised" by the IBM and Freescale manua=
ls.
It may also be a cute way of testing application performance on slower
processors, while using the best you have. I dunno. There are lots of things
floating around in my head right now :)

So the question is, is there already a generic powerpc cpufreq driver which
does not rely on PowerMac hardware/platform tree or a PMU, if not where
should I be looking to start, and is this a good idea anyway? I have seen
threads (from 1-4 years ago) where it was discussed and passed off or, but
it was all fairly conversational.

http://lists.debian.org/debian-powerpc/2002/08/msg00107.html
http://www.mail-archive.com/debian-powerpc@lists.debian.org/msg03607.html

http://www.toojays.net/portal/Wiki/IBookG4PowerConsumption =


-- =

Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
