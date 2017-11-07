From: Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH v3] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Tue, 7 Nov 2017 11:03:46 +0000
Message-ID: <bb1cb0ee-8869-6260-eac5-a3f011fcd085@arm.com>
References: <20171103034022.GD4240@vireshk-i7>
 <20171103133642.8636-1-chris.redpath@arm.com>
 <20171103154559.GJ4240@vireshk-i7>
 <65a16c84-d25f-26ce-b4cf-5edc3f9b6d32@arm.com>
 <20171107095951.GE3297@vireshk-i7>
 <CAJZ5v0g11-45dW_Hgw7wzE+wWbznM4Hcan77FjuP8__wSGC=pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g11-45dW_Hgw7wzE+wWbznM4Hcan77FjuP8__wSGC=pg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Thanks guys, really appreciated!

--Chris

On 07/11/17 10:09, Rafael J. Wysocki wrote:
> On Tue, Nov 7, 2017 at 10:59 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 07-11-17, 09:49, Chris Redpath wrote:
>>> Hi Viresh, Rafael,
>>>
>>> Without this patch, schedutil is totally broken for us - is
>>> there any chance at all this could go in 4.14 or is it just
>>> too late?
>>
>> I see that Rafael has already applied it, but not sure if he is planning to send
>> it for 4.14 (though he should IMHO, as it is a critical fix).
> 
> Yes, I am.
> 
> Thanks,
> Rafael
> 
