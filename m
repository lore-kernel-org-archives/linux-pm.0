From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 4/8] ACPI: Introduce CPU performance controls using CPPC
Date: Tue, 4 Aug 2015 11:38:46 -0400
Message-ID: <CAJ5Y-eZSO3UT34FYFyAo5WYS5sXfvYFXkJMV9NDcv7PsOFfEmg@mail.gmail.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
	<e83e47153db1e41b9e45701fc14a4fac266cb782.1436464513.git.ashwin.chaugule@linaro.org>
	<55C0D50B.6060101@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35759 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbHDPis (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 11:38:48 -0400
Received: by lbbpo9 with SMTP id po9so8462899lbb.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 08:38:46 -0700 (PDT)
In-Reply-To: <55C0D50B.6060101@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>

On 4 August 2015 at 11:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Ashwin,
>
> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>
>> CPPC stands for Collaborative Processor Performance Controls
>> and is defined in the ACPI v5.0+ spec. It describes CPU
>> performance controls on an abstract and continuous scale
>> allowing the platform (e.g. remote power processor) to flexibly
>> optimize CPU performance with its knowledge of power budgets
>> and other architecture specific knowledge.
>>
>> This patch adds a shim which exports commonly used functions
>> to get and set CPPC specific controls for each CPU. This enables
>> CPUFreq drivers to gather per CPU performance data and use
>> with exisiting governors or even allows for customized governors
>> which are implemented inside CPUFreq drivers.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Reviewed-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/Kconfig     |  14 +
>>   drivers/acpi/Makefile    |   1 +
>>   drivers/acpi/cppc_acpi.c | 812
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h | 137 ++++++++
>>   4 files changed, 964 insertions(+)
>>   create mode 100644 drivers/acpi/cppc_acpi.c
>>   create mode 100644 include/acpi/cppc_acpi.h
>>
>
> [..]
>
>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> new file mode 100644
>> index 0000000..9c89767
>> --- /dev/null
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -0,0 +1,812 @@
>> +/*
>> + * CPPC (Collaborative Processor Performance Control) methods used
>> + * by CPUfreq drivers.
>> + *
>> + * (C) Copyright 2014, 2015 Linaro Ltd.
>> + * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; version 2
>> + * of the License.
>> + *
>> + * CPPC describes a few methods for controlling CPU performance using
>> + * information from a per CPU table called CPC. This table is described
>> in
>> + * the ACPI v5.0+ specification. The table consists of a list of
>> + * registers which may be memory mapped or hardware registers and also
>> may
>> + * include some static integer values.
>> + *
>> + * CPU performance is on an abstract continuous scale as against a
>> discretized
>> + * P-state scale which is tied to CPU frequency only. In brief, the basic
>> + * operation involves:
>> + *
>> + * - OS makes a CPU performance request. (Can provide min and max bounds)
>> + *
>> + * - Platform (such as BMC) is free to optimize request within requested
>> bounds
>> + *   depending on power/thermal budgets etc.
>> + *
>> + * - Platform conveys its decision back to OS
>> + *
>> + * The communication between OS and platform occurs through another
>> medium
>> + * called (PCC) Platform Communication Channel. This is a generic mailbox
>> like
>> + * mechanism which includes doorbell semantics to indicate register
>> updates.
>> + * See drivers/mailbox/pcc.c for details on PCC.
>> + *
>> + * Finer details about the PCC and CPPC spec are available in the latest
>> + * ACPI 5.1 specification.
>> + */
>> +
>> +#define pr_fmt(fmt)    "ACPI CPPC: " fmt
>> +
>> +#include <linux/cpufreq.h>
>> +#include <linux/delay.h>
>> +
>> +#include <acpi/cppc_acpi.h>
>> +/*
>> + * Lock to provide mutually exclusive access to the PCC
>> + * channel. e.g. When the remote updates the shared region
>> + * with new data, the reader needs to be protected from
>> + * other CPUs activity on the same channel.
>> + */
>> +static DEFINE_SPINLOCK(pcc_lock);
>> +
>> +static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>> +
>> +/* This layer handles all the PCC specifics for CPPC. */
>> +static struct mbox_chan *pcc_channel;
>> +static void __iomem *pcc_comm_addr;
>> +static u64 comm_base_addr;
>> +static int pcc_subspace_idx = -1;
>> +static u16 pcc_cmd_delay;
>> +static int pcc_channel_acquired;
>> +
>> +#define NUM_RETRIES 500
>> +
>> +static int send_pcc_cmd(u16 cmd)
>> +{
>> +       int err, result = 0;
>> +       int retries = NUM_RETRIES;
>> +       struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
>> +       struct acpi_pcct_shared_memory *generic_comm_base =
>> +               (struct acpi_pcct_shared_memory *) pcc_comm_addr;
>> +       u32 cmd_latency = pcct_ss->latency;
>> +
>> +       /* Write to the shared comm region. */
>> +       writew(cmd, &generic_comm_base->command);
>> +
>> +       /* Flip CMD COMPLETE bit */
>> +       writew(0, &generic_comm_base->status);
>> +
>> +       err = mbox_send_message(pcc_channel, &cmd);
>> +       if (err < 0) {
>> +               pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
>> +                               cmd, err);
>> +               return err;
>> +       }
>> +
>> +       /* Wait for a nominal time to let platform processes command. */
>> +       udelay(cmd_latency);
>
>
> I don't think above delay belongs here. It should be part of PCC driver.

This delay is PCC subspace specific, so I think it belongs to a client
(subspace).

> I need to go through PCC again, initially I objected that some part of
> client code was in PCC driver which seems to be fixed now with commit
> 33350e6b1833 ("Mailbox: Restructure and simplify PCC mailbox code").
>
> But now I think the controller code is getting into the client side.
> Ideally you shouldn't access anything related to PCC controller here.

I think its fair to address all PCC details specific to the client in
the client side code. Moreover this makes it much cleaner to handle
multiple users of one subspace. e.g. multiple CPUs trying to
concurrently access the CPPC subspace.

>
> As I started looking at PCC, I found few issue there. I will post them
> separately for discussion.

Ok.

Regards,
Ashwin.
