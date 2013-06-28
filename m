From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Fri, 28 Jun 2013 19:17:12 +0200
Message-ID: <51CDC518.8030907@gmx.de>
References: <51C08370.4050906@gmx.de> <1778593.ufLkNuJuaY@vostro.rjw.lan> <51CB34A2.7090404@gmx.de> <1475885.FjB577tJj8@vostro.rjw.lan> <CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com> <51CC7DB2.3020502@gmx.de> <CAKohponp7JbQeeC7D=X7+DBcWtUr2NhRKz7spxKA=+K8SAY+Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64913 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398Ab3F1RRQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 28 Jun 2013 13:17:16 -0400
Received: from mailout-de.gmx.net ([10.1.76.30]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LfUkZ-1UU47G0kOn-00p8za for
 <linux-pm@vger.kernel.org>; Fri, 28 Jun 2013 19:17:15 +0200
In-Reply-To: <CAKohponp7JbQeeC7D=X7+DBcWtUr2NhRKz7spxKA=+K8SAY+Og@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 06/28/2013 05:44 AM, Viresh Kumar wrote:
> Can you give dumps of complete cpufreq directories for all cpus befor=
e
> and after s2r. That may give us some hint about the problem.

Because CPU0 is not affected I somehow arguing about nohz patches ...

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
