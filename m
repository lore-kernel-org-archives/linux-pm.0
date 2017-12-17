From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [v3 PATCH 2/3] powernv-cpufreq: Fix pstate_to_idx() to handle
 non-continguous pstates
Date: Sun, 17 Dec 2017 14:15:25 +1100
Message-ID: <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com> <1513148261-21097-3-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36097 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757098AbdLQDP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 22:15:27 -0500
In-Reply-To: <1513148261-21097-3-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The code in powernv-cpufreq, makes the following two assumptions which
> are not guaranteed by the device-tree bindings:
>
>     1) Pstate ids are continguous: This is used in pstate_to_idx() to
>        obtain the reverse map from a pstate to it's corresponding
>        entry into the cpufreq frequency table.
>
>     2) Every Pstate should always lie between the max and the min
>        pstates that are explicitly reported in the device tree: This
>        is used to determine whether a pstate reported by the PMSR is
>        out of bounds.
>
> Both these assumptions are unwarranted and can change on future
> platforms.

While this is a good thing, I wonder if it is worth the complexity. Pstates
are contiguous because they define transitions in incremental value
of change in frequency and I can't see how this can be broken in the
future?

Balbir Singh.
