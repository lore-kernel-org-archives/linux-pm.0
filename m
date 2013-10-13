From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
Date: Sun, 13 Oct 2013 12:17:17 +0200
Message-ID: <525A732D.3080708@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>	<1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org> <20131013111945.0251a3cc@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:51561 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152Ab3JMKRT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2013 06:17:19 -0400
Received: by mail-wi0-f173.google.com with SMTP id h11so945247wiv.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Oct 2013 03:17:18 -0700 (PDT)
In-Reply-To: <20131013111945.0251a3cc@skate>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 10/13/2013 11:19 AM, Thomas Petazzoni wrote:
> Dear Daniel Lezcano,
>
> On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:
>
>> +config ARM_AT91_CPUIDLE
>> +        bool "Cpu Idle Driver for the AT91 processors"
>
> Nitpick: indentation is done with spaces here, while it should be one
> tab.

Ah, right. Fixed for the V2.

Thanks !
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

