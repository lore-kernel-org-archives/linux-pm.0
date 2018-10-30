From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] ARM: cpuidle: Don't register the driver when back-end
 init returns -ENXIO
Date: Tue, 30 Oct 2018 11:20:39 +0100
Message-ID: <CAPDyKFqsCwLXhxeNfx0hVas3Qmj-qJ96sgNFi+Ogr0aUAfNxtw@mail.gmail.com>
References: <20181026144843.3028-1-ulf.hansson@linaro.org>
 <6313b4d7-a2a7-98c4-3951-0a1c3e4ff2d5@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6313b4d7-a2a7-98c4-3951-0a1c3e4ff2d5@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lina Iyer <ilina@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 29 October 2018 at 19:10, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 26/10/2018 16:48, Ulf Hansson wrote:
>> There's no point to register the cpuidle driver for the current CPU, when
>> the initialization of the arch specific back-end data fails by returning
>> -ENXIO.
>>
>> Instead, let's re-order the sequence to its original flow, by first trying
>> to initialize the back-end part and then act accordingly on the returned
>> error code. Additionally, let's print the error message, no matter of what
>> error code that was returned.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Note, as far as I can tell it's only qcom-spm that may return -ENXIO, which also
>> was original reason to why this error path was invented.
>>
>> Unfurtunate I don't have a qcom spm platfrom at hand, however I manually tried
>> this by hacking the PSCI driver to return -ENXIO for some CPUs. So I assume it
>> should then also work for qcom spm.
>>
>> ---
>>  drivers/cpuidle/cpuidle-arm.c | 22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 073557f433eb..df564d783216 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -103,13 +103,6 @@ static int __init arm_idle_init_cpu(int cpu)
>>               goto out_kfree_drv;
>>       }
>>
>> -     ret = cpuidle_register_driver(drv);
>> -     if (ret) {
>> -             if (ret != -EBUSY)
>> -                     pr_err("Failed to register cpuidle driver\n");
>> -             goto out_kfree_drv;
>> -     }
>> -
>
> Why not move the following block at the beginning of the function ?

That's kind of what is happening in patch 2/2.

However, I wanted to take small steps, isolating one change per patch.
Does it make sense to keep $subject patch as is, when you look at
patch2/2?

>
> --->
>
>         /*
>          * Call arch CPU operations in order to initialize
>          * idle states suspend back-end specific data
>          */
>         ret = arm_cpuidle_init(cpu);
>
>         /*
>          * Skip the cpuidle device initialization if the reported
>          * failure is a HW misconfiguration/breakage (-ENXIO).
>          */
>         if (ret == -ENXIO)
>                 return 0;
>
>         if (ret) {
>                 pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>                 s/goto out_unregister_drv;/return ret;/
>         }
>
> <---

[...]

Kind regards
Uffe
