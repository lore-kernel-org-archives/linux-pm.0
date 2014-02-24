From: skannan@codeaurora.org
Subject: Re: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
Date: Mon, 24 Feb 2014 08:47:15 -0000
Message-ID: <b59f4a49af4ebd12c2d61e58dfb27a39.squirrel@www.codeaurora.org>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
    <530AF7E4.5080806@linux.vnet.ibm.com>
    <CAKohpok-8_JV8hRDiWnRLYqEqyvD60cyn5Hs1HcZTSEPZjLvOQ@mail.gmail.com>
    <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
    <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:35926 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbaBXIrQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 03:47:16 -0500
In-Reply-To: <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Viresh Kumar wrote:
> On 24 February 2014 14:11,  <skannan@codeaurora.org> wrote:
>> I just replied to the other email. I think I answered both your
>> questions
>> there. Sorry about mixing up CPU and policy. In my case, each CPU is
>> independently scalable -- so for now take CPU == policy. I'll fix it up
>> once we agree on the fix.
>
> But why do you say this then?

Sorry, not sure I understand what you mean.

I agree, wording in my commit text might be unclear. I'll fix it after we
agree on the code fix. In the MSM case, each CPU has it's own policy.

I'm assuming your original complaint was about my confusing wording. Maybe
that's not what you were pointing out?

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

