From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6 v8] cpufreq, highbank: add support for highbank
 cpufreq
Date: Thu, 6 Dec 2012 17:37:28 +0800
Message-ID: <20121206093726.GB27003@S2100-06.ap.freescale.net>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-7-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354726121-17190-7-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 05, 2012 at 10:48:41AM -0600, Mark Langsdorf wrote:
> Highbank processors depend on the external ECME to perform voltage
> management based on a requested frequency. Communication between the
> A9 cores and the ECME happens over the pl320 IPC channel.
> 
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: shawn.guo@linaro.org

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
