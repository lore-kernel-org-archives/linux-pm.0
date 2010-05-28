From: Florian Mickler <florian@mickler.org>
Subject: Re: Just fix the bug - Re: [PATCH 1/8] PM: Opportunistic
 suspend support.
Date: Fri, 28 May 2010 16:26:29 +0200
Message-ID: <20100528162629.3a8f7d37@schatten.dmk.lab>
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
	<20100528133516.GB2323@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528133516.GB2323@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-doc@vger.kernel.org, Neil Brown <neilb@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy@smtp1.linux-foundation.org, Bernd@smtp1.linux-foundation.org, Andi Kleen <ak@linux.intel.com>, Zijlstra <peterz@infradead.org>, Wu@smtp1.linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, tytso@mit.edu, Thomas Gleixner <tglx@linutronix.de>, Fengguang <fengguang.wu@intel.com>, Nigel@smtp1.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, Petrovitsch <bernd@petrovitsch.priv.at>, Andrew Morton <akpm@linux-fou>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010 15:35:16 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> =

> > > I don't fully understand your requirements for accounting of devices =
drivers
> > > rejecting or blocking a suspend, so I cannot say precisely how that w=
ould fit
> > > in. =A0Maybe you just need to know - whenever the 'suspend request' c=
ompletes -
> > > what the wakeup events were. =A0It shouldn't be too hard to export th=
at to
> > > user-space via sysfs.
> > >
> > > I won't propose an exact enhancement to the user-space interface for
> > > requesting a suspend, but I suspect it should expose each of
> > > =A0suspend_prepare
> > > =A0suspend_devices_and_enter
> > > =A0suspend_finish
> > > (or close analogues there-of) to user-space. =A0It is tempting to map=
 those to
> > > "open-for-write", "write", "close", but I'm not sure that suspend_pre=
pare
> > > would be appropriate if the app was about to write "disk" - it is a p=
ity that
> > > both suspend and hibernate use the same sysfs file.
> > >
> > > So just fix the bug, and everyone will be happy :-)
> > >
> > =

> > I already have, but everyone do not appear to be happy.
> =

> Half of the code you submitted was infrastructure for debugging
> userspace. Sorry, that does not count as a bugfix.
> =

That is not the issue here.
