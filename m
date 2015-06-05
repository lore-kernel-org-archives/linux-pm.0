From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Implement userspace RAPL bits in cpupower
Date: Fri, 05 Jun 2015 18:21:22 +0200
Message-ID: <5571CC82.5090804@linaro.org>
References: <1499120.6h7ZWas8bA@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33569 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbFEQVV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2015 12:21:21 -0400
Received: by wiwd19 with SMTP id d19so26305230wiw.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2015 09:21:20 -0700 (PDT)
In-Reply-To: <1499120.6h7ZWas8bA@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, jacob.jun.pan@linux.intel.com

On 06/05/2015 04:39 PM, Thomas Renninger wrote:
> Hi,
>
> I'd like to ask whether there already exist userspace bits
> for the powercap/rapl drivers?
>
> Afaik there is some "read-only"/monitor code in turbostat,
> but it is not intended to add any modifying code in there?
>
> I would like to avoid yet another (Intel) CPU specific
> userspace tool, like:
> tools/power/x86/x86_energy_perf_policy
> tools/power/x86/turbostat
>
> and it would be great if userspace bits could be added to
> cpupower utility
> tools/power/cpupower
>
> I searched for rapl and powercap in the MAINTAINERS list,
> but there wasn't any match. Is there a candidate (Jacob?) who
> might be the right one or who volunteers for this?
>
> Thanks for any hints and any discussion input,

I began to write a small test suite using the RAPL register to measure=20
the energy consumed by each test. If someone is interested by that I ca=
n=20
put it somewhere in a git tree, so you can access the RAPL code.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

