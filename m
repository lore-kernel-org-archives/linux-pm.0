From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 19:29:54 +0200
Message-ID: <20060724172954.GC1926@elf.ucw.cz>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
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
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

Hi!

> A sysfs interface for PowerOP that allows operating points to be created
> and activated from userspace.
> =

> The platform-specific backend provides the code to read and write sysfs
> attributes for each power parameter; the core sysfs interface has no
> knowledge of the struct powerop_point contents.  This interface could be
> seen as possible extension of cpufreq sysfs.  It is not
> an integral part of PowerOP and is provided in part to facilitate
> discussion and experimentation with PowerOP, but could serve as a basis
> for a basic userspace power policy management stack.
> =

> Operating points are created by writing the name of the operating point
> to /sys/powerop/new.  This may be a job for configfs.

That looks quite ugly to do in sysfs, indeed.

And it definitely needs some Documentation/ patch. But better run this
by lkml.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
