From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Fri, 3 Jun 2016 05:31:34 +0530
Message-ID: <20160603000134.GS3725@vireshk-i7>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
 <CAJZ5v0hF5vk_KPCu0xrRA3mzRBGqW4wtPODkCRk47_n5h_y7jw@mail.gmail.com>
 <CAKohpokG3P4PmmGVD7PcEMramLUv5yrhPY4MkEif3QH0e7EySA@mail.gmail.com>
 <CAJZ5v0h23n7k66fRdmARXStOYFVTpVSQQVa1bN3YixehG=eD4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36385 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbcFCABj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 20:01:39 -0400
Received: by mail-pa0-f47.google.com with SMTP id te7so5716846pab.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 17:01:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h23n7k66fRdmARXStOYFVTpVSQQVa1bN3YixehG=eD4w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Steven Miao <realmz6@gmail.com>

On 02-06-16, 22:35, Rafael J. Wysocki wrote:
> Quoting from this very cover letter "This change allows us to remove
> the (duplicate) sorted-freq-table, which
> was added by following series:", so why to add it in the first place?

Okay, that's fine.

> Besides, there already is a number of tables (per policy which in some
> important cases pretty much means per CPU) in cpufreq that contain
> more-or-less the same information.  For example, if acpi-cpufreq is in
> use, the ACPI layer has a table coming from _PSS, the driver creates
> freq_table to pass to the core and there is an additional one for the
> stats.  And your series adds one more just so it is ordered.  Come on.

Of course.

> If you want to clean that up, fine, but please don't do that in a
> hurry.  Let's talk about it a bit more without sending any more
> patches in that area for the time being.

Okay, I will send all the fixes that you can apply cleanly now in a
separate set.

So, yeah, I get your overall concern. What about this:
- A single patchset to make sure the current policy->freq_table is
  always sorted in Ascending order of frequencies.
- And this sorting will be done per policy only when the policy is
  first created.
- Which would eventually mean merging this series with the [v2 0/2]
  one.

Will that work ?

-- 
viresh
