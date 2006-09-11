From: Pavel Machek <pavel@ucw.cz>
Subject: cpufreq user<->kernel interface removal [was Re:
	community PM requirements/issues and PowerOP]
Date: Tue, 12 Sep 2006 01:05:29 +0200
Message-ID: <20060911230529.GC13474@elf.ucw.cz>
References: <20060911210026.GG11901@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B1D623@de01exm64.ds.mot.com>
	<20060911213930.GJ11901@elf.ucw.cz> <4505E62F.1000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4505E62F.1000203@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>, lkml@elf.ucw.cz
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

(cc-ed to lkml).

> >>Just as a data point, "keeping the cpufreq interface" is
> >>irrelevant to a number of us, because we configure it out
> >>of the system.  I'm not really arguing that we should get
> >>rid of an existing kernel interface, but I don't see any
> >>reason why we shouldn't be able to have a separately
> >>configurable interface if cpufreq doesn't meet our needs.
> >
> >Configurable interfaces are evil,
> Are you saying that not having sysfs attribute nodes for entities which =

> don't exist in a certain configuration is evil?

I'm saying that

#ifdef CONFIG_FOO
	provide user<->kernel interface
#endif

is evil.

> >patch. You have developed your own little interface that suits your
> >needs -- and that's fine -- but now you are trying to push it into
> >mainline... and that is not, because those interfaces were not really
> >designed to work together.

> once cpufreq userland interface functionality which does not belong to th=
e =

> kernel is moved out of the kernel cpufreq interface becomes a subset of =

> PowerOP sysfs interface. In other words this means that improvements of P=
M =

>  stack layers/interfaces design will allow to design/develop an universal =

> userspace interface. We'd prefer to move gracefully in this direction =

> though.

<tongue-in-cheek warning>

Yes, once cpufreq userland interface is removed from kernel, merging
powerop is reasonable thing to do. But please get at least
Documentation/feature-removal-schedule.txt patch merged to mainline
before attempting next powerop submission :-P.

<I'm trying to explain that removing cpufreq userland interface is
about as probable as MS Linux, and only a bit less likely than hell
freezing over.>
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
