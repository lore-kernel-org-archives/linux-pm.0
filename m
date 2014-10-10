From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 17:16:44 +0530
Message-ID: <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<5437C12D.1070803@redhat.com>
	<CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	<5437C535.3070707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:38034 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaJJLqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 07:46:45 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so6214640oig.33
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 04:46:44 -0700 (PDT)
In-Reply-To: <5437C535.3070707@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 17:08, Prarit Bhargava <prarit@redhat.com> wrote:
> Yes, I unfortunately have a different set of issues with vanilla 3.17
> (previously mentioned locking issue).  I've done a quick and dirty hack to get
> around that, and everything seems okay.
>
> I apply your patches and I get a panic the first time I read sysfs

All changes in my patches are touching these routines:
- cpufreq_set_policy()
- __cpufreq_governor()

And these two doesn't get called in the read path at all. And so I am not sure
how can these make things bad for you.

I had doubt on just one change, can you please check the v2 branch once to
see if that gives the same problem ?
