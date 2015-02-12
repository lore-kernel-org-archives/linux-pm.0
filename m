From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 09/18] cpufreq: Mark policy->governor = NULL for fallback policies
Date: Thu, 12 Feb 2015 15:56:19 +0800
Message-ID: <CAKohpon-jqD-FC-KGQ_kTNew70fu84Km4fuicHbaMp_T9DW_LA@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<ee81ef766064a79a5332f390d39dc3e4cca5fca5.1422346933.git.viresh.kumar@linaro.org>
	<54DC1C62.40303@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:44911 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbBLH4T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 02:56:19 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so8401201obc.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 23:56:19 -0800 (PST)
In-Reply-To: <54DC1C62.40303@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 12 February 2015 at 11:22, Saravana Kannan <skannan@codeaurora.org> wrote:
> I don't see anything wrong with scaling_governor showing the last used
> governor when the CPUs are just logically hotplug removed. In the physical

But the governor is *not* used currently by the CPUs and marking it used is
completely wrong.

> hotplug case, the whole directory would go away and the policy would be
> freed. So, this is not a concern there.

Its not relevant here.

> Also, longer term (after your series goes in), I think we actually should
> NOT send POLICY_EXIT on just logical hotplug. That way, the governor
> tunables are not lost across a logical hotplug.

I am not sure about it. For example, after all CPUs of a policy are gone,
the governor is free to be get removed. And so the user should be free
to do rmmod on it.
