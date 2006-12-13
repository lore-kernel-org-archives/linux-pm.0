From: Pavel Machek <pavel@ucw.cz>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Wed, 13 Dec 2006 22:03:59 +0100
Message-ID: <20061213210359.GC11843@elf.ucw.cz>
References: <20060914101704.GA17820@elf.ucw.cz>
	<1158583334.28629.19.camel@localhost>
	<20060919182523.GE7099@elf.ucw.cz>
	<200612121200.18513.david-b@pacbell.net>
	<457FEE17.8080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <457FEE17.8080806@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-pm@lists.osdl.org, matthew.a.locke@comcast.net, scott.preece@motorola.com, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2006-12-13 15:12:07, Eugeny S. Mints wrote:
> David Brownell wrote:
> > On Tuesday 19 September 2006 11:25 am, Pavel Machek wrote:
> >> Could you perhaps provide list of operating points for 770? It would
> >> help understanding a bit, I'd say.
> > =

> > If there was a followup here, I missed it ...
> > =

> > ISTR that it doesn't use (formal) operating points, and that a lot of t=
he
> > basic SOC power savings (vs powering off the display or wifi) come from=
 a
> > different kind of mechanism entirely.  Namely, a combination of dynamic
> > tick with a modified system idle task, which enters one of the OMAP low
> > power modes during those long periods between clock ticks or other irqs.
> > =

> > That's one of the standard power saving schemes used on OMAP1 platforms
> > with Linux.

> sample of reasonable operating points for OMAP1 platforms along with appr=
opriate =

> patches may be found at http://dynamicpower.sourceforge.net/dpm-omap.html

Okay... so you have system with 4 different cpu speeds. That should be
simple enough to get running using cpufreq, no need for complex
operating points patches.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
