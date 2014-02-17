From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Mon, 17 Feb 2014 10:44:54 +0530
Message-ID: <CAKohpo=uPbqMcDEHYEMahRF0rCO8KYscj2nocz81_OTKyU+Tfw@mail.gmail.com>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
	<4772234.6D4cUIJHX4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4772234.6D4cUIJHX4@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pierre Ossman <pierre-list@ossman.eu>
List-Id: linux-pm@vger.kernel.org

On 17 February 2014 05:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, February 14, 2014 04:30:40 PM Viresh Kumar wrote:

> Good to know that you chat with each other, but it really is not a useful piece
> of information until you say what *exactly* you were talking about.

All that is mentioned in commit logs of both the patches :) .. That's all we
discussed.

>>  drivers/cpufreq/cpufreq.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 08ca8c9..383362b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2151,6 +2151,13 @@ int cpufreq_update_policy(unsigned int cpu)
>>        */
>>       if (cpufreq_driver->get) {
>>               new_policy.cur = cpufreq_driver->get(cpu);
>> +
>> +             if (!new_policy.cur) {
>> +                     pr_err("%s: ->get() returned 0 KHz\n", __func__);
>> +                     ret = -EINVAL;
>
> That isn't -EINVAL.  It may be -EIO or -ENODEV, but not -EINVAL.  Please.

Hmm.. Correct. I will use EIO then..

>> +                     goto no_policy;
>
> And is it unsafe to continue here?  Or can we continue regardless of getting 0?

We were supposed to set this frequency as the current frequency in policy->cur,
what else can we do now in this function when we aren't able to read current
freq? And so I thought that's all we can do here.

>> +             }
>> +
>>               if (!policy->cur) {
>>                       pr_debug("Driver did not initialize current freq");
>>                       policy->cur = new_policy.cur;
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
