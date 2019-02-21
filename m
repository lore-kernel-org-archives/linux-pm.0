From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
Date: Thu, 21 Feb 2019 18:40:02 +0100
Message-ID: <d315736a-2aa0-3c8d-f3cf-f73b60e7ebe0@linaro.org>
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21/02/2019 17:18, Rafael J. Wysocki wrote:
> On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Predicting the next event on the current CPU is implemented in the
>> idle state selection function, thus the selection logic and the
>> prediction are tied together and it is hard to decorrelate both.
>>
>> The following change introduces the cpuidle function to give the
>> opportunity to the governor to store the guess estimate of the
>> different source of wakeup and then reuse them in the selection
>> process. Consequently we end up with two separate operations clearly
>> identified.
>>
>> As the next events are stored in the cpuidle device structure it is
>> easy to propagate them in the different governor callbacks.
> 
> Can you explain a bit how you would use this new callback in a governor?

Sure.

Today we have the selection and the prediction tied together. The
prediction is modulated with some inputs coming from the governor's
policy (eg. performance multiplier).

It is hard to know if the prediction is correct or not, hard to know the
duration of the computation for the next event and hard to know if the
idle state selection succeeded because of a good prediction or a good
governor policy.

I propose to provide the callback where we fill the guess estimated next
events on the system, so we can trace them and benchmark the computation
time.

The selection of the idle state becomes an separate action where we can
apply any specific governor heuristic or policy.

By separating the selection and the prediction, we can identify where
the weakness is in our test scenario: the prediction or the governor
selection policy.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
