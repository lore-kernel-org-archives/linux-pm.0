From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
Date: Mon, 22 Apr 2013 18:54:04 +0200
Message-ID: <51756B2C.3080405@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org> <20130414151429.GF5061@lunn.ch> <5174E036.9090808@linaro.org> <20130422164756.GG29947@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39976 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3DVQyJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2013 12:54:09 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so4768226wiv.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2013 09:54:08 -0700 (PDT)
In-Reply-To: <20130422164756.GG29947@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On 04/22/2013 06:47 PM, Andrew Lunn wrote:
> On Mon, Apr 22, 2013 at 09:01:10AM +0200, Daniel Lezcano wrote:
>> On 04/14/2013 05:14 PM, Andrew Lunn wrote:
>>
>> [ ... ]
>>>  int kirkwood_cpuidle_remove(struct platform_device *pdev)
>>>  {
>>> -	cpuidle_unregister_device(device);
>>> -	cpuidle_unregister_driver(&kirkwood_idle_driver);
>>> -
>>> +	cpuidle_unregister(&kirkwood_idle_driver);
>>>  	return 0;
>>>  }
>>> =20
>>> --=20
>>> 1.7.9.5
>>>
>>> Tested-by: Andrew Lunn <andrew@lunn.ch>
>>
>> Hi Andrew,
>>
>> shall I consider it as acked-by also ?
>=20
> Yes, please do.

Thanks !

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

