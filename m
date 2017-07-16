From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 19:36:21 -0700
Message-ID: <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1578637.1XJQpJurXn@aspire.rjw.lan>
 <53f90d62-111f-57ae-907d-aa347b7033e0@free.fr>
 <1703157.S2GHVxrQk4@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1703157.S2GHVxrQk4@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mason <slash.tmp@free.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 07/15/2017 04:38 PM, Rafael J. Wysocki wrote:
> On Sunday, July 16, 2017 01:34:53 AM Mason wrote:
>> On 16/07/2017 01:24, Rafael J. Wysocki wrote:
>>
>>> On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
>>>
>>>> The enum offers the advantage of centralizing how many different states
>>>> exist for all the platforms we know about in the kernel, it's easy to
>>>> define common values for platforms that have the same semantics, just
>>>> like it's simple to add new values for platform specific details.
>>>
>>> Well, you seem to be liking this, so why don't you just implement it?
>>
>> At the end of his message, Florian wrote:
>>
>>> In any case, just agree and I will be happy to follow-up with patches.
> 
> But it may be hard to convince everybody without posting code changes
> and often enough showing a patch makes a good argument.

I had the patches ready last night, saw the emails this morning and
decided to go mountain bike for a bit to think about it some more. You
will find my follow-up patches that hopefully implement your recommendation.

Thanks
-- 
Florian
