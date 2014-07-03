From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 03/16] ARM: mvebu: Add function to export the physical
 address of the boot register
Date: Thu, 03 Jul 2014 12:07:53 +0200
Message-ID: <53B52B79.8080409@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>	<20140630144620.0030cf94@free-electrons.com>	<53B516D8.8070003@free-electrons.com> <20140703112538.533b73e1@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49447 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758594AbaGCKH6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 06:07:58 -0400
In-Reply-To: <20140703112538.533b73e1@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,

On 03/07/2014 11:25, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
>=20
> On Thu, 03 Jul 2014 10:39:52 +0200, Gregory CLEMENT wrote:
>=20
>>> I'm not sure that the best approach to solve this problem. Instead,
>>> maybe the system-controller.c code should set up the boot address
>>> workaround on Armada 375. Since the workaround on 375 is really rel=
ated
>>> to setting the boot address which is done by the system controller,
>>> maybe the initialization of the workaround belongs in
>>> system-controller.c ?
>>
>> So moving the workaround into mvebu_system_controller_set_cpu_boot_a=
ddr()
>> should be the thing to do.
>=20
> Except that mvebu_system_controller_set_cpu_boot_addr() is called
> multiple times during the system execution, while you want the
> workaround to be initialized once. And we surely don't really want a
> static variable in there to test if the workaround has already been
> initialized or not.

Actually mvebu_system_controller_set_cpu_boot_addr()=E0 is called only =
in
mvebu_cortex_a9_boot_secondary() just after the call to mvebu_boot_addr=
_wa().

So it won't change anything. Moreover the call to mvebu_cortex_a9_boot_=
secondary()
is not expected to be done too often  during the system execution.

Gregory


--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
