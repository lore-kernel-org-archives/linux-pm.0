From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Just fix the bug - Re: [PATCH 1/8] PM: Opportunistic
 suspend support.
Date: Fri, 28 May 2010 15:35:16 +0200
Message-ID: <20100528133516.GB2323@ucw.cz>
References: <1274891308.1674.1766.camel@laptop>
	<20100526165919.GB2089@elf.ucw.cz>
	<1274893309.1674.1773.camel@laptop>
	<1274894685.4467.758.camel@mulgrave.site>
	<alpine.LFD.2.00.1005261948290.2995@localhost.localdomain>
	<1274898180.4467.925.camel@mulgrave.site>
	<1274948234.14002.27.camel@thorin>
	<AANLkTilk7FX1Y0uWKyMEpf8uxFPBae3X0hGdLLa5oNUa@mail.gmail.com>
	<20100528135021.3b6acb0b@notabene.brown>
	<AANLkTik8C5sM_YC2QbOIwAhRY-JHo6nChhH3jvsK5bBa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik8C5sM_YC2QbOIwAhRY-JHo6nChhH3jvsK5bBa@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: linux-doc@vger.kernel.org, Neil Brown <neilb@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Thomas Gleixner <tglx@linutronix.de>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, Bernd Petrovitsch <bernd@petrovitsch.priv.at>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > I don't fully understand your requirements for accounting of devices dr=
ivers
> > rejecting or blocking a suspend, so I cannot say precisely how that wou=
ld fit
> > in. =A0Maybe you just need to know - whenever the 'suspend request' com=
pletes -
> > what the wakeup events were. =A0It shouldn't be too hard to export that=
 to
> > user-space via sysfs.
> >
> > I won't propose an exact enhancement to the user-space interface for
> > requesting a suspend, but I suspect it should expose each of
> > =A0suspend_prepare
> > =A0suspend_devices_and_enter
> > =A0suspend_finish
> > (or close analogues there-of) to user-space. =A0It is tempting to map t=
hose to
> > "open-for-write", "write", "close", but I'm not sure that suspend_prepa=
re
> > would be appropriate if the app was about to write "disk" - it is a pit=
y that
> > both suspend and hibernate use the same sysfs file.
> >
> > So just fix the bug, and everyone will be happy :-)
> >
> =

> I already have, but everyone do not appear to be happy.

Half of the code you submitted was infrastructure for debugging
userspace. Sorry, that does not count as a bugfix.

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
