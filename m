From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Wed, 26 Feb 2014 10:45:32 +0530
Message-ID: <CAKohpokKJUt4UhC5_dJAhU3LCBwht4pfDWT5Lqo0T1-y_M31=A@mail.gmail.com>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
	<3894986.dK3STNSG71@vostro.rjw.lan>
	<CAKohpom+RUAi0jZBVWUEWZh36O4QgoJcK-YrCq6eDnfMVf+GCg@mail.gmail.com>
	<1456811.7asrQYHEt1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36279 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaBZFPc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 00:15:32 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so272905obc.39
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2014 21:15:32 -0800 (PST)
In-Reply-To: <1456811.7asrQYHEt1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pierre Ossman <pierre-list@ossman.eu>

On 26 February 2014 03:59, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Yes, what exactly do we need it for in the core?

Its probably there to make things faster. We cache the value so that we
don't go to the hardware to read/calculate that again. Isn't it?

And we need to know current freq on many occasions. One of that is that
many drivers need to know the relation between current and new freq before
they can make the change. As they might need to play with volt regulators
before or after the freq change. Also it is used mainly in our loops_per_jiffiy
calculations.
