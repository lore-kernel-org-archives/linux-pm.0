From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: add entry for intel_pstate
Date: Wed, 17 Dec 2014 01:31:12 +0100
Message-ID: <3556213.Z0dNFYPAb8@vostro.rjw.lan>
References: <1418687904-16904-1-git-send-email-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64550 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750875AbaLQAJ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 19:09:27 -0500
In-Reply-To: <1418687904-16904-1-git-send-email-kristen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Monday, December 15, 2014 03:58:24 PM Kristen Carlson Accardi wrote:
> Add entry for intel_pstate.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen@linux.intel.com>

Applied, thanks!

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e186bf9..f81f139 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4928,6 +4928,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
>  S:	Supported
>  F:	drivers/idle/intel_idle.c
>  
> +INTEL PSTATE DRIVER
> +M:	Kristen Carlson Accardi <kristen@linux.intel.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Supported
> +F:	drivers/cpufreq/intel_pstate.c
> +
>  INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
>  M:	Maik Broemme <mbroemme@plusserver.de>
>  L:	linux-fbdev@vger.kernel.org
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
