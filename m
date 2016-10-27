From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Thu, 27 Oct 2016 17:17:26 +0200
Message-ID: <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
 <1476707572-32215-4-git-send-email-pmladek@suse.com>
 <20161021132118.4239af86@jacob-builder>
 <20161024154807.GQ23809@pathway.suse.cz>
 <20161024095529.2b1855b4@icelake>
 <20161027145348.GV23809@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44083 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943381AbcJ0PSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 11:18:15 -0400
Content-Disposition: inline
In-Reply-To: <20161027145348.GV23809@pathway.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016-10-27 16:53:48 [+0200], Petr Mladek wrote:
> 
> In each case, I wonder if the problem is caused by the conversion
> to the kthread worker or by the CPU hotplug state conversion.

drop the hotplug patch and you will see.

> Best Regards,
> Petr

Sebastian
