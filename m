From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] power: Replace printks with dev_* and pr_* routines
Date: Tue, 19 Nov 2013 10:53:25 -0800
Message-ID: <1384887205.17783.40.camel@joe-AO722>
References: <1384886818-11861-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:41315 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751307Ab3KSSx3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 13:53:29 -0500
In-Reply-To: <1384886818-11861-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Tue, 2013-11-19 at 11:46 -0700, Shuah Khan wrote:
> Replaced printks with dev_* and pr_* routines. Replacing printk in
> __suspend_report_result() will require passing in struct device *
> pointer from calling routines and this will require changes to
> external interface suspend_report_result() which is used by several
> drivers. Hence, this one instance is replaced by pr_err().
[]
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
[]
> @@ -1308,9 +1308,8 @@ int dpm_prepare(pm_message_t state)
>  				error = 0;
>  				continue;
>  			}
> -			printk(KERN_INFO "PM: Device %s not prepared "
> -				"for power transition: code %d\n",
> -				dev_name(dev), error);
> +			dev_info("PM: not prepared for power transition: ",
> +				 "code %d\n", error);

Shuah, you have to make sure the files modified by
your patches compile successfully before sending
patches like this.


