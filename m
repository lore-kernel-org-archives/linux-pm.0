From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: CPUfreq lockdep issue
Date: Sat, 20 Feb 2016 00:14:44 +0100
Message-ID: <CAJZ5v0jZqaFaEt7Cf35nhKTNFZQLAG7HL9Lkin4g=WcXhNCXTA@mail.gmail.com>
References: <1455793609.9851.45.camel@linux.intel.com>
	<20160218113437.GX2610@vireshk-i7>
	<1455871852.7321.4.camel@linux.intel.com>
	<20160219091723.GB22812@vireshk-i7>
	<1455921344.8680.36.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34946 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1428725AbcBSXO4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 18:14:56 -0500
Received: by mail-lf0-f42.google.com with SMTP id l143so63381311lfe.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2016 15:14:45 -0800 (PST)
In-Reply-To: <1455921344.8680.36.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Dirk J Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Len Brown <lenb@kernel.org>

On Fri, Feb 19, 2016 at 11:35 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-02-19 at 14:47 +0530, Viresh Kumar wrote:
>> Adding the maintainers of the driver in cc now.
> [...]
> Hi Viresh,
>> Hi Guys,
>>
>> Joonas reported a lockdep between cpufreq and intel-pstate driver and
>> we are looking for probable solutions.
>>
>> I failed to understand why should we run intel_pstate_hwp_set() for
>> each online CPU, while the frequency is changed only for a group of
>> CPUs that belong to a policy.
> Don't need from set_policy interface.

>> Ofcourse intel_pstate_hwp_set() is
>> required to be run for all CPUs, while the sysfs files are touched.
>> And so, do we have a problem with below diff?
> I gave a quick test, the change works fine.

Yes, the patch looks correct to me.

Thanks,
Rafael
