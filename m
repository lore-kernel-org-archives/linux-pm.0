From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 19/21] cpuidle: create list of registered drivers
Date: Thu, 26 Sep 2013 11:47:05 +0530
Message-ID: <CAKohpo=3qFQ+gD+3u__NtZEL4xu51FBN+og+_UE7aTR26XvRng@mail.gmail.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
	<7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org>
	<5243641B.6050604@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:53621 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3IZGRG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 02:17:06 -0400
Received: by mail-qc0-f182.google.com with SMTP id n4so475680qcx.27
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 23:17:06 -0700 (PDT)
In-Reply-To: <5243641B.6050604@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26 September 2013 04:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> If you introduce a list, you will have to introduce a lock to protect
> it.

I missed it, should have added that :)

> This lock will be in the fast path cpuidle_idle_call with the
> get_driver function and conforming to the comment: "NOTE: no locks or
> semaphores should be used here".
>
> A lock has been introduced in this function already and the system hangs
> with 1024 cpus.

Hmm... I see.. I didn't knew about this expectation.. What about a rcu
read/write lock? As far as I know its too lightweight... Can we have that
in fast path?
