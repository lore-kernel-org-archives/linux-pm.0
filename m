From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: userspace: Simplify governor
Date: Tue, 18 Jun 2013 10:20:33 +0530
Message-ID: <CAKohpokwbLyCiL88i+6hKaLiKciZ0mZhOqenSzOJ7oBfgsCpZg@mail.gmail.com>
References: <68ae523282b494da0e8f67536af1df874c326675.1370422554.git.viresh.kumar@linaro.org>
	<1855098.3p2j9hWHoD@vostro.rjw.lan>
	<CAKohpon3Tc+dSycv-QeLg9vwjXijaZrtjzw0-tHVAqX6moBUjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:65265 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab3FREud (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2013 00:50:33 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so4070228obc.27
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2013 21:50:33 -0700 (PDT)
In-Reply-To: <CAKohpon3Tc+dSycv-QeLg9vwjXijaZrtjzw0-tHVAqX6moBUjA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, chenxg.marvell@gmail.com

On 5 June 2013 18:38, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> To be honest with the amount of experience I have now, my log was
> poor :(
>
> I have used following log in the attached patch:
>
> Subject: [PATCH] cpufreq: userspace: Simplify governor
>
> Userspace governor has got more code than what it needs for its functioning.
> Lets simplify it. Portions of code removed are:
> - Extra header files which aren't required anymore (rearranged them as well)
> - cpu_{max|min|cur|set}_freq, as they are always same as policy->{max|min|cur}
> - userspace_cpufreq_notifier_block as we don't need to set cpu_cur_freq anymore
> - cpus_using_userspace_governor as it was for notifier code
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Are you happy with the log & description of this patch now?
