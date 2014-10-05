From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: cpu0: Improvements for cpu0_set_target()
Date: Sun, 05 Oct 2014 23:34:17 +0200
Message-ID: <3655188.0cIJZFUFYF@vostro.rjw.lan>
References: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59873 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751798AbaJEVON (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Oct 2014 17:14:13 -0400
In-Reply-To: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, shawn.guo@freescale.com

On Saturday, October 04, 2014 08:26:02 PM Stefan Wahren wrote:
> This patch series contains 2 improvements for cpu0_set_target().
> 
> Stefan Wahren (2):
>   cpufreq: cpu0: Improve debug about matching OPP
>   cpufreq: cpu0: Handle regulator_get_voltage() failure
> 
>  drivers/cpufreq/cpufreq-cpu0.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

We renamed cpufreq-cpu0 to cpufreq-dt in the meantime.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
