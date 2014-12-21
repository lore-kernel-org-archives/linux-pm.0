From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: cpu_cooling: document node in struct
 cpufreq_cooling_device
Date: Sun, 21 Dec 2014 21:42:36 +0800
Message-ID: <1419169356.22607.6.camel@rzhang1-toshiba>
References: <1418662552-26128-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54729 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675AbaLUNnH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 21 Dec 2014 08:43:07 -0500
In-Reply-To: <1418662552-26128-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Yadwinder Singh Brar <yadi.brar@samsung.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, 2014-12-15 at 16:55 +0000, Javi Merino wrote:
> The node field of struct cpufreq_cooling_device was reintroduced in
> 2dcd851fe4b4 (thermal: cpu_cooling: Update always cpufreq policy with
> thermal constraints) but without the documentation that it once had.
> Add it back so that all the fields of struct cpufreq_cooling_device
> are documented.
> 
> Cc: Yadwinder Singh Brar <yadi.brar@samsung.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/cpu_cooling.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ad09e51ffae4..588185abeab0 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -39,6 +39,7 @@
>   * @cpufreq_val: integer value representing the absolute value of the clipped
>   *	frequency.
>   * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
> + * @node: list_head to link all cpufreq_cooling_device together.
>   *
>   * This structure is required for keeping information of each
>   * cpufreq_cooling_device registered. In order to prevent corruption of this a


