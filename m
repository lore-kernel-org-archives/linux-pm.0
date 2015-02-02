From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before putting
 kobject
Date: Mon, 02 Feb 2015 12:06:02 +0800
Message-ID: <54CEF7AA.80401@oracle.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org> <54CEECF7.7020504@oracle.com> <CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com> <54CEF123.5050106@oracle.com> <CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com> <54CEF574.6040404@oracle.com> <CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38308 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbbBBEGU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 23:06:20 -0500
In-Reply-To: <CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>



On 2015/2/2 11:59, Viresh Kumar wrote:
> On 2 February 2015 at 09:26, ethan zhao <ethan.zhao@oracle.com> wrote:
>>   How to prevent the policy to be freed between
>>
>> cpufreq_cpu_get()  and cpufreq_cpu_put() ?
> kobject_get() increases the reference count of a policy and the policy
> will only be freed when this is zero. And it will only be zero once all
> cpufreq_cpu_get() are matched with corresponding cpufreq_cpu_put().
  Is that an idea it supposed to be or fact ?

if (!cpufreq_suspended)
             cpufreq_policy_free(policy);

  static void cpufreq_policy_free(struct cpufreq_policy *policy)
{
     free_cpumask_var(policy->related_cpus);
     free_cpumask_var(policy->cpus);
     kfree(policy);
}

  It seems you just think about it ideally in mind.

  Thanks,
  Ethan
>
>> You are maxing up the water with sand ?
> :)

