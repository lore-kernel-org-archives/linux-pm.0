From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Fri, 17 Mar 2017 22:13:13 +0530
Message-ID: <CAKohponGNdnd0Q8rEhMAa=M8EiUiEE6H0nkJYFCFCu+Ow3zw2Q@mail.gmail.com>
References: <2084010.4xkKok06Gp@aspire.rjw.lan> <20170317032016.GC31040@vireshk-i7>
 <CAJZ5v0jNp9t8uu0S4yRjT-TLHOcrAeMmjFzU6eBaaCp+C4j5Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37679 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCQQxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 12:53:03 -0400
Received: by mail-it0-f41.google.com with SMTP id g138so33338627itb.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2017 09:53:02 -0700 (PDT)
In-Reply-To: <CAJZ5v0jNp9t8uu0S4yRjT-TLHOcrAeMmjFzU6eBaaCp+C4j5Wg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 17 March 2017 at 22:01, Rafael J. Wysocki <rafael@kernel.org> wrote:

> IMO if we are not going to restore the governor, we also should not
> restore the limits as those things are related.  Now, the governor can
> be unloaded while the CPU is offline.

I thought about it earlier but then governor and policy min/max
looked independent to me. Why do you think they are related?
