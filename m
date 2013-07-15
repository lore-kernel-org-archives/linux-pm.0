From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] cpuidle: Add Kconfig.arm and move calxeda, kirkwood
 and zynq
Date: Mon, 15 Jul 2013 16:18:58 +0200
Message-ID: <51E404D2.5030907@linaro.org>
References: <1372841395-30891-1-git-send-email-kpark3469@gmail.com> <1429422.16N7g1KiV4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34366 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab3GOOTE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 10:19:04 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so10176876wgh.33
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 07:19:02 -0700 (PDT)
In-Reply-To: <1429422.16N7g1KiV4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kpark3469@gmail.com, linux-pm@vger.kernel.org, keun-o.park@windriver.com

On 07/15/2013 01:26 AM, Rafael J. Wysocki wrote:
> On Wednesday, July 03, 2013 05:49:55 PM kpark3469@gmail.com wrote:
>> From: Sahara <keun-o.park@windriver.com>
>>
>> This patch adds Kconfig.arm for cpuidle drivers for ARM. And, this
>> also moves calxeda, kirkwood and zynq to Kconfig.arm. Like cpufreq
>> menu, "CPU Idle" menu is added to drivers/cpuidle/Kconfig.
>>
>> Signed-off-by: Sahara <keun-o.park@windriver.com>
>=20
> Daniel: Yes, no, maybe?

Actually I picked the patch in my tree, I was waiting for the -rc1
before sending the pull request.

I have 3 other patches on top of it I want to send for review before
sending the pull request (as you take 1PR/week).

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

