From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] drivers: cpuidle: rename ARM big.LITTLE driver config
 and makefile entries
Date: Sun, 15 Sep 2013 19:32:34 +0200
Message-ID: <5235EF32.7050302@linaro.org>
References: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com> <878uz0e82x.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:42446 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517Ab3IORca (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Sep 2013 13:32:30 -0400
Received: by mail-qa0-f49.google.com with SMTP id k15so598373qaq.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Sep 2013 10:32:29 -0700 (PDT)
In-Reply-To: <878uz0e82x.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

On 09/13/2013 11:16 PM, Kevin Hilman wrote:
> Daniel,
>=20
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>=20
>> Following the reorganization of CPU idle drivers configurations into=
 an ARM
>> specific Kconfig, the existing idle drivers Kconfig entries were ren=
amed and
>> moved to the Kconfig.arm file. Makefile entries were updated accordi=
ngly.
>>
>> This patch renames the entries in Kconfig.arm and makefile to make t=
he newly
>> added big.LITTLE CPUidle driver compliant with the new naming conven=
tion.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Acked-by: Kevin Hilman <khilman@linaro.org>
>=20
> We picked up this driver originally through arm-soc (with your signof=
f)
> because of arch/arm dependencies, but you might as well take this one
> directly since it's isolated to drivers/cpuidle.
>=20
> Can you queue this up for v3.12-rc please?

Yes, sure.

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

