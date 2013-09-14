From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Sat, 14 Sep 2013 09:59:57 +0530
Message-ID: <CAKohpokVxksc-BSU87oAWN_uNaZtCXnTJ70RnYVrYMVmeTkLmQ@mail.gmail.com>
References: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org>
	<5197493.kSPF7VUWqc@vostro.rjw.lan>
	<CAKohpom8d89OtJOs-_eCu+RiVA+B0bt7rtgNcJn=D=y95+jdQg@mail.gmail.com>
	<9715082.jFAchu7UKu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:55721 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab3INE35 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Sep 2013 00:29:57 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so1946484oag.36
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 21:29:57 -0700 (PDT)
In-Reply-To: <9715082.jFAchu7UKu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 14 September 2013 05:18, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> OK, I'll think about that, but not today and probably not within the next
> few days, because I'm heading to New Orleans in several hours and really
> have other stuff to take care of now.  Sorry about that.

No issues..
