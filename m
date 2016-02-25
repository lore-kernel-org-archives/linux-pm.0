From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: disable HWP notifications
Date: Fri, 26 Feb 2016 00:18:38 +0100
Message-ID: <4390416.B5Ve4E8iPL@vostro.rjw.lan>
References: <1456441771-4961-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41083 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751907AbcBYXRE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 18:17:04 -0500
In-Reply-To: <1456441771-4961-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org

On Thursday, February 25, 2016 03:09:31 PM Srinivas Pandruvada wrote:
> Disable HWP Interrupt notification before enabling HWP. Since we don't
> have HWP interrupt handling for possible performance interrupts, there
> is not much use of enabling HWP interrupts.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The patch is fine, but are there any known systems where it fixes any
functional issues just for the record?

Rafael

