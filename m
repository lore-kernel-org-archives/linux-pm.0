From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v4 2/8] firmware: add support for ARM System Control and
 Power Interface(SCPI) protocol
Date: Thu, 11 Jun 2015 17:24:19 +0530
Message-ID: <CAJe_ZheUknLZuMg-02V-AqyjxX8Nx4oK3O2HapqfCLkkXjngAg@mail.gmail.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
	<1433760002-24120-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f41.google.com ([209.85.216.41]:32972 "EHLO
	mail-vn0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbFKLyU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 07:54:20 -0400
Received: by vnbf190 with SMTP id f190so671003vnb.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 04:54:19 -0700 (PDT)
In-Reply-To: <1433760002-24120-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Olof Johansson <olof@lixom.net>

On 8 June 2015 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
...
> +
> +static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
> +{
> +       unsigned long flags;
> +       struct scpi_xfer *t, *match = NULL;
> +
> +       spin_lock_irqsave(&ch->rx_lock, flags);
> +       if (list_empty(&ch->rx_pending)) {
> +               spin_unlock_irqrestore(&ch->rx_lock, flags);
> +               return;
> +       }
> +
> +       list_for_each_entry(t, &ch->rx_pending, node)
> +               if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
> +                       list_del(&t->node);
> +                       match = t;
> +                       break;
> +               }
> +       /* check if wait_for_completion is in progress or timed-out */
> +       if (match && !completion_done(&match->done)) {
> +               struct scpi_shared_mem *mem = ch->rx_payload;
> +               unsigned int len = min(match->rx_len, CMD_SIZE(cmd));
> +
> +               match->status = le32_to_cpu(mem->status);
> +               memcpy_fromio(match->rx_buf, mem->payload, len);
> +               if (match->rx_len > len)
> +                       memset(match->rx_buf + len, 0, match->rx_len - len);
> +               complete(&match->done);
> +       }
> +       spin_unlock_irqrestore(&ch->rx_lock, flags);
> +}
There doesn't seem to be support for commands sent by remote?
Something like when remote is the thermal master and it needs to send
sensor readings crossing thresholds.
