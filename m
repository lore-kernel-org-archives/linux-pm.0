From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] cpufreq: stats: Add 'load_table' debugfs file to show
 accumulated data of CPUs
Date: Fri, 28 Jun 2013 13:57:41 +0530
Message-ID: <CAKohpomk7tC4xZ32sOh4NQR-qNOM=xHj43GcMu_squ1nFELGpg@mail.gmail.com>
References: <1372405697-13556-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63263 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab3F1I1m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2013 04:27:42 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so1711383obb.14
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2013 01:27:41 -0700 (PDT)
In-Reply-To: <1372405697-13556-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

On 28 June 2013 13:18, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>  drivers/cpufreq/Kconfig            |   6 +
>  drivers/cpufreq/cpufreq.c          |   4 +
>  drivers/cpufreq/cpufreq_governor.c |  15 +++
>  drivers/cpufreq/cpufreq_stats.c    | 241 +++++++++++++++++++++++++++++++++----
>  include/linux/cpufreq.h            |   6 +
>  5 files changed, 246 insertions(+), 26 deletions(-)

Please update Documentation/cpu-freq/cpufreq-stats.txt for this as well.
