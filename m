From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: use correct values of cpus in __cpufreq_remove_dev_finish()
Date: Thu, 12 Sep 2013 16:13:03 +0530
Message-ID: <CAKohpokiBoKxCMeD8a6YgMPZn1NXScvB0=5W3sB_OSZhJO2a1g@mail.gmail.com>
References: <cover.1378963070.git.viresh.kumar@linaro.org>
	<52316A40.4050600@linux.vnet.ibm.com>
	<CAKohponzohnOL4Y81Q1W4Yg=paRO46c-gY=HMbkFUqgrjsT+xw@mail.gmail.com>
	<5076102.HGJgP9ualc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:51263 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab3ILKnF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 06:43:05 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so321943obc.24
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2013 03:43:03 -0700 (PDT)
In-Reply-To: <5076102.HGJgP9ualc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12 September 2013 16:17, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Please resend.  And I honestly don't think that [1-3/5] are fixes and
> [4/5] is not needed any more.

Okay, I will resend 5/5.. I didn't get you last two statements clearly :(
- don't think that [1-3/5] are fixes: You meant they are cleanups rather?
Yes, and that's why I asked you to take those on for 3.13 and not for 12..

- [4/5] is not needed any more: 4/5 is already applied by you and it came
from Rafael.. I reinvented the wheel, nothing more. And so it is not required
anymore :)
