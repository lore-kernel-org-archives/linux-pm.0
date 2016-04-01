From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: acpi: policy->driver_data can't be NULL in ->exit()
Date: Fri, 01 Apr 2016 23:00 +0200
Message-ID: <3085774.06cHpqj0HV@vostro.rjw.lan>
References: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org> <CAJZ5v0gyndbTjEYvS8BjZzC-jsKc_M2w9BZF=z-tjEVqMxqFog@mail.gmail.com> <20160401082254.GA2987@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58694 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753761AbcDAU5l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 16:57:41 -0400
In-Reply-To: <20160401082254.GA2987@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, April 01, 2016 01:52:54 PM Viresh Kumar wrote:
> On 30-03-16, 13:18, Rafael J. Wysocki wrote:
> > It conflicts with other stuff (as you know), so I'm not sure about the
> > order in which they are going to be applied, though.
> 
> Please let me know when can I rebase and resend this one. I saw that you have
> moved your patches to linux-next now.

I have, but they need to be rebased on top of 2 intel_pstate fixes I want to
push for v4.6 still and some more minor changes will be necessary.

I guess next week will be the right time kind of, but I will be traveling
10-17 Apr, so I may not have much time to process stuff.

Thanks,
Rafael

