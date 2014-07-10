From: "Srivatsa S. Bhat" <srivatsa@MIT.EDU>
Subject: Re: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 16:52:18 +0530
Message-ID: <53BE776A.6060401@mit.edu>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>	<53BE75EE.6010200@mit.edu> <CAKohpokb3S3czYB46JsDYggYBYi34CmRhjNGVJDO3wtLV7xGzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAKohpokb3S3czYB46JsDYggYBYi34CmRhjNGVJDO3wtLV7xGzQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Saravana Kannan <skannan@codeaurora.org>, "Bu, Yitian" <ybu@qti.qualcomm.com>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/10/2014 04:50 PM, Viresh Kumar wrote:
> On 10 July 2014 16:45, Srivatsa S. Bhat <srivatsa@mit.edu> wrote:
>> Looks good to me. But I think it would be better to move the invocation of
>> kobject_move() to update_policy_cpu() itself, so that update_policy_cpu()
>> will do all the work involved in updating the policy->cpu, as its name suggests.
> 
> Its called from remove path as well ..
> 

I know.. That's why it makes even more sense to consolidate all the
work into one function. We can restructure cpufreq_nominate_new_policy_cpu()
such that the kobject_move() can be moved to update_policy_cpu().

Regards,
Srivatsa S. Bhat
