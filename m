From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Thu, 24 Jul 2014 10:34:58 +0530
Message-ID: <CAKohpokynnTttD7Wbq8uBB4SXK9xFEBdRJ2ozhMQscyvq69xRw@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
	<16164926.ZsJxe6UV3e@vostro.rjw.lan>
	<53D07737.70904@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:41972 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934044AbaGXFE7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 01:04:59 -0400
Received: by mail-oi0-f48.google.com with SMTP id h136so1635400oig.7
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 22:04:59 -0700 (PDT)
In-Reply-To: <53D07737.70904@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24 July 2014 08:32, Saravana Kannan <skannan@codeaurora.org> wrote:
> Ok, I think I've figured this out. But one question. Is it possible to
> physically remove one CPU in a bunch of "related cpus" without also
> unplugging the rest? Put another way, can you unplug one core from a
> cluster?

Are we talking about doing this here:

echo 0 > /sys/devices/system/cpu/cpuX/online      ??

If yes, then what's the confusion all about? Yes we do it all the time.
