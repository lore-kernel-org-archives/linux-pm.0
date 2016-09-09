From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add Documentation/cpu-freq/
Date: Fri, 9 Sep 2016 16:36:03 +0530
Message-ID: <20160909110603.GD18547@vireshk-i7>
References: <20160909130524.581de63d@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35625 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753967AbcIILGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 07:06:07 -0400
Received: by mail-pf0-f182.google.com with SMTP id w87so28586657pfk.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 04:06:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160909130524.581de63d@endymion>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 09-09-16, 13:05, Jean Delvare wrote:
> I am told the cpufreq documentation updates should go to the PM list.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reported-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-4.8-rc5.orig/MAINTAINERS	2016-09-09 13:00:13.928338065 +0200
> +++ linux-4.8-rc5/MAINTAINERS	2016-09-09 13:00:51.102740802 +0200
> @@ -3281,6 +3281,7 @@ L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>  T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
> +F:	Documentation/cpu-freq/
>  F:	drivers/cpufreq/
>  F:	include/linux/cpufreq.h

Oh, I missed that :(

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
