From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 25/32] cpufreq: delete __cpuinit usage from all cpufreq files
Date: Tue, 25 Jun 2013 12:31:43 +0530
Message-ID: <CAKohpokbXbyLpqd=XWy3iEqx-=AA=QEH_GyxOeaKFTw34tuwuQ@mail.gmail.com>
References: <1372102237-8757-1-git-send-email-paul.gortmaker@windriver.com>
	<1372102237-8757-26-git-send-email-paul.gortmaker@windriver.com>
	<CAKohponpsJBqbj_8u8MUiu7sCEpeg5bcztWJAZdn9uxL5taVZQ@mail.gmail.com>
	<1372133724.1245.38.camel@joe-AO722>
	<CAKohpomOyV2zze1QCKArytXD=x7NXSPtsxped_j2ZKJ_aZOi3w@mail.gmail.com>
	<1372143585.1245.44.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:65138 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FYHBo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2013 03:01:44 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so12939913oag.30
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2013 00:01:43 -0700 (PDT)
In-Reply-To: <1372143585.1245.44.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 25 June 2013 12:29, Joe Perches <joe@perches.com> wrote:
> Sure Viresh.
>
> I could agree with that, but that's not what you
> recommended though.  "Check this everywhere" isn't
> the same as the advice you just gave above.

So, I couldn't communicate myself well :(
What I meant is, "check all changes you are making
and be sure you are not repeating this change again".
