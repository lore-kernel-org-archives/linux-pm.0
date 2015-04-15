From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpuidle: Store the idle start time stamp
Date: Wed, 15 Apr 2015 12:20:57 +0200
Message-ID: <20150415102057.GR5029@twins.programming.kicks-ass.net>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34339 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbbDOKVH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 06:21:07 -0400
Content-Disposition: inline
In-Reply-To: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org

On Wed, Apr 15, 2015 at 12:00:22PM +0200, Daniel Lezcano wrote:
> +	target_state->idle_stamp = ktime_to_us(ktime_get());

ktime_get_ns();
