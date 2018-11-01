From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] ARM: cpuidle: Don't register the driver when back-end
 init returns -ENXIO
Date: Thu, 1 Nov 2018 13:22:05 +0100
Message-ID: <CAPDyKFrC83aPWEgUNUcptJXwgs8jL7D3J1xremeXzWjQ-VrxtQ@mail.gmail.com>
References: <20181026144843.3028-1-ulf.hansson@linaro.org>
 <20181029174456.GA9687@e107981-ln.cambridge.arm.com>
 <CAPDyKFp57pZwTzAPGkeLGj+okYvkOx_i7zZcdphJsLFeKd_m+w@mail.gmail.com>
 <20181101113831.GB6608@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181101113831.GB6608@e107981-ln.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lina Iyer <ilina@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 1 November 2018 at 12:38, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Oct 30, 2018 at 11:24:49AM +0100, Ulf Hansson wrote:
>> On 29 October 2018 at 18:45, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Fri, Oct 26, 2018 at 04:48:43PM +0200, Ulf Hansson wrote:
>> >> There's no point to register the cpuidle driver for the current CPU, when
>> >> the initialization of the arch specific back-end data fails by returning
>> >> -ENXIO.
>> >>
>> >> Instead, let's re-order the sequence to its original flow, by first trying
>> >> to initialize the back-end part and then act accordingly on the returned
>> >> error code. Additionally, let's print the error message, no matter of what
>> >> error code that was returned.
>> >>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> ---
>> >>
>> >> Note, as far as I can tell it's only qcom-spm that may return -ENXIO, which also
>> >> was original reason to why this error path was invented.
>> >>
>> >> Unfurtunate I don't have a qcom spm platfrom at hand, however I manually tried
>> >> this by hacking the PSCI driver to return -ENXIO for some CPUs. So I assume it
>> >> should then also work for qcom spm.
>> >>
>> >> ---
>> >>  drivers/cpuidle/cpuidle-arm.c | 22 ++++++++++------------
>> >>  1 file changed, 10 insertions(+), 12 deletions(-)
>> >>
>> >> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> >> index 073557f433eb..df564d783216 100644
>> >> --- a/drivers/cpuidle/cpuidle-arm.c
>> >> +++ b/drivers/cpuidle/cpuidle-arm.c
>> >> @@ -103,13 +103,6 @@ static int __init arm_idle_init_cpu(int cpu)
>> >>               goto out_kfree_drv;
>> >>       }
>> >>
>> >> -     ret = cpuidle_register_driver(drv);
>> >> -     if (ret) {
>> >> -             if (ret != -EBUSY)
>> >> -                     pr_err("Failed to register cpuidle driver\n");
>> >> -             goto out_kfree_drv;
>> >> -     }
>> >> -
>> >>       /*
>> >>        * Call arch CPU operations in order to initialize
>> >>        * idle states suspend back-end specific data
>> >> @@ -117,15 +110,20 @@ static int __init arm_idle_init_cpu(int cpu)
>> >>       ret = arm_cpuidle_init(cpu);
>> >>
>> >>       /*
>> >> -      * Skip the cpuidle device initialization if the reported
>> >> +      * Allow the initialization to continue for other CPUs, if the reported
>> >>        * failure is a HW misconfiguration/breakage (-ENXIO).
>> >>        */
>> >> -     if (ret == -ENXIO)
>> >> -             return 0;
>> >
>> > I wonder whether moving the drv allocation and dt initialization after
>> > arm_cpuidle_init(cpu) would simplify the error path; the patch makes sense
>> > the error path is getting a bit hard to read - maybe we can simplify it.
>>
>> Yep, exactly that is happening in patch 2/2. But as I also told
>> Daniel, I wanted to take small steps and keep one change per patch.
>>
>> Does it make sense to keep this as is, when you have looked at patch 2/2?
>>
>> >
>> > I think, if you can single it out, it would be good to add a Fixes:
>> > tag too.
>>
>> I can do that, but I am not sure it actually solves a problem, besides
>> improving the error path.
>>
>> Or what did you have in mind?
>
> I am not sure it counts as a bug but leaving the driver registered even if
> the following set-up fails is certainly not the expected behaviour.

I agree.

>
> Hardly urgent but still a fix.

You have a point. However, the fixes tag would point to a rather old
commit. Anyway, I can provide a stable tag as well, to point to what
release it can be picked without conflicts. Then it's up to others to
make a backport to older releases, if they like.

Kind regards
Uffe
