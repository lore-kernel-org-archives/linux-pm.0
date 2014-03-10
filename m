From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Mon, 10 Mar 2014 13:37:45 +0800
Message-ID: <CAKohponVBFaZY2tE8kJ91Gtj9MdvFKzGgWPNWxi38Kg8q9YUug@mail.gmail.com>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
	<3894986.dK3STNSG71@vostro.rjw.lan>
	<CAKohpom+RUAi0jZBVWUEWZh36O4QgoJcK-YrCq6eDnfMVf+GCg@mail.gmail.com>
	<1456811.7asrQYHEt1@vostro.rjw.lan>
	<CAKohpokKJUt4UhC5_dJAhU3LCBwht4pfDWT5Lqo0T1-y_M31=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:38815 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaCJFhp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Mar 2014 01:37:45 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so6591036oah.29
        for <linux-pm@vger.kernel.org>; Sun, 09 Mar 2014 22:37:45 -0700 (PDT)
In-Reply-To: <CAKohpokKJUt4UhC5_dJAhU3LCBwht4pfDWT5Lqo0T1-y_M31=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pierre Ossman <pierre-list@ossman.eu>

On 26 February 2014 13:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26 February 2014 03:59, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> Yes, what exactly do we need it for in the core?
>
> Its probably there to make things faster. We cache the value so that we
> don't go to the hardware to read/calculate that again. Isn't it?
>
> And we need to know current freq on many occasions. One of that is that
> many drivers need to know the relation between current and new freq before
> they can make the change. As they might need to play with volt regulators
> before or after the freq change. Also it is used mainly in our loops_per_jiffiy
> calculations.

Ping!!
