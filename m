From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Question about autosleep_show function
Date: Fri, 20 Dec 2013 22:26:43 +0100
Message-ID: <1637008.1SYkgYi39T@vostro.rjw.lan>
References: <20131220193320.GA31769@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52732 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751514Ab3LTVNW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 16:13:22 -0500
In-Reply-To: <20131220193320.GA31769@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rodolfo =?ISO-8859-1?Q?Garc=EDa_Pe=F1as?= <kix@kix.es>
Cc: linux-pm@vger.kernel.org

On Friday, December 20, 2013 08:33:20 PM Rodolfo Garc=C3=ADa Pe=C3=B1as=
 wrote:
> Hi,

Hi,

> I am new with the kernel source.
>=20
> The function autosleep_show is defined at kernel/power/main.c, but it=
 is not used. Is possible remove it or I am missing something? See [1]

Although it is not used directly, it is actually used by the power_attr=
(autosleep) below.

Thanks,
Rafael

