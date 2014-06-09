From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 7/7] cpufreq: intel_pstate: Make intel_pstate_kobject
 local
Date: Mon, 9 Jun 2014 14:07:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406091405540.30620@chino.kir.corp.google.com>
References: <53962096.1060202@semaphore.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:55432 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbaFIVHY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 17:07:24 -0400
Received: by mail-ig0-f172.google.com with SMTP id l13so4347977iga.5
        for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2014 14:07:24 -0700 (PDT)
In-Reply-To: <53962096.1060202@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, 10 Jun 2014, Stratos Karafotis wrote:

> Since we never remove sysfs entry, we can make the intel_pstate_kobject
> local.
> 

For even more savings, this function and 
intel_pstate_debug_expose_params() can be annotated with __init and freed 
after bootstrap.

> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index fa44f0f..9533fff 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -387,10 +387,10 @@ static struct attribute *intel_pstate_attributes[] = {
>  static struct attribute_group intel_pstate_attr_group = {
>  	.attrs = intel_pstate_attributes,
>  };
> -static struct kobject *intel_pstate_kobject;
>  
>  static void intel_pstate_sysfs_expose_params(void)
>  {
> +	struct kobject *intel_pstate_kobject;
>  	int rc;
>  
>  	intel_pstate_kobject = kobject_create_and_add("intel_pstate",
