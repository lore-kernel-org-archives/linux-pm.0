From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Fri, 04 Dec 2015 02:41:38 +0100
Message-ID: <4039574.A1Xg0PlAdu@vostro.rjw.lan>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com> <1449165359-25832-3-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52239 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754342AbbLDBLq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 20:11:46 -0500
In-Reply-To: <1449165359-25832-3-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com

On Thursday, December 03, 2015 06:55:54 PM Philippe Longepe wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

If you submit somebody else's patches (like in this case), please always
add a Sign-off-by tag from yourself to them in addition to the original
Sign-off-by tag from the author.  Otherwise, they can't be applied for
formal reasons.

> Current approach of one size fits all is not sustainable. Only per cpuid
> based configuration, we can do now is to select different PID parameters.
> But that is not enough. 

The above part of the changelog can go away in my view.  It doesn't add
anything useful.

> The target systems using different cpus have

"Target systems ..."

> different power and performance requirement.

"requrements" (s missing).

> They may use different
> algorithms to get next pstate based on their power or performance

"the next P-state"

> preference. For example low powered systems may want to ramp up pstates
> more conservatively than a core desktop or server platforms.

What about: "For example, power-constrained systems may not want to use
high-performance P-states as aggressively as a full-size desktop or a server
platform."

> A server
> platforms may want to run as close to max to get better performance, than
> a laptop like systems.

"A server platform may want to run close to the max to achieve better performance,
while laptop-like systems may prefer sacrificing performance for longer
battery lifes."

> This change allows cpuid based selection of algorithm to get target pstate.

"For the above reasons, modify intel_pstate to allow the target P-state
selection algorithm to be depend on the CPU ID."

> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The change itself looks reasonable to me.

Thanks,
Rafael

