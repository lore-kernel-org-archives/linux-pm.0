From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 4/5] drivers: power: suspend: call devfreq
 suspend/resume
Date: Wed, 2 Jan 2019 16:08:40 +0100
Message-ID: <eda2b1f2-ed6f-b75f-f582-761c2a48c0cd@partner.samsung.com>
References: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@epcms1p7>
        <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: myungjoo.ham@samsung.com, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "keescook@chromium.org" <keescook@chromium.org>, "anton@enomsg.org" <anton@enomsg.org>, "ccross@android.com" <ccross@android.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kgene@kernel.org" <kgene@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Gentle ping...
Please take this patch, it got ACK.
The other patches have been taken through MyungJoo's
tree, but this one is actually enabling the feature.

Regards,
Lukasz


On 12/21/18 1:33 AM, MyungJoo Ham wrote:
>> On 2018-12-05 12:05, Lukasz Luba wrote:
>>> Devfreq framework supports suspend of its devices.
>>> Call the the devfreq interface and allow devfreq devices preserve/restore
>>> their states during suspend/resume.
>>>
>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> 
> This looks all good to me.
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
>>> ---
>>>   drivers/base/power/main.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index a690fd4..0992e67 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -32,6 +32,7 @@
>>>   #include <trace/events/power.h>
>>>   #include <linux/cpufreq.h>
>>>   #include <linux/cpuidle.h>
>>> +#include <linux/devfreq.h>
>>>   #include <linux/timer.h>
>>>   
>>>   #include "../base.h"
>>> @@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
>>>   	dpm_show_time(starttime, state, 0, NULL);
>>>   
>>>   	cpufreq_resume();
>>> +	devfreq_resume();
>>>   	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>>>   }
>>>   
>>> @@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
>>>   	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>>>   	might_sleep();
>>>   
>>> +	devfreq_suspend();
>>>   	cpufreq_suspend();
>>>   
>>>   	mutex_lock(&dpm_list_mtx);
> 
> 
