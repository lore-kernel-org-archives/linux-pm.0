From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Broxton support
Date: Wed, 15 Jun 2016 01:28:05 +0200
Message-ID: <3816547.L8WcblorrA@vostro.rjw.lan>
References: <1465511681-6571-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56702 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751332AbcFNXX4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 19:23:56 -0400
In-Reply-To: <1465511681-6571-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Thursday, June 09, 2016 03:34:41 PM Srinivas Pandruvada wrote:
> Added Broxton cpu model number. Broxton requires core_params to get
> performance limits via MSRs, but it is an Atom platform, which requires
> more power optimized algorithm. So the P state selection will use similar
> algorithm as other Atom platforms.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied, thanks!

