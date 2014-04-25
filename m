From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq, longhaul: Fix double invocation of cpufreq_freq_transition_begin/end
Date: Fri, 25 Apr 2014 14:07:13 +0530
Message-ID: <CAKohpo=0wppEthZzoRGTqurtt=135NWeVTKJ2y=mwy82+O7-zQ@mail.gmail.com>
References: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com>
	<20140425081804.10258.8324.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52313 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDYIhO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 04:37:14 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so3807589obc.22
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2014 01:37:14 -0700 (PDT)
In-Reply-To: <20140425081804.10258.8324.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Meelis Roos <mroos@linux.ee>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 25 April 2014 13:48, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c

> @@ -269,8 +269,6 @@ static void longhaul_setstate(struct cpufreq_policy *policy,

This routine has this code as well:

mult = mults[mults_index & 0x1f];
if (mult == -1)
        return;
speed = calc_speed(mult);
if ((speed > highest_speed) || (speed < lowest_speed))
        return;

And so it might return without changing frequency and that's why I
left this driver earlier for this change.. So, please return -EINVAL
from here..
