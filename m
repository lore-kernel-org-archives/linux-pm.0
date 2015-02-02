From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before putting
 kobject
Date: Mon, 02 Feb 2015 12:45:58 +0800
Message-ID: <54CF0106.5050601@oracle.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org> <54CEECF7.7020504@oracle.com> <CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com> <54CEF123.5050106@oracle.com> <CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com> <54CEF574.6040404@oracle.com> <CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com> <54CEF7AA.80401@oracle.com> <CAKohponfkJVYFTsj6ijy0iY3t-R=zN=M0ZkoDmYa-WYTzPuvmw@mail.gmail.com> <54CEFA23.7040705@oracle.com> <CAKohpomBcBVXLW-RW1VXAtkTw-BKd7tHmeFJgmf9CM3vi1Ki-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:28098 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbbBBEqM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 23:46:12 -0500
In-Reply-To: <CAKohpomBcBVXLW-RW1VXAtkTw-BKd7tHmeFJgmf9CM3vi1Ki-Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>


On 2015/2/2 12:26, Viresh Kumar wrote:
> On 2 February 2015 at 09:46, ethan zhao <ethan.zhao@oracle.com> wrote:
>>   We am talking about the policy allocation and de-allocation. right ?
>>   I showed you the cpufreq_policy_free(policy) doesn't check kobject
>>   refcount  as above.
>>
>>   Hmmm, you are still sleeping in the kobject, wake up and don't mix
>>   water anymore.
> It would be nice if we give each other the respect we deserve, And talk
> about concrete points here.
  Welcome back to the right way.
>>> if (!cpufreq_suspended)
>>>           cpufreq_policy_put_kobj(policy);
>>>
>>> static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
>>> {
>>>           ...
>>>
>>>           kobject_put(kobj);
>>>
>>>           /*
>>>           * We need to make sure that the underlying kobj is
>>>           * actually not referenced anymore by anybody before we
>>>           * proceed with unloading.
>>>           */
>>>           pr_debug("waiting for dropping of refcount\n");
>>>           wait_for_completion(cmp);
>>> }
> I gave you exactly what you wanted to go through, but it seems you
> haven't tried enough.
>
> Before freeing policy with cpufreq_policy_free(), we call
> cpufreq_policy_put_kobj(). Now what does this function do? It waits
> for the completion to fire (wait_for_completion()). This completion
> will only fire when refcount of a kobject becomes zero.
>
> Initially when we create the kobject, it is initialized to one. And the
> last kobject_put() you see above in cpufreq_policy_put_kobj()
> makes it zero. All other cpufreq_cpu_get() and put() should happen
> in pairs, otherwise this refcount will never be zero again.
>
> As soon as the refcount becomes zero, we are sure no one else is
> using the policy structure anymore. And so we free it with
> cpufreq_policy_free().
  But there is no checking against refcount in or before

  cpufreq_policy_free(), that is one issue I mentioned.

>
> That routines doesn't have any tricks and simply frees the policy.
> Because, before calling cpufreq_policy_put_kobj(), we have set
> the per-cpu variable to NULL, nobody else will get the policy
  It is possible cpufreq_cpu_get() within the PPC thread was called just
  before __cpufreq_remove_dev_finish() is to be called in another thread,
  so you set the per_cpu(cpufreq_cpu_data, cpu) to NULL will not prevent
  the actions between cpufreq_cpu_get and cpufreq_cpu_put().

  And then the freeing happens in __cpufreq_remove_dev_finish().
> structure by calling cpufreq_cpu_get(). And that's what my patch
> tried to solve.
>
> Let me know if I wasn't explanatory enough..

Ethan
>
> --
> viresh

