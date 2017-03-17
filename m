From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Fri, 17 Mar 2017 18:40:29 +0100
Message-ID: <CAJZ5v0h1C6o72boe_DJRS_U3xebaU6h=kzL8biNjGUoA1S8B8w@mail.gmail.com>
References: <2084010.4xkKok06Gp@aspire.rjw.lan> <20170317032016.GC31040@vireshk-i7>
 <CAJZ5v0jNp9t8uu0S4yRjT-TLHOcrAeMmjFzU6eBaaCp+C4j5Wg@mail.gmail.com> <CAKohponGNdnd0Q8rEhMAa=M8EiUiEE6H0nkJYFCFCu+Ow3zw2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34778 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdCQRkb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 13:40:31 -0400
In-Reply-To: <CAKohponGNdnd0Q8rEhMAa=M8EiUiEE6H0nkJYFCFCu+Ow3zw2Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Fri, Mar 17, 2017 at 5:43 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17 March 2017 at 22:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> IMO if we are not going to restore the governor, we also should not
>> restore the limits as those things are related.  Now, the governor can
>> be unloaded while the CPU is offline.
>
> I thought about it earlier but then governor and policy min/max
> looked independent to me. Why do you think they are related?

They are parts of one set of settings.

If the governor is not restored, the policy starts with the default
one, so why would it not start with the default limits then?

My opinion is that either we restore everything the way it was, or we
start afresh entirely.

Thanks,
Rafael
