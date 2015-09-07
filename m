From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
Date: Mon, 07 Sep 2015 23:46:05 +0200
Message-ID: <1520802.NgIZNea4vG@vostro.rjw.lan>
References: <55E97973.1020301@jp.fujitsu.com> <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41061 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751249AbbIGVSP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 17:18:15 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Monday, September 07, 2015 09:00:39 AM Chen, Yu C wrote:
> Hi, Seiichi
> 
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Seiichi Ikarashi
> > Sent: Friday, September 04, 2015 6:59 PM
> > To: kristen@linux.intel.com; Wysocki, Rafael J
> > Cc: linux-pm@vger.kernel.org
> > Subject: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
> > 
> > Add some value check to prevent a reversal, max_perf_pct < min_perf_pct.
> > 
> > Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
> > 
> I guess a similar patch has been sent at:
> https://patchwork.kernel.org/patch/6995461/

I seem to have overlooked this one, most likely because it was set as an
RFC.

I'll find it and respond to it now.

Thanks,
Rafael

