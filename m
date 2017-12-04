From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] PM / runtime: Fix handling of suppliers with disabled
 runtime PM
Date: Mon, 4 Dec 2017 13:51:36 +0200
Message-ID: <c704e4a3-7faf-d2fd-297e-4efcd604bd0f@intel.com>
References: <1532136.s6buYvDjaS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752736AbdLDLv6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Dec 2017 06:51:58 -0500
In-Reply-To: <1532136.s6buYvDjaS@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 01/12/17 15:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Prevent rpm_get_suppliers() from returning an error code if runtime
> PM is disabled for one or more of the supplier devices it wants to
> runtime-resume, so as to make runtime PM work for devices with links
> to suppliers that don't use runtime PM (such links may be created
> during device enumeration even before it is known whether or not
> runtime PM will be enabled for the devices in question, for example).
> 
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/base/power/runtime.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -276,7 +276,8 @@ static int rpm_get_suppliers(struct devi
>  			continue;
>  
>  		retval = pm_runtime_get_sync(link->supplier);
> -		if (retval < 0) {
> +		/* Ignore suppliers with disabled runtime PM. */
> +		if (retval < 0 && retval != -EACCES) {
>  			pm_runtime_put_noidle(link->supplier);
>  			return retval;
>  		}
> 
> 
