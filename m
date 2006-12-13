From: David Brownell <david-b@pacbell.net>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Wed, 13 Dec 2006 13:32:56 -0800
Message-ID: <200612131332.58606.david-b@pacbell.net>
References: <20060914101704.GA17820@elf.ucw.cz> <457FEE17.8080806@gmail.com>
	<20061213210359.GC11843@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061213210359.GC11843@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Amit Kucheria <amit.kucheria@nokia.com>, matthew.a.locke@comcast.net, scott.preece@motorola.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 13 December 2006 1:03 pm, Pavel Machek wrote:
> On Wed 2006-12-13 15:12:07, Eugeny S. Mints wrote:
> > David Brownell wrote:
> > > On Tuesday 19 September 2006 11:25 am, Pavel Machek wrote:
> > >> Could you perhaps provide list of operating points for 770? It would
> > >> help understanding a bit, I'd say.
> > > =

> > > If there was a followup here, I missed it ...
> > > =

> > > ISTR that it doesn't use (formal) operating points, and that a lot of=
 the
> > > basic SOC power savings (vs powering off the display or wifi) come fr=
om a
> > > different kind of mechanism entirely.  Namely, a combination of dynam=
ic
> > > tick with a modified system idle task, which enters one of the OMAP l=
ow
> > > power modes during those long periods between clock ticks or other ir=
qs.
> > > =

> > > That's one of the standard power saving schemes used on OMAP1 platfor=
ms
> > > with Linux.
> =

> > sample of reasonable operating points for OMAP1 platforms along with ap=
propriate =

> > patches may be found at http://dynamicpower.sourceforge.net/dpm-omap.ht=
ml

That's the old DPM stuff not any of the newer proposals right?

I thought the question was specifically what N770 used.


> Okay... so you have system with 4 different cpu speeds. That should be
> simple enough to get running using cpufreq, no need for complex
> operating points patches.

And OMAP1 does have cpufreq support.  I believe that if I checked it out
I'd find that it's used on N770, as a good way to kick in low voltage
operation modes.

... that's in addition to the reduced power idle, which didn't seem to
fit into the DPM framework in any obvious way.

- Dave
