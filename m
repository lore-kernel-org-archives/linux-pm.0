From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] selftest: cpufreq: Update MAINTAINERS file
Date: Mon, 6 Feb 2017 16:08:52 +0530
Message-ID: <20170206103852.GJ3131@vireshk-i7>
References: <c3cd3310-7a12-134e-3c5a-c5fcacc6821d@kernel.org>
 <ce0bdaab50468d22a46cce3cb04efbb21f467cb6.1484890757.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34894 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdBFKi4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 05:38:56 -0500
Received: by mail-pg0-f52.google.com with SMTP id 194so27706256pgd.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 02:38:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ce0bdaab50468d22a46cce3cb04efbb21f467cb6.1484890757.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, shuah@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org

On 20-01-17, 11:10, Viresh Kumar wrote:
> Update MAINTAINERS file with cpufreq's selftest directory.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi shuah,
> 
> Can you please add this one as well along with the code? Thanks.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c36976d3bd1a..bf414a1a5f82 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3381,6 +3381,7 @@ B:	https://bugzilla.kernel.org
>  F:	Documentation/cpu-freq/
>  F:	drivers/cpufreq/
>  F:	include/linux/cpufreq.h
> +F:	tools/testing/selftests/cpufreq/
>  
>  CPU FREQUENCY DRIVERS - ARM BIG LITTLE
>  M:	Viresh Kumar <viresh.kumar@linaro.org>

@Shuah; Can you please add this as well?

-- 
viresh
