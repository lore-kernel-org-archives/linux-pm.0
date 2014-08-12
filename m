From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/5] cpufreq: Don't wait for CPU to going offline to
 restart governor
Date: Tue, 12 Aug 2014 10:10:20 +0530
Message-ID: <CAKohpo=vFd7BN07DfasZGBQWPAjFyKRAQsQTOtjLQ4QebzMzGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:65279 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaHLEkV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Aug 2014 00:40:21 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so6714346obc.7
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2014 21:40:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 12 August 2014 03:41, Saravana Kannan <skannan@codeaurora.org> wrote:

> Suggestions welcome. I think the current one explains the main point of this change.

Atleast we need a s/going/go

>> There is a down_read() present early in this routine and we better update this
>> at that place only.
>
>
> I would rather not. My v1 patch series was super refactored to allow a lot of reuse, etc. But you guys complained about the diffs being confusing (which was a valid point).
>
> Also, if we are talking about refactoring this, there's room for much better refactor at the end of the series. I will add a patch to the series to do the refactoring.

The kind of change I am suggesting you can be done in the original
patch only. What we told you in the earlier reviews was to break patches
into meaningful sections instead of doing everything in a single patch.

> That only runs if cpu != policy->cpu. This needs to run irrespective of that.

Oh yes, correct.

> You mean the log in the cover letter? Will do.

Coverletter isn't the right place for mentioning such important things
as it never gets commited. I was talking about the commit log.
