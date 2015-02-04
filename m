From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Wed, 4 Feb 2015 11:50:22 +0530
Message-ID: <CAKohpomU7LAxCpXrcpzb3DY0yELGrj3vECL9Vyegjgde+-Tdvg@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org>
	<54D14B7B.8040307@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33799 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbBDGUX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 01:20:23 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so14634189obc.6
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 22:20:22 -0800 (PST)
In-Reply-To: <54D14B7B.8040307@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 4 February 2015 at 03:58, Saravana Kannan <skannan@codeaurora.org> wrote:
> Can you explain why we need a fallback list in the first place? Now that we
> are not destroying and creating policy objects, I don't see any point in the
> fallback list.

Because we wanted to mark the policy inactive. But as I have introduced another
field for that now, probably it can be fixed. Will check again on what
can be done.

Can you review the other patches so that they are reviewed once before sending
V2 here ?
