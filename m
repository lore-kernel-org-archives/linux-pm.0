From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable
 polling
Date: Wed, 4 Nov 2015 08:01:38 -0800
Message-ID: <563A2BE2.4090101@linux.intel.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
 <1446590059-18897-3-git-send-email-riel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27765 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964926AbbKDQBv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Nov 2015 11:01:51 -0500
In-Reply-To: <1446590059-18897-3-git-send-email-riel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: riel@redhat.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, daniel.lezcano@linaro.org

On 11/3/2015 2:34 PM, riel@redhat.com wrote:
> From: Rik van Riel <riel@redhat.com>
>
> The menu governor carefully figures out how much time we typically
> sleep for an estimated sleep interval, or whether there is a repeating
> pattern going on, and corrects that estimate for the CPU load.
>
> Then it proceeds to ignore that information when determining whether
> or not to consider polling. This is not a big deal on most x86 CPUs,
> which have very low C1 latencies, and the patch should not have any
> effect on those CPUs.
>
> However, certain CPUs (eg. Atom) have much higher C1 latencies, and
> it would be good to not waste performance and power on those CPUs if
> we are expecting a very low wakeup latency.
>
> Disable polling based on the estimated interactivity requirement, not
> on the time to the next timer interrupt.
>
good catch!

Acked-by: Arjan van de Ven <arjan@linux.intel.com>

