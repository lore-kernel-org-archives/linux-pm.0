From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/18] cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
Date: Thu, 12 Feb 2015 15:52:43 +0800
Message-ID: <CAKohpokKamYSDX9bcOJSxVTiXmWhywXNco0qTAupcpW2mnS=FA@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<7b7de04921e8e2e57fbe2c8e75898c9d9284a269.1422346933.git.viresh.kumar@linaro.org>
	<54DC1BB5.2020107@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46085 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbBLHwn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 02:52:43 -0500
Received: by mail-ob0-f174.google.com with SMTP id wo20so8268897obc.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 23:52:43 -0800 (PST)
In-Reply-To: <54DC1BB5.2020107@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 12 February 2015 at 11:19, Saravana Kannan <skannan@codeaurora.org> wrote:
> I'm not sure we need to or should refer to kobject count (maybe just
> reference count instead?) and cpufreq_rwsem in the documentation. Those are
> implementation specific details and IMHO, shouldn't be in the documentation.
> I think it would be better to just explain the impact (which you already do)
> -- policy will never be freed and it will also prevent the cpufreq driver
> from getting unregistered.
>
> Just my 2 cents.

I wanted to be damn explicit here so that people understand what's going
on. Few days back I had some real hard time to explain this concept to
an kernel engineer and many more may follow.
