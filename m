From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Cpufreq: Change sysfs interface cpuinfo_cur_freq access privilege
Date: Mon, 25 Nov 2013 10:00:42 +0530
Message-ID: <CAKohponvz8CjDpMbx=BXpBv5q8d4x94No90sJWjVsTRS_Uj1jw@mail.gmail.com>
References: <1385348018-30525-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:57863 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab3KYEan (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2013 23:30:43 -0500
Received: by mail-oa0-f49.google.com with SMTP id i4so3772569oah.22
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2013 20:30:43 -0800 (PST)
In-Reply-To: <1385348018-30525-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, hg197@gmx.de, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 25 November 2013 08:23, Lan Tianyu <tianyu.lan@intel.com> wrote:
> Currently, cpuinfo_cur_freq is only accessible for root user while
> other cpufreq sysfs interfaces(E,G scaling_cur_freq) are available
> to ordinary user. This seems make no sense. This patch is to change
> it.

There is nothing wrong with the code and so this is more of a design
change..

Probably Rafael can help us here as cpufreq_cur_freq will read stuff
directly from hardware instead of using cached value in software.

--
viresh
