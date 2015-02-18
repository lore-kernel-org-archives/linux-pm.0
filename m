From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Wed, 18 Feb 2015 13:15:25 -0800
Message-ID: <54E500ED.20001@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <1746505.56yzpQ04cT@vostro.rjw.lan> <CAKohpokrTCSZHUHiAfGumRh9zk590KSQii9U-1u+y194KY0PDg@mail.gmail.com> <35613222.up9lS5n2CM@vostro.rjw.lan> <CAKohpomw8+CnKXx=gF+OKPjrO3hC93Tdjimpx3Ba+He5xq3C8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38361 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbbBRVP1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 16:15:27 -0500
In-Reply-To: <CAKohpomw8+CnKXx=gF+OKPjrO3hC93Tdjimpx3Ba+He5xq3C8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 02/17/2015 08:23 PM, Viresh Kumar wrote:
> On 17 February 2015 at 23:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> - And then during unregistration the sysfs remove will get called?
>
> I meant subsys-remove here, sorry :(
>
>> The CPU device goes away then and that should trigger the remove of all the
>> sysfs directories under it.
>
> How will the cpufreq core know about it? cpufreq_remove_dev() will get called?
>
> Is there a way to emulate it? So that I can test it in my setup..
>

During logical hotplug, you only get the hotplug notifiers.
During physical hotplug, you get the subsys_remove.

So, we have all the information needed to distinguish. Remove the sysfs 
entries only in subsys-remove.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
