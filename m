From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 25/32] cpufreq: delete __cpuinit usage from all cpufreq files
Date: Tue, 25 Jun 2013 12:14:46 +0530
Message-ID: <CAKohpomOyV2zze1QCKArytXD=x7NXSPtsxped_j2ZKJ_aZOi3w@mail.gmail.com>
References: <1372102237-8757-1-git-send-email-paul.gortmaker@windriver.com>
	<1372102237-8757-26-git-send-email-paul.gortmaker@windriver.com>
	<CAKohponpsJBqbj_8u8MUiu7sCEpeg5bcztWJAZdn9uxL5taVZQ@mail.gmail.com>
	<1372133724.1245.38.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:49851 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab3FYGor (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2013 02:44:47 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so11721548obc.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2013 23:44:47 -0700 (PDT)
In-Reply-To: <1372133724.1245.38.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 25 June 2013 09:45, Joe Perches <joe@perches.com> wrote:
> Viresh, there's no absolute "right" way to do this.

Yeah Joe, but I thought its better to keep it consistent within a file.
So, while writing new files, keep what you want but for existing ones
follow what's in there.
