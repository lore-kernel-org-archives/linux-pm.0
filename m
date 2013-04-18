From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Date: Thu, 18 Apr 2013 22:34:08 +0900
Message-ID: <20130418133408.GF20929@verge.net.au>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
 <20130418011816.GD4511@verge.net.au>
 <516FBA4C.6020100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55069 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab3DRNeI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 09:34:08 -0400
Content-Disposition: inline
In-Reply-To: <516FBA4C.6020100@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lethal@linux-sh.org, rjw@sisk.pl, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On Thu, Apr 18, 2013 at 11:18:04AM +0200, Daniel Lezcano wrote:
> On 04/18/2013 03:18 AM, Simon Horman wrote:
> > On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
> >> The driver is a global static variable automatically initialized to zero.
> >>
> >> Removing the useless initialization in the init function.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > Hi Daniel,
> > 
> > All four patches in this series seem reasonable to me.
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Please let me know if I should take them through my renesas tree.
> 
> If you are ok with that, is it possible to take them through the
> linux-pm tree ? So the cpuidle drivers are synced and I can continue the
> code consolidation ?

Yes, I am ok with them going through the linux-pm tree.
