From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 18:28:04 +0100
Message-ID: <200712261828.04671.oliver@neukum.org>
References: <20071225230731.GA29030@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752193AbXLZR1t@vger.kernel.org>
In-Reply-To: <20071225230731.GA29030@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 26. Dezember 2007 00:07:31 schrieb Pavel Machek:
> Heute 00:07:31
>   =A0
> This is RFC. It does not even work for me... it sleeps but it will no=
t
> wake up, because SATA wakeup code is missing. Code attached for illus=
tration.
>=20
> I wonder if this is the right approach? What is right interface to th=
e
> drivers?

IMHO you are making to many special cases. The system can be "sleepy"
if all devices can be runtime suspended and all CPUs are idle.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
