From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] cpuidle: mvebu: clean up multiple platform drivers
Date: Mon, 5 Oct 2015 11:40:58 +0200
Message-ID: <561245AA.7010106@linaro.org>
References: <E1Zi9gf-0001YE-I5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34300 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbJEJlB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 05:41:01 -0400
Received: by wicfx3 with SMTP id fx3so110837517wic.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2015 02:41:00 -0700 (PDT)
In-Reply-To: <E1Zi9gf-0001YE-I5@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 10/03/2015 01:24 AM, Russell King wrote:
> There's no need to use multiple platform drivers, especially when we
> want to do something different in the probe, but we still use a commo=
n
> probe function.
>
> We can use the platform ID system to only register one platform drive=
r,
> but have it match several devices, and give us the CPU idle driver vi=
a
> the ID's driver_data.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

Hi Russell,

I applied the two patches for 4.4.

Thanks !

  -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

