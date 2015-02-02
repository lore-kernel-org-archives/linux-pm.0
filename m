From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 2 Feb 2015 09:39:42 +0530
Message-ID: <CAKohponfkJVYFTsj6ijy0iY3t-R=zN=M0ZkoDmYa-WYTzPuvmw@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
	<CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
	<54CEF123.5050106@oracle.com>
	<CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
	<54CEF574.6040404@oracle.com>
	<CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
	<54CEF7AA.80401@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CEF7AA.80401@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 February 2015 at 09:36, ethan zhao <ethan.zhao@oracle.com> wrote:
>  Is that an idea it supposed to be or fact ?
>
> if (!cpufreq_suspended)
>             cpufreq_policy_free(policy);
>
>  static void cpufreq_policy_free(struct cpufreq_policy *policy)
> {
>     free_cpumask_var(policy->related_cpus);
>     free_cpumask_var(policy->cpus);
>     kfree(policy);
> }
>
>  It seems you just think about it ideally in mind.

if (!cpufreq_suspended)
        cpufreq_policy_put_kobj(policy);

static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
{
        ...

        kobject_put(kobj);

        /*
        * We need to make sure that the underlying kobj is
        * actually not referenced anymore by anybody before we
        * proceed with unloading.
        */
        pr_debug("waiting for dropping of refcount\n");
        wait_for_completion(cmp);
}
