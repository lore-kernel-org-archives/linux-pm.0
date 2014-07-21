From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
Date: Mon, 21 Jul 2014 15:12:43 +0200
Message-ID: <53CD11CB.7020300@linaro.org>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>	<52019695.n2AjkGEsJ7@wuerfel>	<20140721133534.3415e425@free-electrons.com>	<5251405.VTrfDi1rj5@wuerfel>	<20140721140917.16e71558@free-electrons.com>	<53CD08CF.6080900@linaro.org> <20140721143813.6028b6ed@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39575 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbaGUNMq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 09:12:46 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so7714660wes.33
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2014 06:12:44 -0700 (PDT)
In-Reply-To: <20140721143813.6028b6ed@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On 07/21/2014 02:38 PM, Thomas Petazzoni wrote:
> Dear Daniel Lezcano,
>
> On Mon, 21 Jul 2014 14:34:23 +0200, Daniel Lezcano wrote:
>
>> So there are three solutions:
>>
>> 1. Pass the flag through the platform data, I am not really in favor=
 of
>> that as mentioned above
>
> That's what is already implemented.

Yes, that was the point :)

>> 2. Use the compatible string like the cpuidle-big-little.c driver, b=
ut
>> Arnd is not in favor of that
>>
>> 3. Register 3 platform drivers, in cpuidle-mvebu-v7.c, and let the
>> registering of the cpuidle's platform device to enable the right one
>
> I'm fine with doing (3). Daniel, Arnd, let me know if that's ok for
> you, and I'll respin the patch series accordingly.

Ok for me.

Thanks Thomas

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

