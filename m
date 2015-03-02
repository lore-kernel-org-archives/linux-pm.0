From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] cpuidle / sleep: Use broadcast timer for states that
 stop local timer
Date: Mon, 2 Mar 2015 16:27:06 +0000
Message-ID: <20150302162706.GB5515@red-moon>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1809382.kscziWfTPN@vostro.rjw.lan>
 <1882932.aLeaejbmMz@vostro.rjw.lan>
 <89103967.z1sWWFaE6y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47714 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143AbbCBQ1J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 11:27:09 -0500
Content-Disposition: inline
In-Reply-To: <89103967.z1sWWFaE6y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>

On Mon, Mar 02, 2015 at 02:53:28PM +0000, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
> overlooked the fact that entering some sufficiently deep idle states
> by CPUs may cause their local timers to stop and in those cases it
> is necessary to switch over to a broadcase timer prior to entering

s/broadcase/broadcast

> the idle state.  If the cpuidle driver in use does not provide
> the new ->enter_freeze callback for any of the idle states, that
> problem affects suspend-to-idle too, but it is not taken into account
> after the changes made by commit 381063133246.
> 
> Fix that by changing the definition of cpuidle_enter_freeze() and
> re-arranging of the code in cpuidle_idle_call(), so the former does
> not call cpuidle_enter() any more and the fallback case is handled
> by cpuidle_idle_call() directly.
> 
> Fixes: 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Minor comment below, otherwise on the 4-patch series:

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[...]

>  /**
>   * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
> + * @drv: cpuidle driver for the given CPU.
> + * @dev: cpuidle device for the given CPU.
>   *
>   * If there are states with the ->enter_freeze callback, find the deepest of
>   * them and enter it with frozen tick.  Otherwise, find the deepest state
>   * available and enter it normally.

Comment above becomes stale so you should update it, other than that it
seems fine.

Thanks,
Lorenzo
