From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: send notifications for intermediate (stable) frequencies
Date: Fri, 16 May 2014 11:34:36 +0530
Message-ID: <CAKohponZhkxyaWcbaFzd0K1UtW3ytwjRT3+vKtbYLMwds01y4g@mail.gmail.com>
References: <25738681139c04272b6d2ebeff244c6d36c893f7.1400133090.git.viresh.kumar@linaro.org>
	<537512E0.7000102@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:39524 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbaEPGEh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 02:04:37 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so2500297oag.1
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2014 23:04:36 -0700 (PDT)
In-Reply-To: <537512E0.7000102@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 16 May 2014 00:47, Stephen Warren <swarren@wwwdotorg.org> wrote:
> This seems rather complex. Can't either the driver or the cpufreq core
> be responsible for all of the notifications? Otherwise, the logic gets
> rather complex, and spread between the core and the driver.

I do agree about that and that's why added that 'ugly' statement.

> Perhaps the core should make separate calls into the driver to switch to
> the temporary frequency and the final frequency, so it can manage all
> the notifications. Probably best to use a separate function pointer for
> the temporary change so the driver can easily know what it's doing.

Hmm, that sounds like a much better approach. Let me try to code it.
