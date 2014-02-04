From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH V3] cpuidle/governors: Fix logic in selection of idle
 states
Date: Tue, 04 Feb 2014 06:52:15 -0800
Message-ID: <52F0FE9F.501@linux.intel.com>
References: <20140204083531.24802.63370.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12593 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbaBDOw0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Feb 2014 09:52:26 -0500
In-Reply-To: <20140204083531.24802.63370.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, len.brown@intel.com
Cc: benh@kernel.crashing.org, daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com

On 2/4/2014 12:35 AM, Preeti U Murthy wrote:
> The cpuidle governors today are not handling scenarios where no idle state
> can be chosen. Such scenarios coud arise if the user has disabled all the
> idle states at runtime or the latency requirement from the cpus is very strict.
>
> The menu governor returns 0th index of the idle state table when no other
> idle state is suitable. This is even when the idle state corresponding to this
> index is disabled or the latency requirement is strict and the exit_latency
> of the lowest idle state is also not acceptable. Hence this patch
> fixes this logic in the menu governor by defaulting to an idle state index
>  of -1 unless any other state is suitable.

state 0 is defined as polling, and polling ALWAYS should be ok

