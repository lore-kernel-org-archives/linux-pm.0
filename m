From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: Fix MSR_CONFIG_TDP_x addressing in
 core_get_max_pstate
Date: Sat, 09 Jul 2016 20:45:39 -0700
Message-ID: <1468122339.13617.128.camel@linux.intel.com>
References: <577FF3FC.6030004@siemens.com>
	 <1468006747.13617.117.camel@linux.intel.com>
	 <1741569.1V1Ap4DoMu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32701 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854AbcGJDrH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 9 Jul 2016 23:47:07 -0400
In-Reply-To: <1741569.1V1Ap4DoMu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Sat, 2016-07-09 at 02:45 +0200, Rafael J. Wysocki wrote:
> On Friday, July 08, 2016 12:39:07 PM Srinivas Pandruvada wrote:
> > On Fri, 2016-07-08 at 20:42 +0200, Jan Kiszka wrote:
> > > If MSR_CONFIG_TDP_CONTROL is locked, we currently try to address
> > > some
> > > MSR 0x80000648 or so. Mask out the relevant level bits 0 and 1.
> > > 
> > > Found while running over the Jailhouse hypervisor which became
> > > upset
> > > about this strange MSR index.
> > > 
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> OK
> 
> Should this go into stable?
Better to mark for stable tree 4.4+

Thanks,
Srinivas

