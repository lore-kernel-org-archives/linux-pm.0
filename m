From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/54] MAINTAINERS: Add file patterns for cpufreq device
 tree bindings
Date: Mon, 23 May 2016 08:02:27 +0530
Message-ID: <20160523023227.GD2850@vireshk-i7>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-13-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34715 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbcEWCcb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 May 2016 22:32:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id y69so59540009pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 22 May 2016 19:32:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1463907991-7916-13-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 22-05-16, 11:05, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c9f31233670e9dd..b241c14d9ab57e2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3213,6 +3213,7 @@ L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>  T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
> +F:	Documentation/devicetree/bindings/cpufreq/
>  F:	drivers/cpufreq/
>  F:	include/linux/cpufreq.h

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
