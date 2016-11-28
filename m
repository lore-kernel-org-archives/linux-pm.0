From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Mon, 28 Nov 2016 10:27:57 -0800
Message-ID: <4f815e31-22d0-fef7-953c-257fa2bbcb9d@codeaurora.org>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
 <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
 <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
 <20161122031717.GE10014@vireshk-i7> <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
 <m2wpfuw5wq.fsf@baylibre.com>
 <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
 <m2fumhx21h.fsf@baylibre.com> <20161124020322.GI6095@codeaurora.org>
 <20161124044020.GC9376@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161124044020.GC9376@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nayak Rajendra <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 11/23/2016 08:40 PM, Viresh Kumar wrote:
> On 23-11-16, 18:03, Stephen Boyd wrote:
>> On 11/23, Kevin Hilman wrote:
>>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>>> On 23 November 2016 at 16:51, Kevin Hilman <khilman@baylibre.com> wrote:
>>>>> Then, at least for this use case, we're talking about voltage, not some
>>>>> unspecified units.
>> In some cases we actually know the voltage of the domain and
>> would want to put some voltage mapping in DT. For example, level
>> 1 is voltage 2V and level 2 is voltage 2.5V.
> But even in these cases we wouldn't be using the voltage values within the
> kernel as we will be giving only a performance state to the M3 core, right?

Nope. In these cases we need to set a certain voltage and we do that by
requesting it via the M3 core.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
