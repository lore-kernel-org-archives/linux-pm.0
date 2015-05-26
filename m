From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/5] firmware: add support for ARM System Control and
 Power Interface(SCPI) protocol
Date: Tue, 26 May 2015 12:18:57 +0100
Message-ID: <556456A1.7030401@arm.com>
References: <1431618155-3132-1-git-send-email-sudeep.holla@arm.com>	
 <1431618155-3132-3-git-send-email-sudeep.holla@arm.com>
 <1432120636.3231.24.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432120636.3231.24.camel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 20/05/15 12:17, Jon Medhurst (Tixy) wrote:
> On Thu, 2015-05-14 at 16:42 +0100, Sudeep Holla wrote:
>> This patch adds support for System Control and Power Interface (SCPI)
>> Message Protocol used between the Application Cores(AP) and the System
>> Control Processor(SCP). The MHU peripheral provides a mechanism for
>> inter-processor communication between SCP's M3 processor and AP.
>>
>> SCP offers control and management of the core/cluster power states,
>> various power domain DVFS including the core/cluster, certain system
>> clocks configuration, thermal sensors and many others.
>>
>> This protocol driver provides interface for all the client drivers using
>> SCPI to make use of the features offered by the SCP.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> CC: Jassi Brar <jassisinghbrar@gmail.com>
>> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
>> ---
>
> Sorry for the delay in looking at this. I have one nitpick below but
> anyway, here's a
>
> Reviewed-by: Jon Medhurst (Tixy) <tixy@linaro.org>
>

Thanks!

> [...]
>> +++ b/drivers/firmware/arm_scpi.c
> [...]
>> +static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
>> +{
>> +	unsigned long flags;
>> +	struct scpi_xfer *t, *match = NULL;
>> +
>> +	spin_lock_irqsave(&ch->rx_lock, flags);
>> +	if (list_empty(&ch->rx_pending)) {
>> +		spin_unlock_irqrestore(&ch->rx_lock, flags);
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry(t, &ch->rx_pending, node)
>> +		if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
>> +			list_del(&t->node);
>> +			match = t;
>> +			break;
>> +		}
>> +	/* check if wait_for_completion is in progress or timed-out */
>> +	if (match && !completion_done(&match->done)) {
>> +		struct scpi_shared_mem *mem = ch->rx_payload;
>> +		int len = min(match->rx_len, CMD_SIZE(cmd));
>> +
>> +		match->status = le32_to_cpu(mem->status);
>> +		memcpy_fromio(match->rx_buf, mem->payload, len);
>> +		if (match->rx_len > len)
>
> rx_len is unsigned and len is signed and so I had to go refresh my
> memory from the C standard before I could convince myself that this if
> statement was OK. Might be clearer if len was unsigned, especially as
> it's the 'min' of two unsigned values.
>

Fixed locally for next version.

Regards,
Sudeep
