From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/4] CPUFreq: Implement per policy instances of governors
Date: Fri, 22 Feb 2013 08:16:54 +0530
Message-ID: <CAKohpokNPzTDOxMTbURugW8AX7AwxwgTTVfJkDNripEaSoQ=Sw@mail.gmail.com>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34902 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab3BVCqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 21:46:55 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so188628oag.32
        for <linux-pm@vger.kernel.org>; Thu, 21 Feb 2013 18:46:54 -0800 (PST)
In-Reply-To: <cover.1360568193.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com, Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@suse.de>

On 11 February 2013 13:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This is targetted for 3.10-rc1 or linux-next just after the merge window.

Hi Rafael,

I have pushed this patch again with the modifications/fixups i posted:
cpufreq-for-3.10

Also i have swapped patch 3 & 4, in case you decide to drop that Kconfig
patch which is no. 4 now :)

--
viresh
