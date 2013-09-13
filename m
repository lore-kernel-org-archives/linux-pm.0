From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 097/228] cpufreq: cris: don't initialize part of policy
 that is set by core too
Date: Fri, 13 Sep 2013 17:27:58 +0200
Message-ID: <20130913152758.GK32443@axis.com>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <ba2db8dd7d87b0a284be900bf908c09444e6d979.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:36040 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757421Ab3IMP2A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 11:28:00 -0400
Content-Disposition: inline
In-Reply-To: <ba2db8dd7d87b0a284be900bf908c09444e6d979.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>

On Fri, Sep 13, 2013 at 03:00:43PM +0200, Viresh Kumar wrote:
> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
> 
> Most recent of those changes is to call ->get() in the core after calling
> ->init().

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel@axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
