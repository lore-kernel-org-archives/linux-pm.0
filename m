From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/5] cpufreq: sysfs cleanup
Date: Thu, 22 Oct 2015 07:25:24 +0530
Message-ID: <20151022015524.GA3897@ubuntu>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34609 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbbJVBz3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 21:55:29 -0400
Received: by padhk11 with SMTP id hk11so71455293pad.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 18:55:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org

On 15-10-15, 21:35, Viresh Kumar wrote:
> Rafael,
> 
> This is in response to the other thread where you and Saravana were
> discussing this. It doesn't allow updating policy for offline CPUs yet,
> but does cleanup the sysfs stuff.
> 
> This is untested by me as I didn't had access to the hardware to test
> this week. But this is tested by Fengguang's build bot for some time
> now.
> 
> Will be good if one of you can test this out.

I am back now and

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
