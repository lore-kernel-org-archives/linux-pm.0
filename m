From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface
	(rev. 2)
Date: Thu, 5 Jan 2006 02:05:05 +0100
Message-ID: <20060105010505.GD1751@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200601042340.42118.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <ncunningham@linuxmail.org>, ast@domdv.de
List-Id: linux-pm@vger.kernel.org

Hi!

> This is the second "preview release" of the swsusp userland interface p=
atches.
> They have changed quite a bit since the previous post, as I tried to ma=
ke the
> interface more robust against some potential user space bugs (or outrig=
ht
> attempts to abuse it).
>=20
> The swsusp userland interface is based on a special character device al=
lowing
> a user space process to initiate suspend or resume using ioctls and to =
write or read
> the system memory snapshot from the device (actually more operations ar=
e
> defined on the device). =A0The device itself is introduced by the
> second patch.
...
> Any feedback will be very much appreciated.

Pretty please, give it a try. If you think about introducing
splashscreen/compression/encryption into swsusp, userland parts of
these patches should be great place for it.
								Pavel
--=20
Thanks, Sharp!
