From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Thu, 21 Jun 2018 15:19:09 -0600
Message-ID: <5ccc0d29-554b-fd5f-84fb-a1ef5bd3d559@codeaurora.org>
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
 <67822500-0c9d-ac24-71bc-2717831ab29d@codeaurora.org>
 <44d52166-ed9d-c199-3e19-3df1317ee78c@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44d52166-ed9d-c199-3e19-3df1317ee78c@caviumnetworks.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <gcherian@caviumnetworks.com>, George Cherian <george.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hi George,

On 6/20/2018 3:17 AM, George Cherian wrote:
> Hi Prakash,
>
> Thanks for the review.
>
> On 06/19/2018 01:51 AM, Prakash, Prashanth wrote:
>> External Email
>>
>> Hi George,
>>
>> On 6/15/2018 4:03 AM, George Cherian wrote:
>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>> feedback via set of performance counters. To determine the actual
>>> performance level delivered over time, OSPM may read a set of
>>> performance counters from the Reference Performance Counter Register
>>> and the Delivered Performance Counter Register.
>>>
>>> OSPM calculates the delivered performance over a given time period by
>>> taking a beginning and ending snapshot of both the reference and
>>> delivered performance counters, and calculating:
>>>
>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>
>>> Implement the above and hook this to the cpufreq->get method.
>>>
>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 71 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 3464580..3fe7625 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>        return ret;
>>>   }
>>>
>>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>> +{
>>> +     u64 delta_reference, delta_delivered;
>>> +     u64 reference_perf, delivered_perf;
>>> +
>>> +     reference_perf = fb_ctrs_t0.reference_perf;
>>> +     if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
>>> +             delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>>> +     } else {
>> There should be another if () here to check if the reference counters are equal.
>> We cannot assume, there was a overflow when the counters are equal. As I
>> mentioned on last patch, the counters *may* pause in idle states.
> My Bad... I somehow, over looked that point. In case of delta_reference being zero there is actually a check below to avoid divide-by-zero. There I returned  reference perf instead of desired perf, same I will take care in v3. Isn't that sufficient or is there a need for an explicit check here for delta = zero?

I am not sure I followed the above. The gist of my comment was when the counters
are equal we cannot assume that there was a overflow. So change the ">" condition
to ">=" and my concern about assuming overflow when equal should be take care of.

The above change would be required for both reference and delivered counters.
