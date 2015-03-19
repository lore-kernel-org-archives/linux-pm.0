From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] ARM: shmobile: cpuidle: Remove the pointless default
 driver
Date: Thu, 19 Mar 2015 11:05:26 +0900
Message-ID: <20150319020526.GL14051@verge.net.au>
References: <1426605912-28032-1-git-send-email-daniel.lezcano@linaro.org>
 <550847BA.8050503@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60453 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbCSCF2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 22:05:28 -0400
Content-Disposition: inline
In-Reply-To: <550847BA.8050503@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: geert Uytterhoeven <geert@linux-m68k.org>, magnus.damm@gmail.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 17, 2015 at 04:26:50PM +0100, Daniel Lezcano wrote:
> 
> Sorry Geert, I forget to Cc you.
> 
> On 03/17/2015 04:25 PM, Daniel Lezcano wrote:
> >The default idle driver uses one state with the WFI instruction.
> >The default idle routine invokes WFI when no cpuidle driver is present.
> >
> >The default cpuidle driver is pointless and does not give more than the
> >default idle routine and moreover it pulls all the mathematics tied with
> >the cpuidle governor for nothing, hence consuming more energy.
> >
> >Remove the default driver, the related code and register the driver directly.
> >
> >[compiled only - no board - no test]
> >
> >Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel,

I have queued this up for v4.1.
