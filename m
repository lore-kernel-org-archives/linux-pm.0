From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 3/3][RFC/RFT] PM / sleep: Do not delay the
 synchronization of MTRR during resume
Date: Tue, 6 Feb 2018 22:16:14 +0800
Message-ID: <20180206141614.GA912@yu-chen.sh.intel.com>
References: <cover.1509438899.git.yu.c.chen@intel.com>
 <cbb3b328b1a07e61635c59db958b83318ca18dbd.1509438899.git.yu.c.chen@intel.com>
 <1613777.Al2QaFApID@aspire.rjw.lan>
 <20171213160242.GB29572@yu-chen.sh.intel.com>
 <20180206140417.GA14526@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:32797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbeBFOMW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Feb 2018 09:12:22 -0500
Content-Disposition: inline
In-Reply-To: <20180206140417.GA14526@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rui Zhang <rui.zhang@intel.com>

On Tue, Feb 06, 2018 at 03:04:17PM +0100, Lukas Wunner wrote:
> On Thu, Dec 14, 2017 at 12:02:42AM +0800, Yu Chen wrote:
> > On Wed, Dec 13, 2017 at 01:31:50AM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, October 31, 2017 10:58:50 AM CET Yu Chen wrote:
> [snip]
> > > > In one word, with the patch applied, the cpu online time during resume
> > > > has decreased by about 6 seconds on a bogus MTRR platform, and decreased
> > > > by about 600ms on a 88 cpus Xeon platform after resumed.
> > > > 
> > > > Cc: Len Brown <len.brown@intel.com>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Rui Zhang <rui.zhang@intel.com>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > 
> > > It will be better to combine this with patch [2/3] IMO, because that makes
> > > it clear why the changes in that patch are needed.
> > > 
> > > Also you can define the new flag in mtrr/main.c, set it in
> > > arch_enable_nonboot_cpus_begin() and clear it in
> > > arch_enable_nonboot_cpus_end().  It is better to put it into the
> > > arch-specific code as the flag itself is arch-specific.
> > > 
> > > Then, of course, you don't need patch [1/3] and all can be done in one
> > >  patch.
> > 
> > Ok, will rewrite the patch, thanks! 
> 
> Just for the record, this series cuts down resume time from system sleep
> by 4-5 seconds on my MacBookPro9,1.  Great work, looking forward to this
> being respun and merged.
> 
> Tested-by: Lukas Wunner <lukas@wunner.de>
>
Thanks Lukas,
I've sent the latest patch at:
https://patchwork.kernel.org/patch/10150077/
> Thanks,
> 
> Lukas
