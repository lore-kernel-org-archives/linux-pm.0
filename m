From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] modify pl011 driver to work as wakeup source
Date: Fri, 14 Aug 2015 12:58:28 +0200
Message-ID: <55CDC9D4.3020709@linaro.org>
References: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36478 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbHNK6c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 06:58:32 -0400
Received: by wicja10 with SMTP id ja10so14482212wic.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 03:58:31 -0700 (PDT)
In-Reply-To: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>, linux-pm@vger.kernel.org
Cc: amit.kucheria@linaro.org

On 08/14/2015 12:24 PM, Zhaoyang Huang wrote:
> add IRQF_NO_SUSPEND flag when requiring irq line and call
> the pm_system_wakeup when RX interrupt happens
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>

Did you look at the 'dev_pm_set_wake_irq' function ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

