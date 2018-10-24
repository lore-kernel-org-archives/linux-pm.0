From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v3 3/3] drivers: qcom: rpmh: disallow active requests in
 solver mode
Date: Wed, 24 Oct 2018 14:16:37 -0600
Message-ID: <20181024201637.GG17444@codeaurora.org>
References: <1539050912-25749-1-git-send-email-rplsssn@codeaurora.org>
 <1539050912-25749-4-git-send-email-rplsssn@codeaurora.org>
 <CAE=gft4qNfRFN2sXG7gX0kV5AGCtHAdLNxD5fz1RAbZ-8WCoDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE=gft4qNfRFN2sXG7gX0kV5AGCtHAdLNxD5fz1RAbZ-8WCoDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: rplsssn@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, Doug Anderson <dianders@chromium.org>, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 24 2018 at 11:43 -0600, Evan Green wrote:
>On Mon, Oct 8, 2018 at 7:09 PM Raju P.L.S.S.S.N <rplsssn@codeaurora.org> wrote:
>>
>> From: Lina Iyer <ilina@codeaurora.org>
>>
>> Controllers may be in 'solver' state, where they could be in autonomous
>> mode executing low power modes for their hardware and as such are not
>> available for sending active votes. Device driver may notify RPMH API
>> that the controller is in solver mode and when in such mode, disallow
>> requests from platform drivers for state change using the RSC.
>
>Maybe I'm being dense, but I don't really get it. So in solver mode,
>the whole RSC is just disabled? Solver mode just figures out what
>state to put the hardware in without needing all these votes? Sounds
>cool, why doesn't it just do that all the time? Can you describe an
>example usecase of a real client that would use solver mode, and how
>that works?
>
You are right. Solver just figures out the state to put the hardware in
for a short period of time. Usually when a usecase runs and the hw block
can periodically sleep while a partner/client is busy processing the
data, the solver can take care of figuring out the next wakeup and
choose the best low power mode for the hardware block and reduce the
votes. But all that have to be pre-programmed into the hardware. The
display RSC is a good example. A smart display controller can pick up
the data and show it on the screen and sleep until the next data needs
to be sent. The driver can configure the active and therefore the wake
values of the bus clocks and the sleep value, it can run without CPU
intervention. The display driver makes the decision to put the block in
solver mode and informs the RPMH block that the hardware is not to be
used for active requests or writing any sleep/wake votes.

Coordinating that with the drivers is a major pain point involving
multiple drivers. To avoid that, we let the RPMH know that the RSC is
running in solver mode and will ignore voting that may happen from
drivers.

Thanks,
Lina

>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>> Chanages in v3
>>  - Add functionality to set solver mode for RSC controller
>>  - return -EINVAL if active requests are sent in solver mode
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |  5 ++++
>>  drivers/soc/qcom/rpmh-rsc.c      | 31 ++++++++++++++++++++++++
>>  drivers/soc/qcom/rpmh.c          | 51 ++++++++++++++++++++++++++++++++++++++++
>>  include/soc/qcom/rpmh.h          |  5 ++++
>>  4 files changed, 92 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> index 4b891c23..0923c45 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> @@ -70,12 +70,14 @@ struct rpmh_request {
>>   * @cache_lock: synchronize access to the cache data
>>   * @dirty: was the cache updated since flush
>>   * @batch_cache: Cache sleep and wake requests sent as batch
>> + * @in_solver_mode: Controller is busy in solver mode
>>   */
>>  struct rpmh_ctrlr {
>>         struct list_head cache;
>>         spinlock_t cache_lock;
>>         bool dirty;
>>         struct list_head batch_cache;
>> +       bool in_solver_mode;
>>  };
>>
>>  /**
>> @@ -86,6 +88,7 @@ struct rpmh_ctrlr {
>>   * @base:       start address of the RSC's DRV registers
>>   * @tcs_base:   start address of the TCS registers in this controller
>>   * @id:         instance id in the controller (Direct Resource Voter)
>> + * @in_solver_mode: Controller is in solver mode
>>   * @num_tcs:    number of TCSes in this DRV
>>   * @tcs:        TCS groups
>>   * @tcs_in_use: s/w state of the TCS
>> @@ -97,6 +100,7 @@ struct rsc_drv {
>>         void __iomem *base;
>>         void __iomem *tcs_base;
>>         int id;
>> +       bool in_solver_mode;
>>         int num_tcs;
>>         struct tcs_group tcs[TCS_TYPE_NR];
>>         DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
>> @@ -107,6 +111,7 @@ struct rsc_drv {
>>  int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
>>  int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>>                              const struct tcs_request *msg);
>> +void rpmh_rsc_mode_solver_set(struct rsc_drv *drv, bool enable);
>>  int rpmh_rsc_invalidate(struct rsc_drv *drv);
>>  int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg);
>>  bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index 9cc303e..17126be 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -386,6 +386,11 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>                 return PTR_ERR(tcs);
>>
>>         spin_lock(&drv->lock);
>> +
>> +       if (msg->state == RPMH_ACTIVE_ONLY_STATE && drv->in_solver_mode) {
>> +               ret = -EINVAL;
>> +               goto done_write;
>> +       }
>>         /*
>>          * The h/w does not like if we send a request to the same address,
>>          * when one is already in-flight or being processed.
>> @@ -525,6 +530,31 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>  }
>>
>>  /**
>> + *  rpmh_rsc_mode_solver_set: Enable/disable solver mode
>> + *
>> + *  @drv: The controller
>> + *
>> + *  enable: boolean state to be set - true/false
>
>Add an @?
>
>> + */
>> +void rpmh_rsc_mode_solver_set(struct rsc_drv *drv, bool enable)
>> +{
>> +       int m;
>> +       struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
>> +
>> +again:
>> +       spin_lock(&drv->lock);
>> +       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +               if (!tcs_is_free(drv, m)) {
>> +                       spin_unlock(&drv->lock);
>> +                       goto again;
>> +               }
>> +       }
>> +       drv->in_solver_mode = enable;
>> +       spin_unlock(&drv->lock);
>
>I don't see you actually telling the controller to be in solver mode.
>So I guess this is more informing the rpmh driver that something has
>happened behind its back? Maybe the example will help me understand
>this.
>
>> +
>> +}
>> +
>> +/**
>>   *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>>   *
>>   *  @drv: The controller
>> @@ -718,6 +748,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>>                 return ret;
>>
>>         spin_lock_init(&drv->lock);
>> +       drv->in_solver_mode = false;
>>         bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
>>
>>         irq = platform_get_irq(pdev, drv->id);
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index 43eb981..e6e98d4 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -5,6 +5,7 @@
>>
>>  #include <linux/atomic.h>
>>  #include <linux/bug.h>
>> +#include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/kernel.h>
>> @@ -75,6 +76,42 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
>>         return &drv->client;
>>  }
>>
>> +static int check_ctrlr_state(struct rpmh_ctrlr *ctrlr, enum rpmh_state state)
>> +{
>> +       int ret = 0;
>> +
>> +       /* Do not allow setting active votes when in solver mode */
>> +       spin_lock(&ctrlr->cache_lock);
>> +       if (ctrlr->in_solver_mode && state == RPMH_ACTIVE_ONLY_STATE)
>> +               ret = -EBUSY;
>> +       spin_unlock(&ctrlr->cache_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * rpmh_mode_solver_set: Indicate that the RSC controller hardware has
>> + * been configured to be in solver mode
>> + *
>> + * @dev: the device making the request
>> + * @enable: Boolean value indicating if the controller is in solver mode.
>> + *
>> + * When solver mode is enabled, passthru API will not be able to send wake
>> + * votes, just awake and active votes.
>
>I don't understand this comment, maybe sharpening up the terminology
>will help me?
>
>> + */
>> +int rpmh_mode_solver_set(const struct device *dev, bool enable)
>> +{
>> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>> +
>> +       spin_lock(&ctrlr->cache_lock);
>> +       rpmh_rsc_mode_solver_set(ctrlr_to_drv(ctrlr), enable);
>> +       ctrlr->in_solver_mode = enable;
>> +       spin_unlock(&ctrlr->cache_lock);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(rpmh_mode_solver_set);
>> +
>>  void rpmh_tx_done(const struct tcs_request *msg, int r)
>>  {
>>         struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
>> @@ -230,8 +267,13 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
>>                      const struct tcs_cmd *cmd, u32 n)
>>  {
>>         struct rpmh_request *rpm_msg;
>> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>>         int ret;
>>
>> +       ret = check_ctrlr_state(ctrlr, state);
>> +       if (ret)
>> +               return ret;
>> +
>>         rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
>>         if (!rpm_msg)
>>                 return -ENOMEM;
>> @@ -262,11 +304,16 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
>>  {
>>         DECLARE_COMPLETION_ONSTACK(compl);
>>         DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
>> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>>         int ret;
>>
>>         if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
>>                 return -EINVAL;
>>
>> +       ret = check_ctrlr_state(ctrlr, state);
>> +       if (ret)
>> +               return ret;
>> +
>>         memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
>>         rpm_msg.msg.num_cmds = n;
>>
>> @@ -353,6 +400,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>>         if (!cmd || !n)
>>                 return -EINVAL;
>>
>> +       ret = check_ctrlr_state(ctrlr, state);
>> +       if (ret)
>> +               return ret;
>> +
>>         while (n[count] > 0)
>>                 count++;
>>         if (!count)
>> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
>> index 4c4b013..e8356b6 100644
>> --- a/include/soc/qcom/rpmh.h
>> +++ b/include/soc/qcom/rpmh.h
>> @@ -29,6 +29,8 @@ int rpmh_write_pdc_data(const struct device *dev,
>>
>>  int rpmh_ctrlr_idle(const struct device *dev);
>>
>> +int rpmh_mode_solver_set(const struct device *dev, bool enable);
>> +
>>  #else
>>
>>  static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
>> @@ -58,6 +60,9 @@ static inline int rpmh_write_pdc_data(const struct device *dev,
>>  static inline int rpmh_ctrlr_idle(const struct device *dev)
>>  { return -ENODEV; }
>>
>> +static inline int rpmh_mode_solver_set(const struct device *dev, bool enable)
>> +{ return -ENODEV; }
>> +
>>  #endif /* CONFIG_QCOM_RPMH */
>>
>>  #endif /* __SOC_QCOM_RPMH_H__ */
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of the Code Aurora Forum, hosted by The Linux Foundation.
>>
