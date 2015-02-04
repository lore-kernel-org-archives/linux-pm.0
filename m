From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Wed, 04 Feb 2015 14:28:55 -0800
Message-ID: <54D29D27.7080207@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org> <54D14B7B.8040307@codeaurora.org> <CAKohpomU7LAxCpXrcpzb3DY0yELGrj3vECL9Vyegjgde+-Tdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:56175 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbbBDW26 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 17:28:58 -0500
In-Reply-To: <CAKohpomU7LAxCpXrcpzb3DY0yELGrj3vECL9Vyegjgde+-Tdvg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 02/03/2015 10:20 PM, Viresh Kumar wrote:
> On 4 February 2015 at 03:58, Saravana Kannan <skannan@codeaurora.org> wrote:
>> Can you explain why we need a fallback list in the first place? Now that we
>> are not destroying and creating policy objects, I don't see any point in the
>> fallback list.
>
> Because we wanted to mark the policy inactive. But as I have introduced another
> field for that now, probably it can be fixed. Will check again on what
> can be done.

Thanks. That's why I was asking. Now that you have another flag. Also, 
you might not even need a flag. You can just check if policy->cpus is 
empty (btw, I think we should let that go to empty)
>
> Can you review the other patches so that they are reviewed once before sending
> V2 here ?

Definitely. I want this feature to go in.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
