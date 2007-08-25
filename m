From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot kernel
	support on x86_64
Date: Sat, 25 Aug 2007 20:27:25 +0200
Message-ID: <200708252027.26721.rjw@sisk.pl>
References: <200708241206.57178.rjw@sisk.pl> <200708241211.55319.rjw@sisk.pl>
	<20070824204632.GA5008@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070824204632.GA5008@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 24 August 2007 22:46, Pavel Machek wrote:
> Hi!
>=20
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >=20
> > Make it possible to restore a hibernation image on x86_64 with the he=
lp of a
> > kernel different from the one in the image.
> >=20
> > The idea is to split the core restoration code into two separate part=
s and to
> > place each of them in a different page. =A0The first part belongs to =
the boot
>=20
> What happens in case where both parts want to be
> at the same place? (Like kernel being restored is 4KB smaller, so that
> routines now collide?)

Bad things, but I can't see how to avoid that reliably.

Greetings,
Rafael
