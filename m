From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 0/2] ARM: at91: cpuidle: encapsulate and move the
 driver to drivers/cpuidle
Date: Wed, 02 Oct 2013 15:01:15 +0200
Message-ID: <524C191B.30500@linaro.org>
References: <1380211567-2972-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:55038 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab3JBNBT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2013 09:01:19 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so382936eek.13
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 06:01:18 -0700 (PDT)
In-Reply-To: <1380211567-2972-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 09/26/2013 06:06 PM, Daniel Lezcano wrote:
> Several patches were send to encapsulate the standby code.
>
> Creating a platform driver model allows to finish to encapsulate this=
 code more
> and make possible to move the driver to the drivers/cpuidle directory=
=2E
>
> I was not able to test the patchset, I don't have the hardware.
>
> Daniel Lezcano (2):
>    ARM: at91: cpuidle: convert to platform driver
>    ARM: at91: cpuidle: Move driver to drivers/cpuidle
>
>   arch/arm/mach-at91/Makefile    |    1 -
>   arch/arm/mach-at91/cpuidle.c   |   68 -----------------------------=
----------
>   arch/arm/mach-at91/pm.c        |   16 +++++++++-
>   drivers/cpuidle/Kconfig.arm    |    6 ++++
>   drivers/cpuidle/Makefile       |    1 +
>   drivers/cpuidle/cpuidle-at91.c |   69 +++++++++++++++++++++++++++++=
+++++++++++
>   6 files changed, 91 insertions(+), 70 deletions(-)
>   delete mode 100644 arch/arm/mach-at91/cpuidle.c
>   create mode 100644 drivers/cpuidle/cpuidle-at91.c

ping ?


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

