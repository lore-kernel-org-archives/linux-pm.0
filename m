From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 2 Feb 2015 09:56:49 +0530
Message-ID: <CAKohpomBcBVXLW-RW1VXAtkTw-BKd7tHmeFJgmf9CM3vi1Ki-Q@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
	<CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
	<54CEF123.5050106@oracle.com>
	<CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
	<54CEF574.6040404@oracle.com>
	<CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
	<54CEF7AA.80401@oracle.com>
	<CAKohponfkJVYFTsj6ijy0iY3t-R=zN=M0ZkoDmYa-WYTzPuvmw@mail.gmail.com>
	<54CEFA23.7040705@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CEFA23.7040705@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 February 2015 at 09:46, ethan zhao <ethan.zhao@oracle.com> wrote:
>  We am talking about the policy allocation and de-allocation. right ?
>  I showed you the cpufreq_policy_free(policy) doesn't check kobject
>  refcount  as above.
>
>  Hmmm, you are still sleeping in the kobject, wake up and don't mix
>  water anymore.

It would be nice if we give each other the respect we deserve, And talk
about concrete points here.

>> if (!cpufreq_suspended)
>>          cpufreq_policy_put_kobj(policy);
>>
>> static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
>> {
>>          ...
>>
>>          kobject_put(kobj);
>>
>>          /*
>>          * We need to make sure that the underlying kobj is
>>          * actually not referenced anymore by anybody before we
>>          * proceed with unloading.
>>          */
>>          pr_debug("waiting for dropping of refcount\n");
>>          wait_for_completion(cmp);
>> }

I gave you exactly what you wanted to go through, but it seems you
haven't tried enough.

Before freeing policy with cpufreq_policy_free(), we call
cpufreq_policy_put_kobj(). Now what does this function do? It waits
for the completion to fire (wait_for_completion()). This completion
will only fire when refcount of a kobject becomes zero.

Initially when we create the kobject, it is initialized to one. And the
last kobject_put() you see above in cpufreq_policy_put_kobj()
makes it zero. All other cpufreq_cpu_get() and put() should happen
in pairs, otherwise this refcount will never be zero again.

As soon as the refcount becomes zero, we are sure no one else is
using the policy structure anymore. And so we free it with
cpufreq_policy_free().

That routines doesn't have any tricks and simply frees the policy.
Because, before calling cpufreq_policy_put_kobj(), we have set
the per-cpu variable to NULL, nobody else will get the policy
structure by calling cpufreq_cpu_get(). And that's what my patch
tried to solve.

Let me know if I wasn't explanatory enough..

--
viresh
