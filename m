From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 1/2] Mailbox: Restructure and simplify PCC mailbox code
Date: Fri, 13 Feb 2015 08:07:44 -0500
Message-ID: <CAJ5Y-eYZ1TuX8wvJOH9Os7qQGXnefxeCTqG65QA__0aornNo2w@mail.gmail.com>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
	<1422392638-31334-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43226 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbbBMNHq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 08:07:46 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so11814657wib.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2015 05:07:45 -0800 (PST)
In-Reply-To: <1422392638-31334-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hello,

On 27 January 2015 at 16:03, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Previously the PCC driver depended on the client
> side to map the communication space base address. This region
> was was then used in the PCC driver and the client side.
> The client side used this region to read and write its data
> and the PCC driver used it to only write the PCC command.
> Removing this split simplifies the PCC driver a lot. This patch
> moves all communication region read/writes to the client side.
> The PCC clients can now drive the PCC mailbox controller via the
> mbox_client_txdone() method.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/mailbox/pcc.c | 122 +++++++++++++++-----------------------------------
>  1 file changed, 37 insertions(+), 85 deletions(-)

Gentle reminder for this patch specifically. It can be pulled in by
itself separately from the CPPC patch[2/2], which understandably may
need more time for review. Apart from the simplification done here,
there is one more change based on a comment I got from Rafael to
convert a pr_err() in the init function to pr_debug(). The "PCC Probe
failed" message seems to be raising false positives on X86 test
reports. Please let me know if there are any other suggestions, before
I respin another version for this.

Thanks,
Ashwin.

>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 6dbf6fc..e0c8e29 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -20,10 +20,35 @@
>   *  shared memory regions as defined in the PCC table entries. The PCC
>   *  specification supports a Doorbell mechanism for the PCC clients
>   *  to notify the platform about new data. This Doorbell information
> - *  is also specified in each PCC table entry. See pcc_send_data()
> - *  and pcc_tx_done() for basic mode of operation.
> + *  is also specified in each PCC table entry.
>   *
> - *  For more details about PCC, please see the ACPI specification from
> + *  Typical high level flow of operation is:
> + *
> + *  PCC Reads:
> + *  * Client tries to acquire a channel lock.
> + *  * After it is acquired it writes READ cmd in communication region cmd
> + *             address.
> + *  * Client issues mbox_send_message() which rings the PCC doorbell
> + *             for its PCC channel.
> + *  * If command completes, then client has control over channel and
> + *             it can proceed with its reads.
> + *  * Client releases lock.
> + *
> + *  PCC Writes:
> + *  * Client tries to acquire channel lock.
> + *  * Client writes to its communication region after it acquires a
> + *             channel lock.
> + *  * Client writes WRITE cmd in communication region cmd address.
> + *  * Client issues mbox_send_message() which rings the PCC doorbell
> + *             for its PCC channel.
> + *  * If command completes, then writes have succeded and it can release
> + *             the channel lock.
> + *
> + *  There is a Nominal latency defined for each channel which indicates
> + *  how long to wait until a command completes. If command is not complete
> + *  the client needs to retry or assume failure.
> + *
> + *     For more details about PCC, please see the ACPI specification from
>   *  http://www.uefi.org/ACPIv5.1 Section 14.
>   *
>   *  This file implements PCC as a Mailbox controller and allows for PCC
> @@ -42,8 +67,6 @@
>  #include "mailbox.h"
>
>  #define MAX_PCC_SUBSPACES      256
> -#define PCCS_SS_SIG_MAGIC      0x50434300
> -#define PCC_CMD_COMPLETE       0x1
>
>  static struct mbox_chan *pcc_mbox_channels;
>
> @@ -71,23 +94,6 @@ static struct mbox_chan *get_pcc_channel(int id)
>  }
>
>  /**
> - * get_subspace_id - Given a Mailbox channel, find out the
> - *             PCC subspace id.
> - * @chan: Pointer to Mailbox Channel from which we want
> - *             the index.
> - * Return: Errno if not found, else positive index number.
> - */
> -static int get_subspace_id(struct mbox_chan *chan)
> -{
> -       unsigned int id = chan - pcc_mbox_channels;
> -
> -       if (id < 0 || id > pcc_mbox_ctrl.num_chans)
> -               return -ENOENT;
> -
> -       return id;
> -}
> -
> -/**
>   * pcc_mbox_request_channel - PCC clients call this function to
>   *             request a pointer to their PCC subspace, from which they
>   *             can get the details of communicating with the remote.
> @@ -117,7 +123,7 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>         chan = get_pcc_channel(subspace_id);
>
>         if (!chan || chan->cl) {
> -               dev_err(dev, "%s: PCC mailbox not free\n", __func__);
> +               dev_err(dev, "Channel not found for idx: %d\n", subspace_id);
>                 return ERR_PTR(-EBUSY);
>         }
>
> @@ -161,81 +167,30 @@ void pcc_mbox_free_channel(struct mbox_chan *chan)
>  EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>
>  /**
> - * pcc_tx_done - Callback from Mailbox controller code to
> - *             check if PCC message transmission completed.
> - * @chan: Pointer to Mailbox channel on which previous
> - *             transmission occurred.
> - *
> - * Return: TRUE if succeeded.
> - */
> -static bool pcc_tx_done(struct mbox_chan *chan)
> -{
> -       struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
> -       struct acpi_pcct_shared_memory *generic_comm_base =
> -               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
> -       u16 cmd_delay = pcct_ss->latency;
> -       unsigned int retries = 0;
> -
> -       /* Try a few times while waiting for platform to consume */
> -       while (!(readw_relaxed(&generic_comm_base->status)
> -                   & PCC_CMD_COMPLETE)) {
> -
> -               if (retries++ < 5)
> -                       udelay(cmd_delay);
> -               else {
> -                       /*
> -                        * If the remote is dead, this will cause the Mbox
> -                        * controller to timeout after mbox client.tx_tout
> -                        * msecs.
> -                        */
> -                       pr_err("PCC platform did not respond.\n");
> -                       return false;
> -               }
> -       }
> -       return true;
> -}
> -
> -/**
> - * pcc_send_data - Called from Mailbox Controller code to finally
> - *     transmit data over channel.
> + * pcc_send_data - Called from Mailbox Controller code. Used
> + *             here only to ring the channel doorbell. The PCC client
> + *             specific read/write is done in the client driver in
> + *             order to maintain atomicity over PCC channel once
> + *             OS has control over it. See above for flow of operations.
>   * @chan: Pointer to Mailbox channel over which to send data.
> - * @data: Actual data to be written over channel.
> + * @data: Client specific data written over channel. Used here
> + *             only for debug after PCC transaction completes.
>   *
>   * Return: Err if something failed else 0 for success.
>   */
>  static int pcc_send_data(struct mbox_chan *chan, void *data)
>  {
>         struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
> -       struct acpi_pcct_shared_memory *generic_comm_base =
> -               (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>         struct acpi_generic_address doorbell;
>         u64 doorbell_preserve;
>         u64 doorbell_val;
>         u64 doorbell_write;
> -       u16 cmd = *(u16 *) data;
> -       u16 ss_idx = -1;
> -
> -       ss_idx = get_subspace_id(chan);
> -
> -       if (ss_idx < 0) {
> -               pr_err("Invalid Subspace ID from PCC client\n");
> -               return -EINVAL;
> -       }
>
>         doorbell = pcct_ss->doorbell_register;
>         doorbell_preserve = pcct_ss->preserve_mask;
>         doorbell_write = pcct_ss->write_mask;
>
> -       /* Write to the shared comm region. */
> -       writew(cmd, &generic_comm_base->command);
> -
> -       /* Write Subspace MAGIC value so platform can identify destination. */
> -       writel((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
> -
> -       /* Flip CMD COMPLETE bit */
> -       writew(0, &generic_comm_base->status);
> -
> -       /* Sync notification from OSPM to Platform. */
> +       /* Sync notification from OS to Platform. */
>         acpi_read(&doorbell_val, &doorbell);
>         acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
>                         &doorbell);
> @@ -245,7 +200,6 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>
>  static struct mbox_chan_ops pcc_chan_ops = {
>         .send_data = pcc_send_data,
> -       .last_tx_done = pcc_tx_done,
>  };
>
>  /**
> @@ -351,8 +305,6 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>
>         pcc_mbox_ctrl.chans = pcc_mbox_channels;
>         pcc_mbox_ctrl.ops = &pcc_chan_ops;
> -       pcc_mbox_ctrl.txdone_poll = true;
> -       pcc_mbox_ctrl.txpoll_period = 10;
>         pcc_mbox_ctrl.dev = &pdev->dev;
>
>         pr_info("Registering PCC driver as Mailbox controller\n");
> --
> 1.9.1
>
