From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Sat, 31 Oct 2015 07:46:12 +0530
Message-ID: <20151031021612.GU3716@ubuntu>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030214907.GJ19782@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33085 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbJaCQR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 22:16:17 -0400
Received: by padhy1 with SMTP id hy1so83856417pad.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2015 19:16:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151030214907.GJ19782@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 30-10-15, 14:49, Stephen Boyd wrote:
> I suppose if you wanted to have 64 possible combinations of some
> attribute you would just extend it to two 32 bit numbers in
> sequence? I don't see the limitation here, and hopefully there
> isn't a limitation so that we can specify sufficiently large
> numbers with more bits if we need to.

Yeah, we discussed this earlier when Lee had the same query and I
suggested the exact same thing to him then.

-- 
viresh
