From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] cpufreq: Make sure frequency transitions are serialized
Date: Fri, 21 Mar 2014 15:36:09 +0530
Message-ID: <CAKohpo=ugBphZ2cz6FwOgsMPkPGRo-H2OSRPBbDbTqj=fn_kHw@mail.gmail.com>
References: <cover.1395379422.git.viresh.kumar@linaro.org>
	<f6116069b730c0c3a74ff627fa818b98dc4f1491.1395379422.git.viresh.kumar@linaro.org>
	<532BEE64.3090501@linux.vnet.ibm.com>
	<CAKohpom8ZHXxVmuSHYL5nyZzNrK8EFNVdx5XJdJxiHWPb13aeg@mail.gmail.com>
	<532BFB77.5060107@linux.vnet.ibm.com>
	<CAKohpomY4xf4tOFTGt-ykE7sUi4ks7vW5qp8ytgopm6CiY9QRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:58989 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759943AbaCUKGK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 06:06:10 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so2283731oag.11
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 03:06:09 -0700 (PDT)
In-Reply-To: <CAKohpomY4xf4tOFTGt-ykE7sUi4ks7vW5qp8ytgopm6CiY9QRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 21 March 2014 14:51, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> @Catalin: We have a problem here and need your expert advice. After changing
> CPU frequency we need to call this code:
>
> cpufreq_notify_post_transition();
> policy->transition_ongoing = false;
>
> And the sequence must be like this only. Is this guaranteed without any
> memory barriers? cpufreq_notify_post_transition() isn't touching
> transition_ongoing at all..

For others this is what we discussed on IRC (rmk: Russell King)

<rmk> I'm no barrier expert, but the compiler can't reorder that assignment
across a function call which it knows nothing about (which it can't
know anything
about because it calls other functions through function pointers)

<rmk> however, the CPU could re-order the effects with respect to other agents
(cpus/devices) when they look at the memory

<rmk> for the local CPU, the question is really: what does the C
language virtual
machine say about this - that's what really matters.  If the CPU does
speculative
stuff, it still has to make the machine behaviour fit that model.
