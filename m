From: "'Luca Tettamanti'" <kronos.it@gmail.com>
Subject: Re: [atl1-devel] BUG? WOL from S3
Date: Wed, 11 Apr 2007 00:38:21 +0200
Message-ID: <20070410223821.GA25453@dreamland.darkstar.lan>
References: <65c8858e0704040223g6fd006e8o2a4e426b3dbad228@mail.gmail.com>
	<003301c7771f$d5795a60$9927a8c0@shanghai.attansic.com>
	<68676e00704051555h63d02709ma59b431fac12dd91@mail.gmail.com>
	<002b01c777ec$b4364070$9927a8c0@shanghai.attansic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <002b01c777ec$b4364070$9927a8c0@shanghai.attansic.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: huang xiong <xiong.huang@atheros.com>
Cc: atl1-devel@lists.sourceforge.net, 'Tony Glader' <tony.glader@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Il Fri, Apr 06, 2007 at 09:41:31AM +0800, huang xiong ha scritto: =

> > > I do the same test over Intel/Realtek PCIE gigabit Ethernet adapter.
> > >
> > > And found the .resume function is called before the system really go =
to
> > > sleep.
> > >
> > > And because some shared hardware circuit. Attansic's nic can't enable=
 both
> > > normal tx/rx setting and WOL setting.
> > >
> > > So attansic's linux driver think the system wakeup when the .resume is
> > > called, and it clear all WOL setting and back to normal tx/rx setting.
> =

> > Hum, what you describe seems to be suspend-to-disk:
> > =

> > ->suspend(PMSG_FREEZE)
> > take snapshot
> > ->resume() for writing the image
> > write snapshot
> > ->suspend(PMSG_SUSPEND)
>
>      You are right. It's suspend-to-disk.
>      Could you explain calling sequence of .suspend and .resume when the
> system goes to sleep for me ? such as S3/S4/...
>      I confused what the driver should do when .resume is called.

It should restore the normal state of the device. The first suspend
(PMSG_FREEZED) puts the device into a quiescent state (e.g. DMA transfers
shall be stopped). The system is then resumed so that the image can be
written to the disk. The second and final suspend call (PMSG_SUSPEND) is
done before shutting down the system.

> But It seems the system didn't called second .suspend.

Ouch. This is very strange. I'm adding a few of CC.

Luca
-- =

Colui che sorride quando le cose vanno male ha pensato a qualcuno a cui
dare la colpa.
