From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/18] cpufreq: Create for_each_policy()
Date: Wed, 4 Feb 2015 10:23:35 +0530
Message-ID: <CAKohpo=cFThiq+oRZt8i2LTjvnHCKgRwf_n_XTOqmNxUi=2b2Q@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<c2b93a536c452b13a09434c3dfaf9725ee8ff95a.1422346933.git.viresh.kumar@linaro.org>
	<54D14A21.3010007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:49310 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbBDExf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 23:53:35 -0500
Received: by mail-oi0-f49.google.com with SMTP id a3so52496318oib.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 20:53:35 -0800 (PST)
In-Reply-To: <54D14A21.3010007@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 4 February 2015 at 03:52, Saravana Kannan <skannan@codeaurora.org> wrote:
> Could you "export" this macro/list so that it's usable by other clients of
> cpufreq too? If a driver wants to examine all the policies today, it has to
> do "for_each_cpu" and then try to get the policy for each CPU. This seems
> nicer.

I would wait for such requests to come, it wouldn't be difficult to move these
to cpufreq.h .. Do you have some users in mind ?

Also, exposing the cpufreq-locks wouldn't be a good idea and accessing these
macro's without them might result in crash, in case there are updates at the
same time..

So, its a bit tricky I would say.
