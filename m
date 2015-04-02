From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/20] cpufreq: Call schedule_work() for the last
 active policy
Date: Thu, 2 Apr 2015 10:32:54 +0530
Message-ID: <CAKohpo=+xD4vxhB=CrNGMCgVMz-P-745qfieTvJP7YHi6f+xNg@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<d9273b6f27de39f077b97f2929b47aa885220933.1424345053.git.viresh.kumar@linaro.org>
	<551CBA45.6080702@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:32810 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbDBFCz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 01:02:55 -0400
Received: by obvd1 with SMTP id d1so113213477obv.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 22:02:54 -0700 (PDT)
In-Reply-To: <551CBA45.6080702@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 2 April 2015 at 09:10, Saravana Kannan <skannan@codeaurora.org> wrote:
> Ok, I don't think this will work after the next patch/end of the series.

Sigh, Its broken today as well. See my another patch:

[PATCH] cpufreq: Schedule work for the first-online CPU on resume

This patch is dropped now.
