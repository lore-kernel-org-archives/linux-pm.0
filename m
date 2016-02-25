From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable HWP by default
Date: Fri, 26 Feb 2016 00:19:41 +0100
Message-ID: <7409824.yRBnCff0bU@vostro.rjw.lan>
References: <1456441759-4877-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65199 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752242AbcBYXSG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 18:18:06 -0500
In-Reply-To: <1456441759-4877-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org

On Thursday, February 25, 2016 03:09:19 PM Srinivas Pandruvada wrote:
> If the processor supports HWP, enable it by default without checking
> for the cpu model. This will allow to enable HWP in all supported
> processors without driver change.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Isn't that a bit risky in the face of recent experience?

Rafael

