From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 01/14] cpufreq: stats: don't break strings into
 multiple lines
Date: Sun, 4 Jan 2015 08:45:25 +0530
Message-ID: <CAKohpomiaJWmXNjmSrW-D85h8ErZgnLHtFq51z3CH4zogGCctQ@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<70f04ca65a4283afcb21eefa3da88a48de2c2e2e.1420177186.git.viresh.kumar@linaro.org>
	<2484780.nK5uWU02Mz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:43485 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbADDPZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 22:15:25 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so57181072obc.7
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2015 19:15:25 -0800 (PST)
In-Reply-To: <2484780.nK5uWU02Mz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 4 January 2015 at 03:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What about
>
> +MODULE_DESCRIPTION("Export cpufreq stats via sysfs");
>
> This doesn't seem to be substantially less information than the original to me.

Ack.
