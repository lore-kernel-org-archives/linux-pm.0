From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 4/4] drivers: qcom: rpmh: add RPMH helper functions
Date: Mon, 5 Feb 2018 11:50:07 -0800
Message-ID: <20180205195007.GD9465@builder>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-5-ilina@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46733 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeBETuL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Feb 2018 14:50:11 -0500
Received: by mail-pg0-f65.google.com with SMTP id s9so19465497pgq.13
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2018 11:50:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180119000157.7380-5-ilina@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Thu 18 Jan 16:01 PST 2018, Lina Iyer wrote:
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index b7951ce87663..0dba46387f1c 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -11,4 +11,4 @@ obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>  obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
> -obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
> +obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o rpmh.o

I think it would be better if you built these two objects into the same
module;

obj-$(CONFIG_QCOM_RPMH) += qcom_rpmh.o
qcom_rpmh-y += rpmh-rsc.o
qcom_rpmh-y += rpmh.o

> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
[..]
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
[..]
> +#define RPMH_TIMEOUT			msecs_to_jiffies(10000)

10 * HZ

> +
> +#define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)	\
> +	struct rpmh_msg name = {			\
> +		.msg = {				\
> +			.state = s,			\
> +			.payload = name.cmd,		\
> +			.num_payload = 0,		\
> +			.is_complete = true,		\
> +			.invalidate = false,		\
> +		},					\
> +		.cmd = { { 0 } },			\
> +		.completion = q,			\
> +		.wait_count = c,			\
> +		.rc = rc,				\
> +	}
> +
> +/**
> + * rpmh_msg: the message to be sent to rpmh-rsc
> + *
> + * @msg: the request
> + * @cmd: the payload that will be part of the @msg
> + * @completion: triggered when request is done
> + * @wait_count: count of waiters for this completion
> + * @err: err return from the controller
> + */
> +struct rpmh_msg {

struct rpmh_request ?

> +	struct tcs_mbox_msg msg;
> +	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
> +	struct completion *completion;
> +	atomic_t *wait_count;

When will @wait_count > 1? As far as I can see the only purpose would be
to be able to control whether you should complete @completion 0 or N
times; but 0 times is covered already by not specifying a @completion.

> +	struct rpmh_client *rc;
> +	int err;
> +};
> +
> +/**
> + * rpmh_ctrlr: our representation of the controller
> + *
> + * @drv: the controller instance
> + */
> +struct rpmh_ctrlr {
> +	struct rsc_drv *drv;

Is this going to grow in the future? Otherwise just drop it and
reference the rsc_drv directly. (Even if it's growing it might be
cleaner to introduce it at that point)

> +};
> +
> +/**
> + * rpmh_client: the client object
> + *
> + * @dev: the platform device that is the owner
> + * @ctrlr: the controller associated with this client.
> + */
> +struct rpmh_client {
> +	struct device *dev;
> +	struct rpmh_ctrlr *ctrlr;
> +};
> +
> +static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_MBOXES];
> +static DEFINE_MUTEX(rpmh_ctrlr_mutex);

The client needs a reference to the rsc_drv, using the rpmh_ctrlr
abstraction and these global variables only seems to add unnecessary
complexity.

> +
> +void rpmh_tx_done(struct tcs_mbox_msg *msg, int r)
> +{
> +	struct rpmh_msg *rpm_msg = container_of(msg, struct rpmh_msg, msg);
> +	atomic_t *wc = rpm_msg->wait_count;
> +	struct completion *compl = rpm_msg->completion;
> +
> +	rpm_msg->err = r;
> +
> +	if (r)
> +		dev_err(rpm_msg->rc->dev,
> +			"RPMH TX fail in msg addr 0x%x, err=%d\n",
> +			rpm_msg->msg.payload[0].addr, r);
> +
> +	/* Signal the blocking thread we are done */
> +	if (wc && atomic_dec_and_test(wc))
> +		if (compl)
> +			complete(compl);

I think that you should drop this function and just complete
@rpm_msg->completion in the rcs driver.

> +}
> +EXPORT_SYMBOL(rpmh_tx_done);
> +
> +/**
> + * wait_for_tx_done: Wait until the response is received.
> + *
> + * @rc: The RPMH client
> + * @compl: The completion object
> + * @addr: An addr that we sent in that request
> + * @data: The data for the address in that request
> + *
> + */
> +static inline int wait_for_tx_done(struct rpmh_client *rc,
> +		struct completion *compl, u32 addr, u32 data)
> +{
> +	int ret;
> +
> +	ret = wait_for_completion_timeout(compl, RPMH_TIMEOUT);
> +	if (ret)
> +		dev_dbg(rc->dev,
> +			"RPMH response received addr=0x%x data=0x%x\n",
> +			addr, data);
> +	else
> +		dev_err(rc->dev,
> +			"RPMH response timeout addr=0x%x data=0x%x\n",
> +			addr, data);

The request can contain a number of commands and these error messages
ends up printing the first one, on behalf of the client. I suspect that
this isn't useful enough in most cases, causing the client to print
another time.

I therefor suggest that you omit these prints.

> +
> +	return  (ret > 0) ? 0 : -ETIMEDOUT;
> +}
> +
> +/**
> + * __rpmh_write: send the RPMH request
> + *
> + * @rc: The RPMH client
> + * @state: Active/Sleep request type
> + * @rpm_msg: The data that needs to be sent (payload).
> + */
> +int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +			struct rpmh_msg *rpm_msg)
> +{
> +	int ret = -EFAULT;
> +
> +	rpm_msg->msg.state = state;
> +
> +	if (state == RPMH_ACTIVE_ONLY_STATE) {
> +		WARN_ON(irqs_disabled());
> +		ret = rpmh_rsc_send_data(rc->ctrlr->drv, &rpm_msg->msg);
> +		if (!ret)
> +			dev_dbg(rc->dev,
> +				"RPMH request sent addr=0x%x, data=0x%x\n",
> +				rpm_msg->msg.payload[0].addr,
> +				rpm_msg->msg.payload[0].data);
> +		else
> +			dev_warn(rc->dev,
> +				"Error in RPMH request addr=0x%x, data=0x%x\n",
> +				rpm_msg->msg.payload[0].addr,
> +				rpm_msg->msg.payload[0].data);

Same thing here, for the user to be able to make sense of this error the
client will have to print something with more context. So I think you
should omit these too.


tracing failing addr/data pairs might make sense though!

> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * rpmh_write: Write a set of RPMH commands and block until response
> + *
> + * @rc: The RPMh handle got from rpmh_get_dev_channel
> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The number of elements in payload
> + *
> + * May sleep. Do not call from atomic contexts.
> + */
> +int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +			struct tcs_cmd *cmd, int n)
> +{
> +	DECLARE_COMPLETION_ONSTACK(compl);
> +	atomic_t wait_count = ATOMIC_INIT(1);
> +	DEFINE_RPMH_MSG_ONSTACK(rc, state, &compl, &wait_count, rpm_msg);
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(rc) || !cmd || n <= 0 || n > MAX_RPMH_PAYLOAD)
> +		return -EINVAL;
> +
> +	might_sleep();
> +
> +	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
> +	rpm_msg.msg.num_payload = n;
> +
> +	ret = __rpmh_write(rc, state, &rpm_msg);
> +	if (ret)
> +		return ret;
> +
> +	return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);

As you're returning here the completion object on the stack will be
trash, so you must inform rpmh_rsc that it may no longer complete it.

I suggest that you provide two functions in the rsc driver;
rpmh_rsc_send_sync() and rpmh_rsc_send_async(), and move the
wait-for-completion into the sync one. Also make the sync one return the
msg->err (and drop the tx_done cross-call).

(Or call them rpmh_rsc_send_wait() and rpmh_rsc_send_nowait())

> +}
> +EXPORT_SYMBOL(rpmh_write);
> +
> +static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
> +{
> +	int i;
> +	struct rsc_drv *drv = dev_get_drvdata(pdev->dev.parent);
> +	struct rpmh_ctrlr *ctrlr = ERR_PTR(-EFAULT);
> +
> +	if (!drv)
> +		return ctrlr;
> +
> +	mutex_lock(&rpmh_ctrlr_mutex);
> +	for (i = 0; i < RPMH_MAX_MBOXES; i++)
> +		if (rpmh_rsc[i].drv == drv) {
> +			ctrlr = &rpmh_rsc[i];
> +			goto unlock;
> +		}
> +
> +	if (i == RPMH_MAX_MBOXES)
> +		for (i = 0; i < RPMH_MAX_MBOXES; i++)
> +			if (rpmh_rsc[i].drv == NULL) {
> +				ctrlr = &rpmh_rsc[i];
> +				ctrlr->drv = drv;
> +				break;
> +			}

I fail to see the reason for tracking rsc_drv references in a global
array and try to find an existing one here. Just return the rsc_drv
acquired from dev_get_drvdata() to the caller.

> +unlock:
> +	mutex_unlock(&rpmh_ctrlr_mutex);
> +	return ctrlr;
> +}
> +
> +/**
> + * rpmh_get_client: Get the RPMh handle
> + *
> + * @pdev: the platform device which needs to communicate with RPM
> + * accelerators
> + * May sleep.
> + */
> +struct rpmh_client *rpmh_get_client(struct platform_device *pdev)

To make this analog to previous rpm drivers I think you should take the
device * of the parent here. I.e. client does:

	rpmh = rpmh_get_client(&pdev->dev.parent).


I recognize that this removes the possibility of providing error
messages indicating which client caused the fault, but by above
suggestions these functions would be moved into the rsc driver; or the
error would be propagated to the client which could print these
themselves.

> +{
> +	struct rpmh_client *rc;
> +
> +	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
> +	if (!rc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc->dev = &pdev->dev;
> +	rc->ctrlr = get_rpmh_ctrlr(pdev);
> +	if (IS_ERR(rc->ctrlr)) {
> +		kfree(rc);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(rpmh_get_client);
> +
> +/**
> + * rpmh_release: Release the RPMH client
> + *
> + * @rc: The RPMh handle to be freed.
> + */
> +void rpmh_release(struct rpmh_client *rc)
> +{
> +	kfree(rc);

If you reduce above function to just return a rsc_drv reference you
don't even need a release function, which simplifies clients further.

> +}
> +EXPORT_SYMBOL(rpmh_release);
> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
[..]
> +struct rpmh_client;
> +
> +#ifdef CONFIG_QCOM_RPMH

I think it would be fine to just make clients depend on QCOM_RPMH. If
you would prefer to get the compile testing in those drivers then make
this:

#if IS_ENABLED(CONFIG_QCOM_RPMH)

In case someone in the future decides to make RPMH tristate.

Regards,
Bjorn
