From: Heiko Stuebner <heiko@sntech.de>
Subject: cpufreq(-dt) with two clocks but one regulator
Date: Fri, 15 Sep 2017 00:53:42 +0200
Message-ID: <1515316.mHJbnBRRvK@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:43596 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbdINWxp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Sep 2017 18:53:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, Klaus Goger <klaus.goger@theobroma-systems.com>

Hi Viresh,

if possible I'd like a pointer in the right direction for the following
situation:

The rk3368 has two cpu clusters of 4 Cortex-A53 cores each, with separate
clock supplies but sharing its supplying regulator. It looks like it was
originally meant for some switched big-little system, with the little
cluster maxing out at 1.2GHz while the big cluster can reach 1.5GHz.

This of course fails miserably with current cpufreq, as the two sets
of operating points fight over control of the regulator and after talking
with real-life users of the soc it seems most desireable to have all
8 cores available at 1.2GHz than only 4 at 1.5GHz max.

But as the clock seems to be bound to the opp table itself simply sharing
the table of course also doesn't work, as only the first clock would be set.


I'm currently only seeing somehow hacky options to solve this, so if you
have some direction on how to solve something like this I would be really
grateful :-)


Thanks
Heiko
