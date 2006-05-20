From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Sat, 20 May 2006 19:20:51 +0200
Message-ID: <20060520172051.GL2946@elf.ucw.cz>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605181256.35174.david-b@pacbell.net>
	<20060518205013.GB2571@elf.ucw.cz>
	<200605181925.30967.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70204166001261115=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605181925.30967.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============70204166001261115==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k4KHLatH032763

On =C4=8Ct 18-05-06 19:25:29, David Brownell wrote:
> On Thursday 18 May 2006 1:50 pm, Pavel Machek wrote:
>=20
> > Well, will it ever go to sleep? In such case? There are many things
> > that wake up periodically.
>=20
> Applications that constantly wake/poll are death to power management an=
yway,
> that's not news ... most of the "work" done by polling is wasted.  When=
 they
> get switched to no-timeout/blocking APIs, then they can sleep painlessl=
y
> until a relevant wakeup event triggers.

Well, that is not how X app currently work :-(.

> Things that really *must* wake up periodically should be using some API=
 that
> interacts with RTC alarms, and those RTC alarms should be acting as sys=
tem
> wakeup events.

But that means completely rewriting userspace.

> There's also non-automated sleep too ... what "apmsleep" used to do whe=
n
> you told it to suspend until 7am (or for two hours, etc).  The same thi=
ng
> can be done with /sys/power/state and a wakeup-enabled RTC.

Yep, I should get it working one day.

> > > As for downloading, that's why ethernet adapters have wake-on-lan (=
WOL)
> > > mechanisms.  Likewise for other wakeup-capable devices, like a keyb=
oard
> > > or mouse.  Or even 3D engines, DSPs, SPUs, ...
> >=20
> > ?? WOL is for different functionality, I'm afraid. Or do you know
> > ethernet hub that automagically wakes machines when data come?
>=20
> No, that's exactly what WOL is designed for.  A typical scenarios has
> the adapter waking up when the incoming packet is unicast to the MAC
> address of that host.  The hub/switch would act normally.

I do not think WOL wakes that way. IIRC it needs magic ethernet
packet.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

--===============70204166001261115==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============70204166001261115==--
