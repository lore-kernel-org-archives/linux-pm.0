From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Question] Why is there a restriction on the policy->rwsem &
 CPUFREQ_GOV_POLICY_EXIT ?
Date: Thu, 24 Jul 2014 11:22:54 +0530
Message-ID: <CAKohpo=8EMJ+dQJLS_enY03Dp0Kv6_37hNmEFk2yWqsfQRz6qQ@mail.gmail.com>
References: <1406148339-29065-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:63005 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaGXFwz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 01:52:55 -0400
Received: by mail-oa0-f50.google.com with SMTP id g18so3059311oah.9
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 22:52:55 -0700 (PDT)
In-Reply-To: <1406148339-29065-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 24 July 2014 02:15, Prarit Bhargava <prarit@redhat.com> wrote:
> I'm debugging a race/locking issue in the store_scaling_governor path and
> came across the following restriction on using a semaphore in the
> cpufreq_policy struct defined in include/linux/cpufreq.h :
>
>          * Additional rules:
>          * - Lock should not be held across
>          *     __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
>
>         struct rw_semaphore     rwsem;
>
> I'm not completely familiar with this code and am wondering why the
> restriction is in place?  Is there a worry about the module_put() in
> __cpufreq_governor()?

955ef48 cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT
