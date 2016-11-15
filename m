From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Tue, 15 Nov 2016 08:40:57 -0800
Message-ID: <20161115084057.1475dbfc@jacob-builder>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
        <1476707572-32215-4-git-send-email-pmladek@suse.com>
        <20161021132118.4239af86@jacob-builder>
        <20161024154807.GQ23809@pathway.suse.cz>
        <20161024095529.2b1855b4@icelake>
        <20161027145348.GV23809@pathway.suse.cz>
        <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
        <20161027132736.2a74c0b6@jacob-builder>
        <20161111093330.GE2324@pathway.suse.cz>
        <20161111100713.GF2324@pathway.suse.cz>
        <20161111173410.GA15785@pathway.suse.cz>
        <20161114111234.40d56736@icelake>
        <1479209786.2224.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41875 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbcKOQjD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Nov 2016 11:39:03 -0500
In-Reply-To: <1479209786.2224.3.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Tue, 15 Nov 2016 19:36:26 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> On Mon, 2016-11-14 at 11:12 -0800, Jacob Pan wrote:
> > On Fri, 11 Nov 2016 18:34:10 +0100
> > Petr Mladek <pmladek@suse.com> wrote:
> >   
> > > 
> > > Please, let me known if I should do this as a separate patch
> > > and/or resend the patchset.  
> > Rui/Eduardo,
> > There are four independent posted changes made to powerclamp driver:
> > Should I roll them into one set such that you can easily apply them?
> > 1. add back module device table https://lkml.org/lkml/2016/11/14/760
> > 2. kworker, this patchset
> > 3. cpu hotplug state, this patch.
> > 4. PF_IDLE https://lkml.org/lkml/2016/11/14/747
> >   
> hmm, I will apply patch 1 and queue up for next -rc and 4.8 stable.
> 
> please resend the others that are targeted for 4.10 and later in one
> patch set.
OK, will do. I guess Petr and Sebastian are OK with me putting your
powerclamp changes in one patchset too?
