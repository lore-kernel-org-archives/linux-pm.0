From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Wed, 04 Feb 2015 17:55:02 -0800
Message-ID: <54D2CD76.2030609@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <CAKohpomU7LAxCpXrcpzb3DY0yELGrj3vECL9Vyegjgde+-Tdvg@mail.gmail.com> <54D29D27.7080207@codeaurora.org> <6147604.f4mimnOd4x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:36897 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbBEBzG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 20:55:06 -0500
In-Reply-To: <6147604.f4mimnOd4x@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 02/04/2015 03:20 PM, Rafael J. Wysocki wrote:
> On Wednesday, February 04, 2015 02:28:55 PM Saravana Kannan wrote:
>> On 02/03/2015 10:20 PM, Viresh Kumar wrote:
>>> On 4 February 2015 at 03:58, Saravana Kannan <skannan@codeaurora.org> wrote:
>>>> Can you explain why we need a fallback list in the first place? Now that we
>>>> are not destroying and creating policy objects, I don't see any point in the
>>>> fallback list.
>>>
>>> Because we wanted to mark the policy inactive. But as I have introduced another
>>> field for that now, probably it can be fixed. Will check again on what
>>> can be done.
>>
>> Thanks. That's why I was asking. Now that you have another flag. Also,
>> you might not even need a flag. You can just check if policy->cpus is
>> empty (btw, I think we should let that go to empty)
>
> So the idea would be to avoid clearig cpufreq_cpu_data during offline
> tear-down (because we know that the CPU is offline anyway) and then start
> using the same policy pointer during offline?

Yeah. We still don't clear the policy->cpus today when the last CPU goes 
down. But that can be done easily by changing a few "if" conditions and 
rearranging the hotplug notifier code (I think it's mostly there with 
this series). Once we clear policy->cpus when all CPUs are offline, we 
can just use that data to figure out if it's "active" or not.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
