From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Set policy to non-NULL only after all
 hotplug online work is done
Date: Wed, 26 Feb 2014 11:44:04 +0530
Message-ID: <CAKohpo=bmYX5iHrV7QixN_uFxB2jGDQYBbW23en0ZgeNesX6Aw@mail.gmail.com>
References: <1789244.B5CzWbcp6h@vostro.rjw.lan>
	<1393385915-19138-3-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60521 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaBZGOG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 01:14:06 -0500
Received: by mail-ob0-f179.google.com with SMTP id wn1so321661obc.38
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2014 22:14:05 -0800 (PST)
In-Reply-To: <1393385915-19138-3-git-send-email-skannan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 26 February 2014 09:08, Saravana Kannan <skannan@codeaurora.org> wrote:
> The existing code sets the per CPU policy to a non-NULL value before all
> the steps performed during the hotplug online path is done. Specifically,
> this is done before the policy min/max, governors, etc are initialized for
> the policy.  This in turn means that calls to cpufreq_cpu_get() return a
> non-NULL policy before the policy/CPU is ready to be used.

First two patches are fine but I would still say that take the three patches
I posted instead of this. Reasoning already given in other mails.
