From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:56:09 +0200
Message-ID: <20070413215609.GP28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>
	<20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
	<1176499130.5764.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176499130.5764.94.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > That it is same old hack it used to be. There's nothing magic about
> > > > decrementer, and I do not think it is _neccessary_ to touch it just
> > > > before cli. Just disable it from sysdev handler or something.
> > > =

> > > No, you cannot disable it from sysdev handler because you have to be
> > > able to take interrupts. Can we *please* move on to some more product=
ive
> > > discussion?
> > =

> > So what happens if you disable it as a platform device? There has to
> > be better solution than this. What is so special about decrementer?
> =

> That you are dead since once it's disabled, kernel timers etc... stop
> working.
> =

> > We were able to handle MTRR registers on PC. Timer setup fit into the
> > model too...
> =

> I don't care what you do on x86. If I tell you I need to take control at
> that point, then I need. Beside I really can't understand why you are so
> dead set against an arch hook there. It's not like this will do anything
> to you... it can't propagate to drivers, it's purely arch stuff, so
> what ? =


There are about 7 places where we do stop_platform_devices()
local_irq_disable() stop_sysdevs(). You call your hook from one of
them and I suspect you need to call it from more than one. Plus, the
hook needs to have documented semantics, so people know if they should
do local_irq_disable() or if they should call your hook.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
