From: "Luca Tettamanti" <kronos.it@gmail.com>
Subject: Re: [atl1-devel] BUG? WOL from S3
Date: Wed, 11 Apr 2007 22:50:31 +0200
Message-ID: <68676e00704111350v7b3bf127vafec621e56ab7ea8@mail.gmail.com>
References: <65c8858e0704040223g6fd006e8o2a4e426b3dbad228@mail.gmail.com>
	<002b01c777ec$b4364070$9927a8c0@shanghai.attansic.com>
	<20070410223821.GA25453@dreamland.darkstar.lan>
	<200704111151.32166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704111151.32166.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: huang xiong <xiong.huang@atheros.com>, atl1-devel@lists.sourceforge.net, Tony Glader <tony.glader@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 4/11/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, 11 April 2007 00:38, 'Luca Tettamanti' wrote:
> > Il Fri, Apr 06, 2007 at 09:41:31AM +0800, huang xiong ha scritto:
> > > > > I do the same test over Intel/Realtek PCIE gigabit Ethernet adapt=
er.
> > > > >
> > > > > And found the .resume function is called before the system really=
 go to
> > > > > sleep.
> > > > >
> > > > > And because some shared hardware circuit. Attansic's nic can't en=
able both
> > > > > normal tx/rx setting and WOL setting.
> > > > >
> > > > > So attansic's linux driver think the system wakeup when the .resu=
me is
> > > > > called, and it clear all WOL setting and back to normal tx/rx set=
ting.
> > >
> > > > Hum, what you describe seems to be suspend-to-disk:
> > > >
> > > > ->suspend(PMSG_FREEZE)
> > > > take snapshot
> > > > ->resume() for writing the image
> > > > write snapshot
> > > > ->suspend(PMSG_SUSPEND)
> > >
> > >      You are right. It's suspend-to-disk.
> > >      Could you explain calling sequence of .suspend and .resume when =
the
> > > system goes to sleep for me ? such as S3/S4/...
> > >      I confused what the driver should do when .resume is called.
> >
> > It should restore the normal state of the device. The first suspend
> > (PMSG_FREEZED) puts the device into a quiescent state (e.g. DMA transfe=
rs
> > shall be stopped). The system is then resumed so that the image can be
> > written to the disk. The second and final suspend call (PMSG_SUSPEND) is
> > done before shutting down the system.
>
> Er, no.  The system is just shut down, without suspending devices.
>
> > > But It seems the system didn't called second .suspend.
> >
> > Ouch. This is very strange. I'm adding a few of CC.
>
> Well, that's how it works now.  We have considered suspending devices bef=
ore
> powering off for a while, but only theoretically.  If there's any additio=
nal
> reason to do it, I think we can.

There's a problem with atl1 driver: Huang Xiong says that the chip can
be either is normal rx/tx mode or in WOL mode. When .resume is called
the NIC goes back in normal mode and won't react to WOL packets.

Luca
