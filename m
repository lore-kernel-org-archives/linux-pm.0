From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Simplify __cpufreq_remove_dev()
Date: Thu, 10 Jan 2013 13:29:57 +0530
Message-ID: <CAKohpokJRPd2uHLuQDqJnbXwFJDn8sFOu1yRem8m2HuHTu9CyQ@mail.gmail.com>
References: <aa10abe640afed8700abf262dbfc9b9c22659b6a.1357729671.git.viresh.kumar@linaro.org>
	<20130110075422.GA11458@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:57672 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613Ab3AJH76 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 02:59:58 -0500
Received: by mail-oa0-f47.google.com with SMTP id h1so272539oag.34
        for <linux-pm@vger.kernel.org>; Wed, 09 Jan 2013 23:59:57 -0800 (PST)
In-Reply-To: <20130110075422.GA11458@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rjw@sisk.pl, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, linaro-dev@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10 January 2013 13:24, Shawn Guo <shawn.guo@linaro.org> wrote:
> Yes, just played it and it works for me.  However, I would have to keep
> that little ugly code in my patch to save the dependency on your patch.
> Will send a follow-up to clean that up once your patch hits mainline.

Good. Hopefully, patches from both of us would hit 3.9 and Rafael can
apply yours after mine, with this check removed :)

--
viresh
