From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 00/19] cpuidle: code consolidation
Date: Tue, 16 Apr 2013 10:42:17 +0200
Message-ID: <516D0EE9.40704@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <87k3o38kh4.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:52826 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab3DPImX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2013 04:42:23 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so114809eek.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2013 01:42:22 -0700 (PDT)
In-Reply-To: <87k3o38kh4.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/16/2013 01:03 AM, Kevin Hilman wrote:
> Hi Daniel,
>=20
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>=20
>> This patchset series provide some code consolidation across the diff=
erent
>> cpuidle drivers. It contains two parts, the first one is the removal=
 of
>> the time keeping flag and the second one, is a common initialization=
 routine.
>=20
> Do you have this series in a branch somewhere (preferrable on top of
> Rafael's linux-next) for ease of testing?

Yes, I updated my git tree [1].

Thanks for testing.

  -- Daniel

[1] git://git.linaro.org/people/dlezcano/cpuidle-next.git linux-pm-next

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

