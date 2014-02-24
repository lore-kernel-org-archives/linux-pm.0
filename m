From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
Date: Mon, 24 Feb 2014 14:13:22 +0530
Message-ID: <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
	<530AF7E4.5080806@linux.vnet.ibm.com>
	<CAKohpok-8_JV8hRDiWnRLYqEqyvD60cyn5Hs1HcZTSEPZjLvOQ@mail.gmail.com>
	<a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 24 February 2014 14:11,  <skannan@codeaurora.org> wrote:
> I just replied to the other email. I think I answered both your questions
> there. Sorry about mixing up CPU and policy. In my case, each CPU is
> independently scalable -- so for now take CPU == policy. I'll fix it up
> once we agree on the fix.

But why do you say this then?

>>> In this specific case, CPU0 set's CPU1's policy->governor in
>>> cpufreq_init_policy() to NULL while CPU1 is using the policy->governor
>>> in __cpufreq_governor().
