From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Suspend Failure on Lenovo Thinkpad Edge E540 (Model 20C6CTO1WW)
Date: Tue, 15 Jul 2014 14:33:46 +0200
Message-ID: <1648307.uFHpz0AhgZ@vostro.rjw.lan>
References: <CAAQ1zEr=K3CT+9iGQf6Wq0EEJcvirPPzb4OUz1uRwqw=xgoy9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60931 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758798AbaGOMPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 08:15:32 -0400
In-Reply-To: <CAAQ1zEr=K3CT+9iGQf6Wq0EEJcvirPPzb4OUz1uRwqw=xgoy9w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn?= Horstmann <joern@jhorstmann.net>
Cc: linux-pm@vger.kernel.org

On Monday, July 14, 2014 11:37:46 PM J=C3=B6rn Horstmann wrote:
> I'd like to report a suspend problem on the Thinkpad E540 and hope yo=
u can
> help me debug or fix it. The laptop fails to suspend, meaning the fan=
 stays on
> and resume is not possible. The problem exists at least between kerne=
l version
> 3.13 (Ubuntu 14.04 default) and 3.16-rc4, I did not test any earlier =
versions.
>=20
> Suspend works if I disable USB 3.0 in the BIOS, which is why I first =
wrote to
> linux-usb, and was pointed here.
>=20
> I reported this bug initially on launchpad at
> <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1340376>.
>=20
> Another report <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/=
1331077>
> with similar hardware traced the problem to a bios update:

The best way for you to report this would be to file a bug at bugzilla.=
kernel.org
against suspend/hibernation.  Someone will take care of it then.

Rafael

