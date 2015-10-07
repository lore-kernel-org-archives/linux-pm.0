From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct
 on governor switch
Date: Wed, 07 Oct 2015 11:46:29 -0400
Message-ID: <56153E55.3060306@redhat.com>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan> <002701d100cc$98cb8c60$ca62a520$@net> <5614ED1C.8070709@redhat.com> <000001d10109$10d34630$3279d290$@net> <561527D9.3020009@redhat.com> <000301d10116$88852330$998f6990$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410AbbJGPqb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 11:46:31 -0400
In-Reply-To: <000301d10116$88852330$998f6990$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>



On 10/07/2015 11:40 AM, Doug Smythies wrote:
> 
> Do we agree or disagree that the root issue seems to be (from your test)?:
> 
> \#  echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
> 
> [   21.483436] store_min_perf_pct[453] min_sysfs_pct = 100
> [   21.489373] store_min_perf_pct[456] min_perf_pct = 100
> [   21.495203] store_min_perf_pct[459] min_perf_pct = 100
> [   21.501050] store_min_perf_pct[462] min_perf_pct = 100

Yep, and it appears to be done by default in Fedora & RHEL :/ ... the issue is
still the same IMO that min_sysfs_pct & max_sysfs_pct are not cleared on a
governor switch.

P.
