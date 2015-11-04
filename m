From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Wed, 4 Nov 2015 14:08:14 -0800
Message-ID: <20151104220814.GS19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030221826.GM19782@codeaurora.org>
 <20151103022933.GN3639@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40022 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965397AbbKDWIQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 17:08:16 -0500
Content-Disposition: inline
In-Reply-To: <20151103022933.GN3639@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 11/03, Viresh Kumar wrote:
> On 30-10-15, 15:18, Stephen Boyd wrote:
> > A side-note. I wonder if it would be better style to have the
> > node name be:
> > 
> > 		opp@600000000 {
> > 
> > At least it seems that the assumption is we can store all the
> > possible combinations of OPP values for a particular frequency in
> > the same node. Following this style would make dt compilation
> > fail if two nodes have the same frequency.
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 3 Nov 2015 07:51:09 +0530
> Subject: [PATCH] PM / OPP: Rename OPP nodes as opp@<opp-hz>
> 
> It would be better to name OPP nodes as opp@<opp-hz> as that will ensure
> that multiple DT nodes don't contain the same frequency. Of course we
> expect the writer to name the node with its opp-hz frequency and not any
> other frequency.
> 
> And that will let the compile error out if multiple nodes are using the
> same opp-hz frequency.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
