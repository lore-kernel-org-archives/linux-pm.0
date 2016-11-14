From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Mon, 14 Nov 2016 11:12:34 -0800
Message-ID: <20161114111234.40d56736@icelake>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:4167 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbcKNTOV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 14:14:21 -0500
In-Reply-To: <20161111173410.GA15785@pathway.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.comEduardo Valentin <edubezval@gmail.com>

On Fri, 11 Nov 2016 18:34:10 +0100
Petr Mladek <pmladek@suse.com> wrote:

> Please, let me known if I should do this as a separate patch
> and/or resend the patchset.

Rui/Eduardo,
There are four independent posted changes made to powerclamp driver:
Should I roll them into one set such that you can easily apply them?
1. add back module device table https://lkml.org/lkml/2016/11/14/760
2. kworker, this patchset
3. cpu hotplug state, this patch.
4. PF_IDLE https://lkml.org/lkml/2016/11/14/747

Thanks,

Jacob
