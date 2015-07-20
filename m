From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 1/8] PCC: Initialize PCC Mailbox earlier at boot
Date: Mon, 20 Jul 2015 15:20:01 +0100
Message-ID: <55AD0391.2040504@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <e5f53a07775cfb896688051b31acb2261ec1d3a2.1436464513.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <e5f53a07775cfb896688051b31acb2261ec1d3a2.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 09/07/15 19:04, Ashwin Chaugule wrote:
> This change initializes the PCC Mailbox earlier than
> the ACPI processor driver. This enables drivers introduced
> in follow up patches (e.g. CPPC) to be probed via the ACPI
> processor driver interface. The CPPC probe requires the PCC
> channel to be initialized for it to query each CPUs performance
> capabilities.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---
>   drivers/mailbox/pcc.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 7e91d68..fcda63e 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -352,4 +352,10 @@ static int __init pcc_init(void)
>
>   	return 0;
>   }
> -device_initcall(pcc_init);
> +
> +/*
> + * Make pcc init postcore so that users of this mailbox
> + * such as the ACPI Processor driver have it available
> + * at their init.
> + */
> +postcore_initcall(pcc_init);
>

I assumed you have explored other options like deferred probe and
finally resorted to this as they are not feasible ? Because setting up
these kind of dependency are prone to create issues later on.

Regards,
Sudeep
