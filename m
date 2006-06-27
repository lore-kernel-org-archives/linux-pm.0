From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerPC cpufreq using ICTC
Date: Wed, 28 Jun 2006 09:23:17 +1000
Message-ID: <1151450597.2350.110.camel@localhost.localdomain>
References: <023301c699f9$d3e0a860$99dfdfdf@bakuhatsu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <023301c699f9$d3e0a860$99dfdfdf@bakuhatsu.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: matt@genesi-usa.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-06-27 at 09:56 -0500, Matt Sealey wrote:

> I'm looking at it from the point of view of the Pegasos (www.pegasosppc.c=
om)
> because right now we only have G3 (750CXe) and G4 (7447) processor cards
> which do not support DFS.

7447A is supposed to support it no ?

>  The G3 is fanless so there is no scope to reduce
> noise dynamically or turn the fan off,

Also G3 generally support at least DOZE mode when idle, unlike the 7447
where all you have is NAP which is better, but requires proper
northbridge support... I would be surprised if the Discovery II used on
the Pegasos supports that properly and without funky bugs...

>  and the G4 fan has no controller so
> the same applies. We also do not support batteries, so you're always on an
> AC power supply, but it WOULD be an interesting project to see if it could
> improve the lifetime of a system running off one of these:
> =

> http://www.freeplayenergy.com/index.php?section=3Dproducts&subsection=3Df=
reechargeportable
> =

> It is merely an exercise in whether it can be done effectively (notwithst=
anding
> the possibility of turning a 1GHz G4 into a 4MHz G4 :) and an interesting=
 test
> of whether the feature works "as advertised" by the IBM and Freescale man=
uals.
> It may also be a cute way of testing application performance on slower
> processors, while using the best you have. I dunno. There are lots of thi=
ngs
> floating around in my head right now :)
>
> So the question is, is there already a generic powerpc cpufreq driver whi=
ch
> does not rely on PowerMac hardware/platform tree or a PMU, if not where
> should I be looking to start, and is this a good idea anyway? I have seen
> threads (from 1-4 years ago) where it was discussed and passed off or, but
> it was all fairly conversational.
> =

> http://lists.debian.org/debian-powerpc/2002/08/msg00107.html
> http://www.mail-archive.com/debian-powerpc@lists.debian.org/msg03607.html
> =

> http://www.toojays.net/portal/Wiki/IBookG4PowerConsumption =


I'm not sure a cpufreq driver is the best thing to do but let's first
simply measure if ICTC helps at all... it should be fairly trivial to do
a simple kernel module to tweak the value.

Ben.
