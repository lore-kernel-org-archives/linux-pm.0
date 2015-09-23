From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v9 1/5] ACPI: Introduce CPU performance controls using CPPC
Date: Wed, 23 Sep 2015 07:09:49 -0400
Message-ID: <CAJ5Y-ebPbr4WG6bQ_8Haytvd-jzv5f=+WAt4BM4JMATa+csyjA@mail.gmail.com>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org>
	<de2aab7944aea82d7f846e96c193bf577507cdcd.1441830300.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:33084 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbbIWLJw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2015 07:09:52 -0400
Received: by lahh2 with SMTP id h2so21653769lah.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2015 04:09:50 -0700 (PDT)
In-Reply-To: <de2aab7944aea82d7f846e96c193bf577507cdcd.1441830300.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Rafael,

Are there any more suggestions for this patch series? I noticed a
compiler warning, which was strangely hidden before I sent v9. Will
fix and resend if there isnt anything else.

On 9 September 2015 at 16:27, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> CPPC stands for Collaborative Processor Performance Controls
> and is defined in the ACPI v5.0+ spec. It describes CPU
> performance controls on an abstract and continuous scale
> allowing the platform (e.g. remote power processor) to flexibly
> optimize CPU performance with its knowledge of power budgets
> and other architecture specific knowledge.
>
> This patch adds a shim which exports commonly used functions
> to get and set CPPC specific controls for each CPU. This enables
> CPUFreq drivers to gather per CPU performance data and use
> with exisiting governors or even allows for customized governors
> which are implemented inside CPUFreq drivers.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/Kconfig     |  14 +
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/cppc_acpi.c | 755 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 138 +++++++++
>  4 files changed, 908 insertions(+)
>  create mode 100644 drivers/acpi/cppc_acpi.c
>  create mode 100644 include/acpi/cppc_acpi.h
>

[..]

> +
> +static u64 get_phys_pcc_addr(struct cpc_reg *reg)
> +{
> +       /* PCC communication addr space begins at byte offset 0x8. */
> +       return (u64)comm_base_addr + 0x8 + reg->address;
> +}
> +
> +static void cpc_read(struct cpc_reg *reg, u64 *val)
> +{
> +       u64 addr;

Default addr = reg->address; That'll enable sys mem type read/write ops.

> +
> +       if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
> +               addr = get_phys_pcc_addr(reg);

Or alternately, fold this into a function get_phys_addr() which parses
for type PCC, sys mem. etc. and returns address.

> +
> +       acpi_os_read_memory((acpi_physical_address)addr,
> +                       val, reg->bit_width);
> +
> +       /* TODO:Add FFH, SYSTEM_IO support later. */

Will add a pr_err() if type is FFH/Sys IO.
Likewise below.

> +}
> +
> +static void cpc_write(struct cpc_reg *reg, u64 val)
> +{
> +       u64 addr;
> +
> +       if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
> +               addr = get_phys_pcc_addr(reg);
> +
> +       acpi_os_write_memory((acpi_physical_address)addr,
> +                       val, reg->bit_width);
> +
> +       /* TODO:Add FFH, SYSTEM_IO support later. */
> +}
> +

Regards,
Ashwin.
