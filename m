From: Rodolfo =?utf-8?B?R2FyY8OtYSBQZcOxYXM=?= <kix@kix.es>
Subject: Re: Question about autosleep_show function
Date: Fri, 20 Dec 2013 22:53:04 +0100
Message-ID: <20131220215255.GA5863@kix.es>
References: <20131220193320.GA31769@kix.es>
 <1637008.1SYkgYi39T@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:42815 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753863Ab3LTVxD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Dec 2013 16:53:03 -0500
Content-Disposition: inline
In-Reply-To: <1637008.1SYkgYi39T@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On Fri, 20 Dec 2013, Rafael J. Wysocki escribi=C3=B3:

> On Friday, December 20, 2013 08:33:20 PM Rodolfo Garc=C3=ADa Pe=C3=B1=
as wrote:
> > Hi,
>=20
> Hi,
>=20
> > I am new with the kernel source.
> >=20
> > The function autosleep_show is defined at kernel/power/main.c, but =
it is not used. Is possible remove it or I am missing something? See [1=
]
>=20
> Although it is not used directly, it is actually used by the power_at=
tr(autosleep) below.

Thanks Rafael.

Rodolfo.
=20
> Thanks,
> Rafael
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
||// //\\// Rodolfo "kix" Garcia
||\\// //\\ http://www.kix.es/
