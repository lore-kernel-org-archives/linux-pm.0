From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Wed, 11 Sep 2013 23:33:36 +0530
Message-ID: <5230B078.3070306@linux.vnet.ibm.com>
References: <522E1FEF.6080803@wwwdotorg.org> <1775778.MeiRhuYy7o@vostro.rjw.lan> <522F86AD.6010603@wwwdotorg.org> <2521560.SfeNbV74nj@vostro.rjw.lan> <52304439.3030301@linux.vnet.ibm.com> <523094CD.3000506@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <523094CD.3000506@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/11/2013 09:35 PM, Stephen Warren wrote:
> On 09/11/2013 04:21 AM, Srivatsa S. Bhat wrote:
>> On 09/11/2013 04:04 AM, Rafael J. Wysocki wrote:
>>> On Tuesday, September 10, 2013 02:53:01 PM Stephen Warren wrote:
>>>> On 09/09/2013 05:14 PM, Rafael J. Wysocki wrote:
>>>>> On Monday, September 09, 2013 03:29:06 PM Stephen Warren wrote:
>>>>>> On 09/09/2013 02:24 PM, Rafael J. Wysocki wrote:
>>>>>>> On Monday, September 09, 2013 02:01:32 PM Stephen Warren wrote:
>>>>>>>> On 09/09/2013 02:01 PM, Rafael J. Wysocki wrote:
>>>>>>>>> On Monday, September 09, 2013 01:22:23 PM Stephen Warren wrote:
>>>>>>>>>> Viresh,
>>>>>>>>>>
>>>>>>>>>> I'm seeing the crash below when suspending my system for the second time.
> ...
>> Stephen, I went through the code and I think I found out what is going wrong.
>> Can you please try the following patch?
> 
> Unfortunately, I still see the exact same failure/backtrace with this
> patch applied.
> 

Oh, is it? Can you please give me the map of the related cpus on your
system? (ie., cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus for
each CPU.)

I must be missing something...
 
Regards,
Srivatsa S. Bhat

