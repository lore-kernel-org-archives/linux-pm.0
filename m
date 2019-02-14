From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/4] PM / devfreq: Track overall load monitor state
 instead of 'stop_polling'
Date: Fri, 15 Feb 2019 08:47:51 +0900
Message-ID: <fdb765d1-6248-dbb9-20c5-3add6581018e@samsung.com>
References: <20190214013042.254790-1-mka@chromium.org>
        <20190214013042.254790-2-mka@chromium.org>
        <CAGTfZH3E+RetMzKxzZNEgYw6=kocdfgRcKSbmP5GfZ4k1j0Cuw@mail.gmail.com>
        <CGME20190214170024epcas3p1fd9703dd6d0f2ee90bb52f24b8357d1c@epcas3p1.samsung.com>
        <20190214165947.GY117604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214165947.GY117604@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Chanwoo Choi <cwchoi00@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 19. 2. 15. 오전 1:59, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Thu, Feb 14, 2019 at 11:25:52PM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> 2019년 2월 14일 (목) 오후 7:16, Matthias Kaehlcke <mka@chromium.org>님이 작성:
>>>
>>> The field ->stop_polling indicates whether load monitoring should be/is
>>> stopped, it is set in devfreq_monitor_suspend(). Change the variable to
>>> hold the general state of load monitoring (stopped, running, suspended).
>>> Besides improving readability of conditions involving the field and this
>>> prepares the terrain for moving some duplicated code from the governors
>>> into the devfreq core.
>>>
>>> Hold the devfreq lock in devfreq_monitor_start/stop() to ensure proper
>>> synchronization.
>>
>> IMHO, I'm not sure that there are any benefits changing
>> from 'stop_polling' to 'monitor_state'. I have no objections
>> if Myungjoo confirms it.
> 
> I agree that as an isolated change there isn't a clear benefit.
> However in the context of the series the change is needed to
> avoid resuming a load monitor that wasn't even started.
> 
> In case this series isn't accepted I'd still suggest to change the
> name from 'stop_polling' to 'suspended'. I read 'stop_polling' as a
> call for action, while 'suspended' is a state. IMO at least in some
> contexts conditions using a state is clearer.

I agree to change the variable name 'stop_polling' to 'suspended'
for using the correct meaningful name.

> 
> Cheers
> 
> Matthias
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
