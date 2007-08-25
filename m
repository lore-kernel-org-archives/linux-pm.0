From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot kernel
	support on x86_64
Date: Sat, 25 Aug 2007 21:51:53 +0200
Message-ID: <200708252151.54969.rjw__19442.5587229945$1188070947$gmane$org@sisk.pl>
References: <200708241206.57178.rjw@sisk.pl> <200708252027.26721.rjw@sisk.pl>
	<Pine.LNX.4.64.0708251132070.22470@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0708251132070.22470@asgard.lang.hm>
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
To: david@lang.hm
Cc: Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 25 August 2007 20:32, david@lang.hm wrote:
> On Sat, 25 Aug 2007, Rafael J. Wysocki wrote:
>=20
> > On Friday, 24 August 2007 22:46, Pavel Machek wrote:
> >> Hi!
> >>
> >>> From: Rafael J. Wysocki <rjw@sisk.pl>
> >>>
> >>> Make it possible to restore a hibernation image on x86_64 with the =
help of a
> >>> kernel different from the one in the image.
> >>>
> >>> The idea is to split the core restoration code into two separate pa=
rts and to
> >>> place each of them in a different page. =A0The first part belongs t=
o the boot
> >>
> >> What happens in case where both parts want to be
> >> at the same place? (Like kernel being restored is 4KB smaller, so th=
at
> >> routines now collide?)
> >
> > Bad things, but I can't see how to avoid that reliably.
>=20
> can you at least detect it reliably? (feed a program both kernel images=
=20
> and have it tell you 'yes/no')

Well, I have an idea how to handle that, but I need to test it.  Stay tun=
ed. :-)

Greetings,
Rafael
