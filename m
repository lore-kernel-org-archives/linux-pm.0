From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness is scaled
Date: Fri, 19 Feb 2016 08:38:41 -0800
Message-ID: <001501d16b33$ff61d200$fe257600$@net>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net> <E45553FF-63B3-4E5B-92A0-B5B00353F6F8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta7.telus.net ([209.171.16.80]:55546 "EHLO cmta7.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426821AbcBSQiq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 11:38:46 -0500
In-Reply-To: <E45553FF-63B3-4E5B-92A0-B5B00353F6F8@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>, 'Mel Gorman' <mgorman@techsingularity.net>
Cc: 'Rafael Wysocki' <rjw@rjwysocki.net>, 'Ingo Molnar' <mingo@kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Matt Fleming' <matt@codeblueprint.co.uk>, 'Mike Galbraith' <umgwanakikbuti@gmail.com>, 'Linux-PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

Hi Steph,

On 2016.02.19 03:12 Stephane Gasparini wrote:
>
> The issue you are reporting looks like one we improved on android by using 
> the average pstate instead of using the last requested pstate
>
> We know that this is improving the ffmpeg encoding performance when using the
> load algorithm.
>
> see patch attached
>
> This patch is only applied on get_target_pstate_use_cpu_load however you can give
> it a try on get_target_pstate_use_performance

Yes, that type of patch works on the load based approach.

However, I do not think it works on the performance based approach. Why not?
Well, and if I understand correctly, follow the math and you end up with:

scaled_busy = 100%

scaled_busy = (aperf * 100% / mperf) * (max_pstate / * ((aperf * max_pstate) / mperf))

... Doug


