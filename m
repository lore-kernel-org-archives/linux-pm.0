From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] Re: Sleep problems with kernels >= 2.6.21 on
	powerpc
Date: Wed, 05 Sep 2007 20:24:14 +0200
Message-ID: <46DEF44E.8070003__32975.8420041346$1189016752$gmane$org@s5r6.in-berlin.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br>
	<46D279E8.10001@edge.ping.de> <46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
	<tkrat.7174534bdd0ddaff@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.7174534bdd0ddaff@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@gmail.com>
Cc: =?ISO-8859-1?Q?Kristian_H=F8gsber?=@smtp2.linux-foundation.org, michal.k.k.piotrowski@gmail.com, =?ISO-8859-1?Q?g?= <krh@redhat.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: linux-pm@vger.kernel.org

Rog=E9rio Brito wrote on 2007-08-27:
> If things progress well, I will incrementally include features on the
> kernel that I need (I left out, for instance, the Firewire subsystem, s=
o
> that compilation wouldn't take more than an hour here, despite the fact
> that I do need Firewire support on the kernel) and see the point where
> things are not normal.

The trivial pci_set_power_state issue aside, resume is currently
defective with the new firewire-ohci driver:
  - The version in Linus' tree doesn't restore a certain detail of
    IEEE 1394 state during resume, hence some protocols like SBP-2 don't
    work after resume unless you unload and reload the drivers.
  - The version in -mm restores everything but panics soon after resume
    on an APM notebook in combination with some SBP-2 targets.  I have
    yet to try netconsole or so to gather more information.
--=20
Stefan Richter
-=3D=3D=3D=3D=3D-=3D-=3D=3D=3D =3D--=3D --=3D-=3D
http://arcgraph.de/sr/
