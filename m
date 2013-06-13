From: Xiaoguang Chen <chenxg.marvell@gmail.com>
Subject: Re: [PATCH v4] cpufreq: fix governor start/stop race condition
Date: Thu, 13 Jun 2013 13:40:16 +0800
Message-ID: <CAFgnuDeeU5qALyqN4Akpi5SoHRXPWaq_PLYSSmjxkq9V5N=qag@mail.gmail.com>
References: <1371028189-15758-1-git-send-email-chenxg@marvell.com>
	<CAKohponeWuaXPah4s9GjO-fLwQNuyKidUFosN1iE+e7bngDPdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:51971 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab3FMFkS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2013 01:40:18 -0400
In-Reply-To: <CAKohponeWuaXPah4s9GjO-fLwQNuyKidUFosN1iE+e7bngDPdQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com

2013/6/12 Viresh Kumar <viresh.kumar@linaro.org>:
> On 12 June 2013 14:39, Xiaoguang Chen <chenxg@marvell.com> wrote:
>
>>         ret = policy->governor->governor(policy, event);
>
> We again reached to the same problem. We shouldn't call
> this between taking locks, otherwise recursive locks problems
> would be seen again.

But this is not the same lock as the deadlock case, it is a new lock,
and only used in this function. no other functions use this lock.
I don't know how can we get dead lock again?

Thanks
Xiaoguang
