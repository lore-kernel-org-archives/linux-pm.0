From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before putting
 kobject
Date: Mon, 02 Feb 2015 11:38:11 +0800
Message-ID: <54CEF123.5050106@oracle.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org> <54CEECF7.7020504@oracle.com> <CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 2015/2/2 11:24, Viresh Kumar wrote:
> On 2 February 2015 at 08:50, ethan zhao <ethan.zhao@oracle.com> wrote:
>>   This seems couldn't prevent all the 'bad thing' from happening, E.G.
>>
>>
>>   Thread A: Workqueue: kacpi_notify
>>
>>   acpi_processor_notify()
>>     acpi_processor_ppc_has_changed()
>>           cpufreq_update_policy()
>>             cpufreq_cpu_get()
> We take cpufreq_driver_lock() here, and so this will
> block thread B.
  No, there is no  cpufreq_driver_lock acquired between

  cpufreq_cpu_get()  and cpufreq_cpu_put()


>>             beginning the deference of policy        Thread B:
>>             ... ... __cpufreq_remove_dev_finish()
>> cpufreq_policy_free(policy);
>>
>>
>> Perhaps move policy->rwsem out side the policy structure is a way to avoid
>> it completely.
>> and you could stopping the PPC thread stepping forward as my patch as
>> temporary workaround.
> I couldn't understand your problem completely. Apart from giving a detailed
> look of what's going on both threads, always specify where the BUG actually
> is..
The problem is you are using a rwsem inside policy structure to protect its
assessment, that is bad design.

Thanks,
Ethan
