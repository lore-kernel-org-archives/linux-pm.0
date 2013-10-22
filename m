From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH V2 Resend 13/34] cpufreq: ia64: Convert to light weight
 ->target_index() routine
Date: Tue, 22 Oct 2013 16:32:35 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D46B71@ORSMSX106.amr.corp.intel.com>
References: <cover.1382104514.git.viresh.kumar@linaro.org>
 <f05117ee651167f5513977940f0e6f0322a30311.1382104515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16110 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab3JVQcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2013 12:32:54 -0400
In-Reply-To: <f05117ee651167f5513977940f0e6f0322a30311.1382104515.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
>
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony

