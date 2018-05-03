From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v4][for 4.17-rc3] cpufreq / CPPC: Set platform specific
 transition_delay_us
Date: Thu, 3 May 2018 09:56:00 -0600
Message-ID: <e3216a6f-4954-99d9-2e81-4fb18a355649@codeaurora.org>
References: <1524850527-31720-1-git-send-email-pprakash@codeaurora.org>
 <2b999bd3-6a9a-2b20-3671-06c86cd2bab7@codeaurora.org>
 <CAJZ5v0jkwEEixwJOQCLcW6jLxroRsJqSWxy_KAcjKe1Gr=vMNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jkwEEixwJOQCLcW6jLxroRsJqSWxy_KAcjKe1Gr=vMNw@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "4.14+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5/3/2018 2:32 AM, Rafael J. Wysocki wrote:
> On Wed, May 2, 2018 at 5:39 PM, Prakash, Prashanth
> <pprakash@codeaurora.org> wrote:
>> Hi Viresh,
>>
>>
>> On 4/27/2018 11:35 AM, Prashanth Prakash wrote:
>>> Add support to specify platform specific transition_delay_us instead
>>> of using the transition delay derived from PCC.
>>>
>>> With commit "3d41386d556d: cpufreq: CPPC: Use transition_delay_us
>>> depending transition_latency" we are setting transition_delay_us
>>> directly and not applying the LATENCY_MULTIPLIER. With this on Qualcomm
>>> Centriq we can end up with a very high rate of frequency change requests
>>> when using schedutil governor (default rate_limit_us=10 compared to an
>>> earlier value of 10000).
>>>
>>> The PCC subspace describes the rate at which the platform can accept
>>> commands on the CPPC's PCC channel. This includes read and write
>>> command on the PCC channel that can be used for reasons other than
>>> frequency transitions. Moreover the same PCC subspace can be used by
>>> multiple freq domains and deriving transition_delay_us from it as we do
>>> now can be sub-optimal.
>>>
>>> Moreover if a platform does not use PCC for desired_perf register then
>>> there is no way to compute the transition latency or the delay_us.
>>>
>>> CPPC does not have a standard defined mechanism to get the transition
>>> rate or the latency at the moment.
>>>
>>> Given the above limitations, it is simpler to have a platform specific
>>> transition_delay_us and rely on PCC derived value only if a platform
>>> specific value is not available.
>>>
>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: 4.14+ <stable@vger.kernel.org>
>>> Fixes: 3d41386d556d ("cpufreq: CPPC: Use transition_delay_us depending
>>> transition_latency)
>>> ---
>>> v2:
>>> * Return final delay_us from cppc_cpufreq_get_transition_delay_us (Viresh)
>>> v3 and v4:
>>> * code style changes (Viresh)
>>> ---
>>>  drivers/cpufreq/cppc_cpufreq.c | 47 ++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 45 insertions(+), 2 deletions(-)
>> Any inputs on this patch?  I was hoping to get this in for 4.17 as it fixes undesirable(very low)
>> transition delay when using schedutil governor on centriq platform.
> I've queued it up for -rc4.  I have a plan to push it later today.

Thanks Viresh and Rafael!

-Prashanth
