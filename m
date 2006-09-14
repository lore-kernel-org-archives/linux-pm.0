From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Thu, 14 Sep 2006 15:04:36 +0200
Message-ID: <20060914130436.GA2244@elf.ucw.cz>
References: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B6A3D9@de01exm64.ds.mot.com>
	<20060914091211.GA14874@elf.ucw.cz>
	<a1a8b0b5c71a78fafd450c10ec52a60d@comcast.net>
	<45092968.7070508@gmail.com> <20060914101704.GA17820@elf.ucw.cz>
	<acd2a5930609140515j5c57583cm43615b6f48a265aa@mail.gmail.com>
	<20060914130311.GA2224@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060914130311.GA2224@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org, Matthew Locke <matthew.a.locke@comcast.net>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2006-09-14 15:03:11, Pavel Machek wrote:
> =

> > Pavel,
> =

> > > > operating points it is possible to implement the "cpufreq frequency
> > > > selection logic" in user space and having such functionality in the=
 kernel
> > > > just violates the main rule of having everything possible outside o=
f the
> > > > kernel.
> > >
> > > You got the rules wrong. "Keep the code out of kernel" is important
> > > rule, but probably not the main one.
> > =

> > from aside, it looks like you're choosing 'rules' and assign then
> > 'priorities' in a too arbitrary way which is by a strange accident
> > fits your point of view best of all.
> > May I remind you that Linux world is not only laptops and Sharp Zaurus?=
 ;)
> =

> Actually, laptops and zauruses seem to be the only "interesting"
> machines from pm perspective. Then there are Motorola cellphones, but
> Motorola tried hard not to enable users changing kernel... so they are
> irrelevant.

Make that "mostly irrelevant"... as community will find a way to flash
them, eventually. Still 2.6-based machine with more advanced power
management would be nice. AFAICT zaurus are best machines today...
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
