From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/2] cpufreq: cpufreq-dt: Improvements for set_target()
Date: Mon, 20 Oct 2014 10:13:49 +0530
Message-ID: <CAKohpokjczrGvZ6e7JOwkPtq1-MC0Cr_s+bp=wwKt4x+FdumWQ@mail.gmail.com>
References: <1413583789-24294-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:38589 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbaJTEnt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 00:43:49 -0400
Received: by mail-oi0-f42.google.com with SMTP id a141so3131666oig.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2014 21:43:49 -0700 (PDT)
In-Reply-To: <1413583789-24294-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 October 2014 03:39, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch series contains 2 improvements for set_target().
>
> changes in V2:
>   - rebase because of name change cpufreq-cpu0 to cpufreq-dt
>
> Stefan Wahren (2):
>   cpufreq: cpufreq-dt: Improve debug about matching OPP
>   cpufreq: cpufreq-dt: Handle regulator_get_voltage() failure
>
>  drivers/cpufreq/cpufreq-dt.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
