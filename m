From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 21:08:35 +0100
Message-ID: <200712262108.35643.oliver@neukum.org>
References: <20071225230731.GA29030@elf.ucw.cz> <4772A3FB.8080108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752692AbXLZUIW@vger.kernel.org>
In-Reply-To: <4772A3FB.8080108@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 26. Dezember 2007 19:56:59 schrieb H. Peter Anvin:
> > 3) Network card that is either down
> > =A0 =A0or can wake up system on any packet (and not loose too many =
packets)
> >=20
>=20
> This is the big crux I see. =A0You're going to constantly wake up the=
=20
> machine due to broadcast packets, and spend a lot of power just going=
 in=20
> and out of S3.

How many machines care a lot about saving power while they are connecte=
d
to an ethernet? Wlan might be more of a problem.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
