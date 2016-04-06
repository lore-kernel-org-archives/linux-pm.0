From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 1/3] intel_pstate: Use pr_fmt
Date: Wed, 6 Apr 2016 07:51:06 -0700
Message-ID: <002601d19013$c129de60$437d9b20$@net>
References: <cover.1459887986.git.joe@perches.com>	 <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com> <1459892619.7030.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta6.telus.net ([209.171.16.79]:48343 "EHLO cmta6.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbcDFOvO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Apr 2016 10:51:14 -0400
In-Reply-To: <1459892619.7030.2.camel@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Joe Perches' <joe@perches.com>, 'Len Brown' <lenb@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016.04.05 02:44 Srinivas Pandruvada wrote:
> On Tue, 2016-04-05 at 13:28 -0700, Joe Perches wrote:
>> Prefix the output using the more common kernel style.
>> 
>> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)

...[cut, example left]...

> -		pr_warn("intel_pstate: Turbo disabled by BIOS or
> unavailable on processor\n");
> +		pr_warn("Turbo disabled by BIOS or unavailable on
> processor\n");

I do  not understand.
The common and unique string "intel_pstate" was added on purpose
so as to provide a way to easily extract the related message from
an otherwise huge log file.

Reference:
commit f16255eb930173f386db0ce78ed41401aa8a94a6



