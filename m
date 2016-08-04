From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 4 Aug 2016 15:23:59 -0600
Message-ID: <20160804212359.GF1207@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
 <20160804152453.GB1732@brendan-thinkstation>
 <20160804162844.GC1207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33117 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759029AbcHDVYD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 17:24:03 -0400
Received: by mail-pf0-f179.google.com with SMTP id y134so90089765pfg.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2016 14:24:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160804162844.GC1207@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Mark Rutland <mark.rutland@arm.com>

On Thu, Aug 04 2016 at 10:28 -0600, Lina Iyer wrote:
>On Thu, Aug 04 2016 at 09:24 -0600, Brendan Jackman wrote:

>>idle-states.txt (to which this file refers) says that idle state nodes must come
>>under /cpus/idle-states. I don't think power domain idle states belong there, so
>>the documentation should be updated to reflect that.
>>
>Absolutely right. This should be fixed.

Sorry, I take it back. idle-states are cpuidle specific idle states and
possibly include Platform coordinated cluster modes as well (which is
fine). Its rightful place is under /cpus/idle-states. However, domain
idle states that are compatible with "arm,idle-state" would not have
idle-states as the parent node. They would be defined under the domain
provider node and not the CPUs.

Thanks,
Lina

