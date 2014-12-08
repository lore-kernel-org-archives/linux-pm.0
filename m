From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 2/4] powerpc/powernv: Enable Offline CPUs to enter
 deep idle states
Date: Mon, 8 Dec 2014 14:33:51 +1100
Message-ID: <20141208033351.GA4437@drongo>
References: <1417678103-32571-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1417678103-32571-3-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:48014 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbaLHDeA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 7 Dec 2014 22:34:00 -0500
Content-Disposition: inline
In-Reply-To: <1417678103-32571-3-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Thu, Dec 04, 2014 at 12:58:21PM +0530, Shreyas B. Prabhu wrote:
> From: "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>
> 
> The secondary threads should enter deep idle states so as to gain maximum
> powersavings when the entire core is offline. To do so the offline path
> must be made aware of the available deepest idle state. Hence probe the
> device tree for the possible idle states in powernv core code and
> expose the deepest idle state through flags.
> 
> Since the  device tree is probed by the cpuidle driver as well, move
> the parameters required to discover the idle states into an appropriate
> common place to both the driver and the powernv core code.
> 
> Another point is that fastsleep idle state may require workarounds in
> the kernel to function properly. This workaround is introduced in the
> subsequent patches. However neither the cpuidle driver or the hotplug
> path need be bothered about this workaround.
> 
> They will be taken care of by the core powernv code.
> 
> Originally-by: Srivatsa S. Bhat <srivatsa@mit.edu>
> Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Reviewed-by: Paul Mackerras <paulus@samba.org>
