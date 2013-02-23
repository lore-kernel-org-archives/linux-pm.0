From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/2] cpufreq: Convert the cpufreq_driver_lock to a rwlock
Date: Sat, 23 Feb 2013 09:27:50 +0530
Message-ID: <CAKohpo=unSqEUMgqYNS8qmqM3n2qKbx5x0r9_hF9gLrZ58zqqg@mail.gmail.com>
References: <51265E0F.6090209@sgi.com>
	<1361550275-5716-1-git-send-email-nzimmer@sgi.com>
	<1361550275-5716-2-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:52800 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab3BWD5u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Feb 2013 22:57:50 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so1157945obb.39
        for <linux-pm@vger.kernel.org>; Fri, 22 Feb 2013 19:57:50 -0800 (PST)
In-Reply-To: <1361550275-5716-2-git-send-email-nzimmer@sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 22 February 2013 21:54, Nathan Zimmer <nzimmer@sgi.com> wrote:
> This eliminates the contention I am seeing in __cpufreq_cpu_get.
> It also nicely stages the lock to be replaced by the rcu.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: I am too bored of seeing this patch again and again :)
Can we get this applied alone for now?
