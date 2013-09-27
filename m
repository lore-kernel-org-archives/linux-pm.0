From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility
 string
Date: Fri, 27 Sep 2013 18:36:14 +0200
Message-ID: <5245B3FE.3080807@linaro.org>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org> <31f13d14-2af7-4285-8770-3cc7ef7e7b09@AM1EHSMHS008.ehs.local> <52454342.80706@linaro.org> <5245471F.6040707@xilinx.com> <43fa0b3d-019f-4438-899d-0adaf730591a@DB9EHSMHS030.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:46875 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab3I0QgV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 12:36:21 -0400
Received: by mail-wg0-f45.google.com with SMTP id y10so3004708wgg.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 09:36:20 -0700 (PDT)
In-Reply-To: <43fa0b3d-019f-4438-899d-0adaf730591a@DB9EHSMHS030.ehs.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 09/27/2013 05:58 PM, S=C3=B6ren Brinkmann wrote:
> On Fri, Sep 27, 2013 at 10:51:43AM +0200, Michal Simek wrote:
>> On 09/27/2013 10:35 AM, Daniel Lezcano wrote:
>>> On 09/27/2013 10:19 AM, Michal Simek wrote:
>>>> On 09/27/2013 10:17 AM, Daniel Lezcano wrote:
>>>>> All zynq platforms have this compatibility string and there is no=
 any other
>>>>> clone.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> The patchset is only compile-tested (I don't have the hardware).
>>>
>>> Michal or someone else, if you have the time can you give it a try =
?
>>>
>>
>> Soren: Can you please retest it on hw?
> Hmm, I'm not subscribed to LAKML (only LKML), but well found the seri=
es on
> patchworks.
>
> The series introduces new build warnings:
> WARNING: drivers/cpuidle/built-in.o(.data+0x28c): Section mismatch in=
 reference from the variable zynq_cpuidle_driver to the function .init.=
text:zynq_cpuidle_probe()
> The variable zynq_cpuidle_driver references
> the function __init zynq_cpuidle_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
>    CC      kernel/trace/trace.o
>    LD      drivers/built-in.o
> WARNING: drivers/built-in.o(.data+0x13870): Section mismatch in refer=
ence from the variable zynq_cpuidle_driver to the function .init.text:z=
ynq_cpuidle_probe()
> The variable zynq_cpuidle_driver references
> the function __init zynq_cpuidle_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
>    LD      kernel/trace/built-in.o
>    LD      kernel/built-in.o
>    LINK    vmlinux
>    LD      vmlinux.o
>    MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0x2e0b0): Section mismatch in reference from=
 the variable zynq_cpuidle_driver to the function .init.text:zynq_cpuid=
le_probe()
> The variable zynq_cpuidle_driver references
> the function __init zynq_cpuidle_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Oops, right, I missed the section mismatch. Thanks for pointing this ou=
t.

> Other than that it looks good. I assume there is just some __init
> annotation missing somewhere. Feel free to add my 'Tested-by'.

Cool ! Thanks Soren for testing.

I will take the patchn with the init section fixed, in my tree if you=20
are ok with that.

   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

