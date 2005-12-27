From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Tue, 27 Dec 2005 23:08:20 +0100
Message-ID: <20051227220820.GB1914@elf.ucw.cz>
References: <200512261750.26186.dtor_core@ameritech.net>
	<Pine.LNX.4.44L0.0512261755280.10595-100000@netrider.rowland.org>
	<d120d5000512271345t6e3e0117j7852bd29668d6abe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <d120d5000512271345t6e3e0117j7852bd29668d6abe@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: dtor_core@ameritech.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On =DAt 27-12-05 16:45:17, Dmitry Torokhov wrote:
> On 12/26/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 26 Dec 2005, Dmitry Torokhov wrote:
> >
> > > Device removal could happen at any point, even during suspend trans=
ition.
> > > The kernel should be able to handle this scenario therefore impleme=
ntation
> > > that assumes that device tree is frozen in flawed. As far as I unde=
rstand
> > > the only thing that does not work at the moment is invoking hotplug=
 handler.
> >
> > The situation isn't all that bad.
> >
> > The device tree can be changed only by calling device_add or device_d=
el
> > (or the corresponding register/unregister routines).  That can only b=
e
> > done in process context; hence if processes are frozen it can't happe=
n.
> > Or rather, it can happen only if a suspend() or resume() method tries=
 to
> > do it.
> >
> > If those methods don't try to handle device removal or addition -- wh=
ich
> > in most cases they shouldn't -- then there's nothing to worry about. =
 It's
> > only oddball situations (like calling the remove method when the driv=
er
> > doesn't define a suspend method) that cause problems.
> >
>=20
> Hmm, I am confused. What should ->resume() method do when it fails to
> resume a device? I would say kill it, espacially if it is
> bus-generic

That should basically never happen. You can kill the device, or maybe
even panic() whole machine. It just should not happen.
								Pavel

--=20
Thanks, Sharp!
