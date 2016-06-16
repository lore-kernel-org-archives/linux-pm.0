From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] powercap/rapl: reduce warning level
Date: Thu, 16 Jun 2016 16:01:13 +0200
Message-ID: <1941240.Fj2gxPBr2R@vostro.rjw.lan>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com> <1464021943-14915-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62116 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754820AbcFPN5C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 09:57:02 -0400
In-Reply-To: <1464021943-14915-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>

On Monday, May 23, 2016 09:45:43 AM Jacob Pan wrote:
> Since RAPL interface is not architectual, its enumeration depends on poking
> MSRs instead of using CPUID method.
> 
> In KVM guest, RAPL driver probe will fail and emit the following message
> for every CPU: no valid rapl domains found in package
> 
> This patch limit the warning to debug only. Still return ENODEV so that RAPL
> does not run on KVM guest.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Applied, thanks!

