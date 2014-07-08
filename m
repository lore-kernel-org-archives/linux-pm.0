From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: RFC: Leave sysfs nodes alone during hotplug
Date: Tue, 8 Jul 2014 08:10:28 +0530
Message-ID: <CAKohpokvRnLU+DQBX39odAf5wxuzWjLi=sy5t2fYReoHCfshwQ@mail.gmail.com>
References: <53B5D22F.2070308@codeaurora.org>
	<CAKohpomuPshe4HpvWSzmZ3vvAjV-zHucfHBVbhB6dUBrrYH8pw@mail.gmail.com>
	<53BAF540.9080904@codeaurora.org>
	<CAAW3Ypa690EKmDzwx94CaHeR4j_F6_yFmFrn6xTYuLv=pH7B3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:40817 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaGHCk3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jul 2014 22:40:29 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp18so5748847obc.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2014 19:40:29 -0700 (PDT)
In-Reply-To: <CAAW3Ypa690EKmDzwx94CaHeR4j_F6_yFmFrn6xTYuLv=pH7B3g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ruchi Kandoi <kandoiruchi@google.com>

On 8 July 2014 04:10, Todd Poynor <toddpoynor@google.com> wrote:
> For Android's usage we're also interested in both:
>
> 1. not removing and recreating the cpufreq sysfs files for a CPU on
> hotplug events (we currently use hotplug uevents to reset file
> ownership such that power policy can be controlled by non-root).
>
> 2. not resetting the contents of policy files such as scaling_max_freq
> (also fixed up from uevents) or stats files (we currently keep a
> separate persistent time_in_state for battery accounting purposes).

So, we actually need to retain all the files. I will try to see this
separately. Will add it in my todo list.
