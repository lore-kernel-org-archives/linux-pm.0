From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Mon, 14 Nov 2016 09:36:22 +0530
Message-ID: <20161114040622.GA29087@vireshk-i7>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0gMDoLrdCqxnyUQqWydqj6Ot0ssf=P9=hOk_bOG9gCi0Q@mail.gmail.com>
 <CAKohponvq3vuzNvaGE7_Pn8vM54AMPZu_E8yRyeytegh-bjuzQ@mail.gmail.com>
 <CAJZ5v0gtmEUriThmYEeaEwoY2DmoDvDZDrzDv=fjRLsXKan+9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34185 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965818AbcKNENd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 23:13:33 -0500
Received: by mail-pf0-f177.google.com with SMTP id c4so14896596pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Nov 2016 20:13:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gtmEUriThmYEeaEwoY2DmoDvDZDrzDv=fjRLsXKan+9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On 13-11-16, 15:46, Rafael J. Wysocki wrote:
> That's only going to happen in the next patch, though, right?  It
> wouldn't hurt to write that in the changelog too.

Sure.

> Besides, I'm not actually sure if starting/stopping the kthread in
> sugov_policy_alloc/free() is a good idea.  It sort of conflates the
> allocation of memory with kthread creation.  Any chance to untangle
> that?

Hmm, so either I can create two new routines for the thread and call
them along with alloc/free. Or I can rename the alloc/free routines
and keep this patch as is.

-- 
viresh
