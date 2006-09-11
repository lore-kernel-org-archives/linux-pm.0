From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 23:39:30 +0200
Message-ID: <20060911213930.GJ11901@elf.ucw.cz>
References: <20060911210026.GG11901@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B1D623@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01B1D623@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2006-09-11 17:36:33, Preece Scott-PREECE wrote:
> =

> > From: Pavel Machek [mailto:pavel@ucw.cz] =

> > =

> > > >>- PowerOP is only one layer (towards the bottom) in a power =

> > > >>management solution.
> > > >>- PowerOP does *not* replace cpufreq
> > > >
> > > >PowerOP provides userland interface for changing processor =

> > frequency. =

> > > >That's bad -- duplicate interface.
> > > Basically the biggest problem with cpufreq interface is =

> > that cpufreq =

> > > has "chose predefined closest to a given frequency" functionality =

> > > implemented in the kernel while there is _no_ any reason to =

> > have this =

> > > functionality implemented in the kernel if we have sysfs interface =

> > > exported by PowerOP in place - you just
> > =

> > No, there is reason to keep that in kernel -- so that cpufreq =

> > userspace interface can be kept, and so that resulting =

> > kernel<->user interface is not ugly.
> ---
> =

> Just as a data point, "keeping the cpufreq interface" is
> irrelevant to a number of us, because we configure it out
> of the system.  I'm not really arguing that we should get
> rid of an existing kernel interface, but I don't see any
> reason why we shouldn't be able to have a separately
> configurable interface if cpufreq doesn't meet our needs.

Configurable interfaces are evil, and I do not think you can push such
patch. You have developed your own little interface that suits your
needs -- and that's fine -- but now you are trying to push it into
mainline... and that is not, because those interfaces were not really
designed to work together.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
