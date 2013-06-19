From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/13] cpufreq: dbx500: call CPUFREQ_POSTCHANGE notfier in
 error cases
Date: Wed, 19 Jun 2013 21:42:16 +0200
Message-ID: <CACRpkdayiaUGqamTZcO5a6TRTjFwex+jHbok398seDEzocSXYA@mail.gmail.com>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
	<f88ce5f93929a780ff63df1fc73c03a0703b2af0.1371630975.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36344 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798Ab3FSTmR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 15:42:17 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so6294435obb.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 12:42:16 -0700 (PDT)
In-Reply-To: <f88ce5f93929a780ff63df1fc73c03a0703b2af0.1371630975.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rickard ANDERSSON <rickard.andersson@stericsson.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve.Bannister@arm.com, Liviu Dudau <Liviu.Dudau@arm.com>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, dave.martin@arm.com

On Wed, Jun 19, 2013 at 10:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> PRECHANGE and POSTCHANGE notifiers must be called in groups, i.e either both
> should be called or both shouldn't be.
>
> In case we have started PRECHANGE notifier and found an error, we must call
> POSTCHANGE notifier with freqs.new = freqs.old to guarantee that sequence of
> calling notifiers is complete.
>
> This patch fixes it.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
