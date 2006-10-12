From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Thu, 12 Oct 2006 18:48:13 +0200
Message-ID: <20061012164813.GA4624@elf.ucw.cz>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<20061008071649.GB5672@ucw.cz>
	<20061012153821.GA30804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061012153821.GA30804@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Thu 2006-10-12 08:38:21, Mark Gross wrote:
> On Sun, Oct 08, 2006 at 07:16:49AM +0000, Pavel Machek wrote:
> > Hi!
> > =

> > > F) So, how would this work for OMAP1?
> > > =

> > > Let's limit it, to keep it somewhat simple, to the values contained i=
n your
> > > "struct pm_core_point" for OMAP:
> > > =

> > > 	int cpu_vltg; /* voltage in mV */
> > > 	int dpll;     /* in KHz */
> > > 	int cpu;      /* CPU frequency in KHz */
> > > 	int tc;       /* in KHz */
> > > 	int per;      /* in KHz */
> > > 	int dsp;      /* in KHz */
> > > 	int dspmmu;   /* in KHz */
> > > 	int lcd;      /* in KHz */
> > > =

> > > and let's also add a
> > > =

> > > 	int i_am_special;
> > =

> > Hehe, nice idea.
> > =

> > > I think that this might be much easier to implement than your PowerOP=
 /
> > > operating points / PM core / PowerOP - cpufreq interaction patches. A=
s a
> > > matter of fact, some parts of your operating points table infrastruct=
ure
> > > may be usable for the concept outlined above. So, what do you think? =
What
> > > does everyone else involved think about this alternative approach?
> > =

> > Looks okay to me. Unlike powerop design, this actually works for
> > everyone.
> =

> Pavel, if you would pay attention better you would notice that at the
> underneath of what Dominic is talking about is a concept of *more knobs*
> for controlling platform power states.  This is what PowerOP is trying
> to bring to the table.  =


I believe I did pay attention. What PowerOP has is crappy patches,
crappy changelogs, and when you don't like it, you are obviously
biased (or not paying attention).

And no, what Dominik describes is very reasonable, unlike powerop.

> PowerOP is not a policy engine like what Dominic is talking about.  And
> what Dominic is talking about will need to build on something that will
> end up looking so much like power op that it wont be funny.

Great, so you think you do not have that much work to do. Go ahead and
do it.

(Unlike powerop, this has actually chance of working with 256
cpus. Unlike powerop people, Dominik did his homework.)
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
