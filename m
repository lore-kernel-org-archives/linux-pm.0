From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] ARM: cpuidle: davinci: Fix target residency
Date: Thu, 11 Jul 2013 13:53:26 +0200
Message-ID: <51DE9CB6.40706@linaro.org>
References: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org> <51CD3063.5010309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:55839 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab3GKLxa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2013 07:53:30 -0400
Received: by mail-we0-f176.google.com with SMTP id t56so6788453wes.21
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2013 04:53:29 -0700 (PDT)
In-Reply-To: <51CD3063.5010309@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: khilman@deeprootsystems.com, sergei.shtylyov@cogentembedded.com, rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 06/28/2013 08:42 AM, Sekhar Nori wrote:
> On 6/27/2013 8:40 PM, Daniel Lezcano wrote:
>> The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the targ=
et
>> residency to 100000, assuming this is a careless mistake.
>>
>> commit 19976c2a88d125aec16b9255c7197c297bbdd637
>> Author: Robert Lee <rob.lee@linaro.org>
>> Date:   Tue Mar 20 15:22:45 2012 -0500
>>
>>     ARM: davinci: Consolidate time keeping and irq enable
>>
>>     Enable core cpuidle timekeeping and irq enabling and remove that
>>     handling from this code.
>>
>>     Signed-off-by: Robert Lee <rob.lee@linaro.org>
>>     Reviewed-by: Kevin Hilman <khilman@ti.com>
>>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>     Acked-by: Jean Pihet <j-pihet@ti.com>
>>     Signed-off-by: Len Brown <len.brown@intel.com>
>>
>> The same happened to the at91's cpuidle driver.
>>
>> Fix it by putting the initial value to 10000.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Hi Sekhar,

I applied this patch on my tree for the next PM pull request.

Thanks
  -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

