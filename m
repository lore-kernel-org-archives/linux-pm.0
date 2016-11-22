From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 2/3] thermal: rockchip: improve conversion error messages
Date: Tue, 22 Nov 2016 10:33:27 +0800
Message-ID: <81605141-dd5b-1714-6486-3381e616a992@gmail.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <1479513177-81504-2-git-send-email-briannorris@chromium.org>
 <b6da9490-9a27-4330-7988-cb25724ba345@rock-chips.com>
 <378ade3d-a980-58e4-5253-c16702c74bf3@gmail.com>
 <20161122021506.GA103691@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122021506.GA103691@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

在 2016年11月22日 10:15, Brian Norris 写道:
> On Tue, Nov 22, 2016 at 09:51:23AM +0800, Caesar Wang wrote:
>> CHECK: Alignment should match open parenthesis
>> #428: FILE: drivers/thermal/rockchip_thermal.c:428:
>> +    pr_err("%s: invalid temperature, temp=%d error=%d\n",
>> +        __func__, temp, error);
>>
>> CHECK: Alignment should match open parenthesis
>> #480: FILE: drivers/thermal/rockchip_thermal.c:480:
>> +        pr_err("%s: invalid conversion table, mode=%d\n",
>> +            __func__, table->mode);
> What patch are you checking? I ran mine through checkpatch, and there
> are no problems.

That  just checkcode on Chromeos kernelv4.4,  that trivial things :)
$chromiumos/src/third_party/kernel/v4.4$ checkcode 
drivers/thermal/rockchip_thermal.c
CHECK: Alignment should match open parenthesis
#428: FILE: drivers/thermal/rockchip_thermal.c:428:
+    pr_err("%s: invalid temperature, temp=%d error=%d\n",
+        __func__, temp, error);
...

vi drivers/thermal/rockchip_thermal.c +428 or  vi 
drivers/thermal/rockchip_thermal.c +480,

> Did you perhaps mangle the tabs into spaces when you
> saved the patch?
>
>> I'm ready to resend all rockchip thermal patches. (contain them)
> I see no reason to resend so far; the only criticism was on the 1st
> patch (a non-critical patch to the core thermal code; the others are
> relatively independent, as long as you don't care that I'm adding
> another error return without fixing up the broken
> CONFIG_THERMAL_EMULATION support).
>
> Brian
>
