From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: suspend/resume governors with PM notifiers
Date: Mon, 18 Nov 2013 21:02:22 +0530
Message-ID: <CAKohpomS_dW64tf52MzcM0BLEgg+iZJveU9mXHgCyUp5qNKqTg@mail.gmail.com>
References: <0e476d16e0ae4b001f5dd4f9ac191f899095928a.1384510171.git.viresh.kumar@linaro.org>
	<5974906.WAPp3f3eVY@vostro.rjw.lan>
	<CAKohpo=PoAaYgLNEVkkTC6tzAH=5hKw4VWTsrjt2jQnr7+6Q_w@mail.gmail.com>
	<5229929.5JRiWnF6CT@vostro.rjw.lan>
	<5289A80B.7080808@linaro.org>
	<5289F29B.8050806@intel.com>
	<CAKohpo=UjSqzE+Jg0s3taykHu4VinNUvLLhRm6pUXiyUc5F-3w@mail.gmail.com>
	<528A1823.8080705@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62984 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3KRPcW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 10:32:22 -0500
Received: by mail-ob0-f174.google.com with SMTP id wn1so750451obc.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2013 07:32:22 -0800 (PST)
In-Reply-To: <528A1823.8080705@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On 18 November 2013 19:07, Lan Tianyu <tianyu.lan@intel.com> wrote:
> The resume/suspend() must be stored in the struct driver->pm? :)

We certainly can't move back to increase redundancy by implementing
driver's specific stuff here :)

>> Apart from that even cpufreq would be a bit hacky as we don't really need
>> per-cpu callbacks..
>>
>
> This maybe depends on where we want the issue to be fixed, right?
> The cpufreq driver also can fix the issue if we run their cpu_driver
> resume/suspend callback earlier.

same as above..

> Another point, I just see cpuidle_resume() and cpuidle_pause() are called in
> the dpm_resume_noirq and dpm_suspend_noirq(). Not sure whether this can be
> applied to cpufreq.

I will still prefer syscore_ops instead of calling framework specific routines
directly from dpm_**() routines.. Don't know why this was done this way
for cpuidle..
