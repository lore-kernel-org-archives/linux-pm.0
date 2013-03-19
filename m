From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/4][V2] ARM: nomadik: add dynamic irq flag to the timer
Date: Tue, 19 Mar 2013 12:42:30 +0100
Message-ID: <51484F26.1010100@linaro.org>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org> <513A0109.9060801@linaro.org> <alpine.LFD.2.02.1303081703160.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:46881 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab3CSLmf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Mar 2013 07:42:35 -0400
Received: by mail-bk0-f49.google.com with SMTP id w11so179350bku.22
        for <linux-pm@vger.kernel.org>; Tue, 19 Mar 2013 04:42:33 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1303081703160.22263@ionos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: john.stultz@linaro.org, linus.walleij@stericsson.com, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, rickard.andersson@stericsson.com, vincent.guittot@linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 03/08/2013 05:03 PM, Thomas Gleixner wrote:
> On Fri, 8 Mar 2013, Daniel Lezcano wrote:
>=20
>>> Add the dynamic irq affinity feature to the timer clock device.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
>>> ---
>>
>> Hi Linus,
>>
>> AFAIU, you are ok with this patch, Rickard acked it and Vincent revi=
ewed it.
>>
>> Thomas agreed to merge it into its tree as I requested because we wi=
ll
>> need to wait for your tree to gain visibility to this new flag befor=
e
>> submitting this patch, which can take awhile.
>>
>> Could you please ack it if it is ok for you ?
>=20
> I can provide a for-arm tree to pull as well. Either way fine with me=
=2E

Hi Thomas,

the patch 3/4 and 4/4 have been acked-by the different maintainers.

I saw you created a 'for-arm' branch (thanks), but the patches 3/4 and
4/4 aren't there. Did I missed something ?

Thanks
   -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

