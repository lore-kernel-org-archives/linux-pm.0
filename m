From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 08:41:43 -0700
Message-ID: <6d93ebd4-79aa-ad4c-6670-234de28c59ba@gmail.com>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1703157.S2GHVxrQk4@aspire.rjw.lan>
 <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
 <3675920.H2f5xgTCgu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3675920.H2f5xgTCgu@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mason <slash.tmp@free.fr>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 07/16/2017 03:22 AM, Rafael J. Wysocki wrote:
> On Saturday, July 15, 2017 07:36:21 PM Florian Fainelli wrote:
>>
>> On 07/15/2017 04:38 PM, Rafael J. Wysocki wrote:
>>> On Sunday, July 16, 2017 01:34:53 AM Mason wrote:
>>>> On 16/07/2017 01:24, Rafael J. Wysocki wrote:
>>>>
>>>>> On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
>>>>>
>>>>>> The enum offers the advantage of centralizing how many different states
>>>>>> exist for all the platforms we know about in the kernel, it's easy to
>>>>>> define common values for platforms that have the same semantics, just
>>>>>> like it's simple to add new values for platform specific details.
>>>>>
>>>>> Well, you seem to be liking this, so why don't you just implement it?
>>>>
>>>> At the end of his message, Florian wrote:
>>>>
>>>>> In any case, just agree and I will be happy to follow-up with patches.
>>>
>>> But it may be hard to convince everybody without posting code changes
>>> and often enough showing a patch makes a good argument.
>>
>> I had the patches ready last night, saw the emails this morning and
>> decided to go mountain bike for a bit to think about it some more. You
>> will find my follow-up patches that hopefully implement your recommendation.
> 
> OK, thanks!
> 
> There is one problem with this I missed before, though, sorry about that.
> 
> Drivers need to be able to distinguish between suspend-to-idle and the platform
> states too, so we need to store the argument passed to suspend_devices_and_enter()
> somewhere too, either in the core or in the platform code.
> 
> And if we need to store it anyway, let's just store it in the core in a global var
> (say pm_suspend_target_state), export that and be done.

I was not sure this would be acceptable which was why I opted for making
suspend_ops::begin store the state passed from suspend_ops::enter, I
will change that.

> 
> There still will be a concern regarding drivers that care about differences between
> PM_SUSPEND_MEM and PM_SUSPEND_STANDBY, because those differences are
> platform-dependent, but let's defer addressing this until we have a driver
> that needs to run on different platforms with different definitions for those
> things.

Makes sense, thanks!

> 
> That should address the Pavel's objections too I guess.
> 
> Thanks,
> Rafael
> 

-- 
Florian
