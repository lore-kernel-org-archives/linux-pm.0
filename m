From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 189/228] cpufreq: dbx500: remove calls to cpufreq_notify_transition()
Date: Fri, 20 Sep 2013 20:56:34 +0200
Message-ID: <CACRpkdY9wwEJ-kjPZyh1gtrmULy3tyKuU_3s-3CZmP0YWz87wA@mail.gmail.com>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
	<6fbcd6c0c6799d62f379b7c02ef08a93714b75a9.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:63462 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab3ITS4f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2013 14:56:35 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so1067858obc.10
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2013 11:56:35 -0700 (PDT)
In-Reply-To: <6fbcd6c0c6799d62f379b7c02ef08a93714b75a9.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 13, 2013 at 3:02 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Most of the drivers do following in their ->target_index() routines:
>
>         struct cpufreq_freqs freqs;
>         freqs.old = old freq...
>         freqs.new = new freq...
>
>         cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>
>         /* Change rate here */
>
>         cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
>
> This is replicated over all cpufreq drivers today and there doesn't exists a
> good enough reason why this shouldn't be moved to cpufreq core instead.
>
> Earlier patches have added support in cpufreq core to do cpufreq notification on
> frequency change, this one removes it from this driver.
>
> Some related minor cleanups are also done along with it.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
