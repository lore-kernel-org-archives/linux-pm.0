From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Tue, 27 Dec 2005 17:39:00 -0500
Message-ID: <d120d5000512271439x62e00e95n9016b4d41f4ef077@mail.gmail.com>
References: <200512261750.26186.dtor_core@ameritech.net>
	<Pine.LNX.4.44L0.0512261755280.10595-100000@netrider.rowland.org>
	<d120d5000512271345t6e3e0117j7852bd29668d6abe@mail.gmail.com>
	<20051227220820.GB1914@elf.ucw.cz>
	<d120d5000512271421l6d4bc33dn37e3ad20129a361f@mail.gmail.com>
	<20051227223134.GC1914@elf.ucw.cz>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051227223134.GC1914@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On 12/27/05, Pavel Machek <pavel@ucw.cz> wrote:
> On =DAt 27-12-05 17:21:28, Dmitry Torokhov wrote:
> > On 12/27/05, Pavel Machek <pavel@ucw.cz> wrote:
> > > On =DAt 27-12-05 16:45:17, Dmitry Torokhov wrote:
> > > >
> > > > Hmm, I am confused. What should ->resume() method do when it fail=
s to
> > > > resume a device? I would say kill it, espacially if it is
> > > > bus-generic
> > >
> > > That should basically never happen. You can kill the device, or may=
be
> > > even panic() whole machine. It just should not happen.
> >
> > It can happen, it did happen and it will continue to happen. You hit
> > your suspend button and stand up and accidentially kick your USB hub
> > or your PS/2 mouse gets loose and kernel fails to resume it. It is no
> > big deal, we just have to be prepared to handle it.
>
> Ok, in case of hotpluggable devices, you just handle it in a similar
> way to surprise removal.

Yes, and we go back to beginning - currently the driver does not know
whether it is allowed to handle surprise removal or not because it
does not know if it is resumed for real or just to be able to write
suspend image.

--
Dmitry
