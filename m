From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/6] PCC: Initialize PCC Mailbox earlier at boot
Date: Wed, 27 May 2015 02:50:40 +0200
Message-ID: <1597157.KLDqcPxL8N@vostro.rjw.lan>
References: <1432590610-8968-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51260 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751434AbbE0AZK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 20:25:10 -0400
In-Reply-To: <1432590610-8968-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: jaswinder.singh@linaro.org, linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com

On Monday, May 25, 2015 05:50:10 PM Ashwin Chaugule wrote:
> This change initializes the PCC Mailbox earlier than
> the ACPI processor driver. This enables drivers introduced
> in follow up patches (e.g. CPPC) to be probed via the ACPI
> processor driver interface. The CPPC probe requires the PCC
> channel to be initialized for it to query each CPUs performance
> capabilites.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/mailbox/pcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 7e91d68..8809587 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -352,4 +352,4 @@ static int __init pcc_init(void)
>  
>  	return 0;
>  }
> -device_initcall(pcc_init);
> +postcore_initcall(pcc_init);

If there is an ordering requirement between two components, it's better to
make it explicit rather than to change the initcall priorities like that.

At least please add a comment why that needs to be postcore_ so people don't
have to wonder why it is so.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
