From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: arm_big_little: reconfigure switcher
 behavior at run time
Date: Wed, 23 Oct 2013 10:19:06 +0530
Message-ID: <CAKohpo=-nxsqJuo7RTf8q-P5caTSuNqFWjX6ncf+GmQvL1-Q9g@mail.gmail.com>
References: <1382500691-634-1-git-send-email-nicolas.pitre@linaro.org>
	<1382500691-634-3-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:55037 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab3JWEtH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2013 00:49:07 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so301689oag.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2013 21:49:07 -0700 (PDT)
In-Reply-To: <1382500691-634-3-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Dave P Martin <dave.martin@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>

On 23 October 2013 09:28, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The b.L switcher can be turned on/off at run time.  It is therefore
> necessary to change the cpufreq driver behavior accordingly.
>
> The driver must be unregistered/registered with the cpufreq core
> to reconfigure freq tables for the virtual or actual CPUs. This is
> accomplished via the b.L switcher notifier callback.
>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Got really confused on what should I reply with,
Ack/Tested/Reviewed/Signed-off :)

Because we have worked closely on these patches, maybe
this suits best :)

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
