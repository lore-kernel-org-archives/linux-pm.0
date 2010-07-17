From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Sat, 17 Jul 2010 15:51:44 +0200
Message-ID: <201007171551.44438.marek.vasut__10737.0090358474$1279374802$gmane$org@gmail.com>
References: <201007150648.50521.marek.vasut@gmail.com>
	<20100715.090028.189718162.Hiroshi.DOYU@nokia.com>
	<201007150804.06217.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007150804.06217.marek.vasut@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Yoshiya.Hirase@nokia.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dne =C8t 15. =E8ervence 2010 08:04:06 Marek Vasut napsal(a):
> Dne =C8t 15. =E8ervence 2010 08:00:28 Hiroshi DOYU napsal(a):
> > From: ext Marek Vasut <marek.vasut@gmail.com>
> > Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> > Date: Thu, 15 Jul 2010 07:56:11 +0200
> > =

> > > Dne =C8t 15. =E8ervence 2010 07:39:31 Hiroshi DOYU napsal(a):
> > >> From: ext Marek Vasut <marek.vasut@gmail.com>
> > >> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> > >> Date: Thu, 15 Jul 2010 06:48:50 +0200
> > >> =

> > >> > Dne St 30. =E8ervna 2010 16:28:01 Hiroshi DOYU napsal(a):
> > >> >> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >> >> =

> > >> >> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
> > >> >> =

> > >> >> Based on the original work from Romit and Raghu at TI. The origin=
al
> > >> >> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
> > >> >> =

> > >> >> *1: https://patchwork.kernel.org/patch/96442/
> > >> >> =

> > >> >> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >> > =

> > >> > Hey, can this also run on pre-v7 arms ? Or is there something I
> > >> > missed that'd make that impossible?
> > >> =

> > >> What I verified is with OMAP3(Cortex A8) based board.
> > >> =

> > >> cp15 part has to be modified, but it might work without this part
> > >> itself, I guess.
> > > =

> > > I see ... do I need any special support on the bootloader or userland
> > > side ?
> > =

> > No, I don't think so. The resuming boot could set up most of states
> > basically.
> =

> I'll test it on xscale/pxa270 ... if it works, I can test on various pxa3=
xx
> too.

Sorry I wasn't able to test this yet, I'm having trouble with my cross-
toolchain.
