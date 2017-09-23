From: Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH 1/2] i2c: designware: switch to suspend_late/resume_early
Date: Sat, 23 Sep 2017 09:17:48 -0700
Message-ID: <CAA93t1qPE9pGPs2oaG-fUC8=vn8Eyx_zJHq-L1RoUW8214C2yw@mail.gmail.com>
References: <20170920223152.100641-1-rajatja@google.com> <CAJZ5v0jJ-WQ15BNHrno_DFqyJU1Rn4KaBnaA5bbK8WmmmWfNgw@mail.gmail.com>
 <CACK8Z6HQRyjFOgubBm02zZSz_o3LOgxsNbMj0VkpwN0thfZzzg@mail.gmail.com>
 <2747669.9xpxs90BZc@aspire.rjw.lan> <CAJZ5v0jErc1yZBdQmMPnzceVAKeR+PFBCb_eT5ZRNS2Fh3VJ6A@mail.gmail.com>
 <CAA93t1qk_SY97Pn8mCa+8-Y-57yvLcAAvsxKqZKEM-7fBiPZkg@mail.gmail.com>
Reply-To: rajatxjain@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAA93t1qk_SY97Pn8mCa+8-Y-57yvLcAAvsxKqZKEM-7fBiPZkg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rajat Jain <rajatja@google.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Furquan Shaikh <furquan@google.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 23, 2017 at 8:49 AM, Rajat Jain <rajatxjain@gmail.com> wrote:
> On Sat, Sep 23, 2017 at 5:55 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, Sep 21, 2017 at 4:11 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Thursday, September 21, 2017 3:13:56 AM CEST Rajat Jain wrote:
>>>> On Wed, Sep 20, 2017 at 5:24 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> > On Thu, Sep 21, 2017 at 12:31 AM, Rajat Jain <rajatja@google.com> wrote:
>>>> >> Ref: https://lkml.org/lkml/2017/9/19/649
>>>> >>
>>>> >> The bus controllers should suspend the bus operations only after
>>>> >> all of the devices on the bus have suspended their device
>>>> >> completely. Since the i2c_client drivers could be talking to
>>>> >> their devices in their suspend_late() calls, lets ensure that the
>>>> >> bus is alive by that time. Thus moving the controller suspend logic to
>>>> >> suspend_late().
>>>> >>
>>>> >> Signed-off-by: Rajat Jain <rajatja@google.com>
>>>> >> ---
>>>> >>  drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
>>>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>> >>
>>>> >> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> >> index 0e65b97842b4..66dd7f844c40 100644
>>>> >> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> >> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> >> @@ -468,7 +468,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
>>>> >>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>>>> >>         .prepare = dw_i2c_plat_prepare,
>>>> >>         .complete = dw_i2c_plat_complete,
>>>> >> -       SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>>>> >> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>>>> >>         SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
>>>> >>                            dw_i2c_plat_resume,
>>>> >>                            NULL)
>>>> >
>>>> > No, you can't just do that.
>>>> >
>>>> > I sent patches to do it properly before my trip to LA last week, it
>>>> > shouldn't be overly difficult to find them in the mailing list
>>>> > archives.  I can look them up tomorrow if need be.
>>>>
>>>> Thanks, I am guessing you mean this?
>>>>
>>>> https://patchwork.kernel.org/patch/9939807/
>>>
>>> Yes, that's what I mean.
>>
>> BTW, does this patchset work for you?
>
> Yes, I don't see the issue I was seeing earlier with your patch.
> Please feel free to adds,

I think I made my sentence ambiguous. Let me rephrase: Yes, with your
patch, I don't see the issue I was seeing earlier (without your patch)

>
> Tested-by: Rajat Jain <rajatja@google.com>
>
>>
>> Thanks,
>> Rafael
