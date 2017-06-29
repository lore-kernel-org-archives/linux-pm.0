From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] cpufreq: transition-latency cleanups
Date: Thu, 29 Jun 2017 22:36:02 +0200
Message-ID: <CAJZ5v0gkOqb5swVCdxfC8uZu-vMDHkejEa1M3uQqJ=o0VmGOew@mail.gmail.com>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37573 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbdF2UgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 16:36:03 -0400
Received: by mail-it0-f48.google.com with SMTP id m84so14121270ita.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 13:36:03 -0700 (PDT)
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

Hi,

On Thu, Jun 29, 2017 at 12:59 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> This series tries to cleanup the code around transition-latency and its
> users. Some of the old legacy code, which may not make much sense now,
> is being dropped as.
>
> Some code consolidation also happens across governors.

Please mark RFC patches as RFC.

This is not going to be considered for 4.13, so the timing is not the
best one I could think about.

Thanks,
Rafael
