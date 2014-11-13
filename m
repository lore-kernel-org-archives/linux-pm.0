From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap/rapl: fix build dependency on iosf_mbi
Date: Thu, 13 Nov 2014 02:34:06 +0100
Message-ID: <4658675.JHF4IagFMX@vostro.rjw.lan>
References: <1415818236-21741-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53888 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752834AbaKMBNK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 20:13:10 -0500
In-Reply-To: <1415818236-21741-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>

On Wednesday, November 12, 2014 10:50:36 AM Jacob Pan wrote:
> RAPL on Atom depends on IOSF_MBI driver for setting
> floor frequency. This patch adds explicit dependency on
> CONFIG_IOSF_MB.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Applied, thanks!

> ---
>  drivers/powercap/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index a7c81b5..85727ef 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -17,7 +17,7 @@ if POWERCAP
>  # Client driver configurations go here.
>  config INTEL_RAPL
>  	tristate "Intel RAPL Support"
> -	depends on X86
> +	depends on X86 && IOSF_MBI
>  	default n
>  	---help---
>  	  This enables support for the Intel Running Average Power Limit (RAPL)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
