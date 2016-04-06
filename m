From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap: intel_rapl: Add missing Haswell model
Date: Thu, 07 Apr 2016 01:33:55 +0200
Message-ID: <6354894.dC7obx9e80@vostro.rjw.lan>
References: <1458993818-19387-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59480 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754184AbcDFXbY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 19:31:24 -0400
In-Reply-To: <1458993818-19387-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, March 26, 2016 05:03:38 AM Srinivas Pandruvada wrote:
> Added missing model 0x46.
> 
> Tested-and-reported-by: Piotr Maksymiuk <piotr.maksymiuk@movishell.pl>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 2c0235d..769a803 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1105,6 +1105,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>  	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
>  	RAPL_CPU(0x4f, rapl_defaults_hsw_server),/* Broadwell servers */
>  	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
> +	RAPL_CPU(0x46, rapl_defaults_core),/* Haswell */
>  	RAPL_CPU(0x47, rapl_defaults_core),/* Broadwell-H */
>  	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
>  	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview */
> 

Applied, thanks!

