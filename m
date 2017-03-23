From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Fri, 24 Mar 2017 00:30:34 +0100
Message-ID: <CAJZ5v0j956ttMf3Oaek2=xSKFeqKnhO=1+RN3+81H5E1rXY4UA@mail.gmail.com>
References: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34532 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdCWXag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 19:30:36 -0400
Received: by mail-ot0-f194.google.com with SMTP id y88so7527109ota.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 16:30:35 -0700 (PDT)
In-Reply-To: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On Thu, Mar 23, 2017 at 10:24 PM, Prashanth Prakash
<pprakash@codeaurora.org> wrote:
> Adds an additional code path within cpufreq_online to create sysfs
> symlinks for cpus that are bought onilne for the first time after
> completion of boot.
>
> With maxcpus=N kernel parameter, it is possible to bring additional
> cpus online after boot. In these cases per-cpu "cpufreq" symlinks
> are not being created during registration as policy may not exist
> for the cpus that were offline during boot.
>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>

This looks way overly complicated to me.  Let me look at it in the
next couple of days.

Thanks,
Rafael
