From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/18] cpufreq: don't loose cpufreq history on CPU hotplug
Date: Tue, 27 Jan 2015 20:29:30 +0530
Message-ID: <CAKohponipm65+Gw3jH=ASjq8xmSYjNExTWxtKLcfF75gKoG5dA@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<18969256.kkPtbfLplS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56310 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbbA0O7a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 09:59:30 -0500
Received: by mail-ob0-f169.google.com with SMTP id va8so13840964obc.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 06:59:30 -0800 (PST)
In-Reply-To: <18969256.kkPtbfLplS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 27 January 2015 at 20:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> OK, and this is the last one I'm going to consider for 3.20 (in case you have
> more of them queued up somewhere).

Okay..

>> To make things simple we stop playing with sysfs files unless the driver is
>> getting removed.
>
> And uses will see CPUs that are not present any more?

s/uses/users ?

Actually I have never seen such a situation on the ARM world and so don't
know what exactly happens here. You are probably talking about the NUMA
server space, where a cluster of CPUs can be removed physically from the
NUMA network of CPUs.

What actually happens in that case? Similar to echo 0 > online ?
And do we support it currently?

FWIW, I haven't paid any attention to side of the problem yet, but as soon as
I understand it, I can fix it. Any tips on how can I emulate that on platforms
where we can't take out the CPUs physically ?
