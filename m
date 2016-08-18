From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: cpuidle: Fix error return code
Date: Thu, 18 Aug 2016 09:55:53 +0200
Message-ID: <57B56A09.50402@linaro.org>
References: <1470920550-21625-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <57B471A9.8060103@linaro.org> <6453323.GiPU6Gidg3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37636 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcHRHz5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 03:55:57 -0400
Received: by mail-wm0-f41.google.com with SMTP id i5so19982926wmg.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2016 00:55:56 -0700 (PDT)
In-Reply-To: <6453323.GiPU6Gidg3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 08/18/2016 03:13 AM, Rafael J. Wysocki wrote:
> On Wednesday, August 17, 2016 04:16:09 PM Daniel Lezcano wrote:
>> On 08/11/2016 03:02 PM, Christophe JAILLET wrote:
>>> We know that 'ret = 0' because it has been tested a few lines above.
>>> So, if 'kzalloc' fails, 0 will be returned instead of an error code.
>>> Return -ENOMEM instead.
>>>
>>> Fixes: a0d46a3dfdc3 ("ARM: cpuidle: Register per cpuidle device")
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> Applied, thanks !
> 
> Daniel, I've applied it too and earlier.

Ok, thanks for the head up.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

