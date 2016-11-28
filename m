From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/intel_rapl: fix and tidy up error handling
Date: Mon, 28 Nov 2016 09:31:03 -0800
Message-ID: <20161128093103.3cb4041c@jacob-builder>
References: <1479927666-563-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAJZ5v0jJ4kxcT0MVi3mz0zKRrEiRaNfQqPvY6y5bTHpkPpiU3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23220 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbcK1R3D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 12:29:03 -0500
In-Reply-To: <CAJZ5v0jJ4kxcT0MVi3mz0zKRrEiRaNfQqPvY6y5bTHpkPpiU3A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Marcin Koss <marcin.koss@intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jacob.jun.pan@linux.intel.com

On Thu, 24 Nov 2016 22:06:59 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Nov 23, 2016 at 8:01 PM, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> > Commit e1399ba20eee ("powercap / RAPL: handle missing MSRs") added
> > contraint_to_pl() function to return index into an array. But it
> > can potentially return -EINVAL if powercap layer sends an out of
> > range constraint ID. This patch adds sanity check.
> >
> > Unnecessary RAPL domain pointer check is removed since it must be
> > initialized before calling rapl_unit_xlate().
> >
> > Reported-by: Odzioba, Lukasz <lukasz.odzioba@intel.com>
> > Reported-by: Koss, Marcin <marcin.koss@intel.com>  
> 
> Does this depend on the Thomas' series only?
> 
yes, it is on top of Thomas' series.
> Also, it looks like a Fixes: tag should be present here.
> 
OK. will add that.
> >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> Thanks,
> Rafael

[Jacob Pan]
