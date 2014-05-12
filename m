From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: make local function static
Date: Mon, 12 May 2014 09:54:08 +0530
Message-ID: <CAKohpo=N3Ze1rLo7H+yGJAKp32Vf3BOLan30uervHhMZ4X0sGQ@mail.gmail.com>
References: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34859 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaELEYJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 00:24:09 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so7524720obc.33
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2014 21:24:08 -0700 (PDT)
In-Reply-To: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11 May 2014 13:21, Brian Norris <computersforpeace@gmail.com> wrote:
> powernv_cpufreq_get() is only referenced in this file.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: cpufreq@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index af4968813e76..bb1d08dc8cc8 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -235,7 +235,7 @@ static void powernv_read_cpu_freq(void *arg)
>   * firmware for CPU 'cpu'. This value is reported through the sysfs
>   * file cpuinfo_cur_freq.
>   */
> -unsigned int powernv_cpufreq_get(unsigned int cpu)
> +static unsigned int powernv_cpufreq_get(unsigned int cpu)

Please make this as static as well: cpufreq_freq_attr_cpuinfo_nominal_freq

and add my

Acked-by: Viresh Kumar <viresh.kumar@linaro.org> on V2.
