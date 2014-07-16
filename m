From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Wed, 16 Jul 2014 20:58:15 +0530
Message-ID: <CAKohpokLzMbzr4kdL6wCL7MZgnVe0CQhbJHKL5wWeETH1YwEOg@mail.gmail.com>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
	<1405464473-3916-2-git-send-email-skannan@codeaurora.org>
	<53C68C54.3010900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36477 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965403AbaGPP2Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 11:28:16 -0400
Received: by mail-ob0-f169.google.com with SMTP id nu7so1095949obb.14
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 08:28:15 -0700 (PDT)
In-Reply-To: <53C68C54.3010900@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 16 July 2014 19:59, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> stop_cpu() only needs to be called during __cpufreq_remove_dev_prepare() no
> where else.

Oh, thanks for reminding us..

Look at this Saravana:
367dc4a cpufreq: Add stop CPU callback to cpufreq_driver interface
