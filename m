From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v8 4/8] x86/sysctl: Add sysctl for ITMT scheduling feature
Date: Tue, 29 Nov 2016 18:51:15 +0100
Message-ID: <20161129175115.pqkgmnjccirsm2lr@pd.tnic>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <07cc62426a28bad57b01ab16bb903a9c84fa5421.1479844244.git.tim.c.chen@linux.intel.com>
 <20161128085608.v7ujy5j2iftn6qs5@pd.tnic>
 <1480440649.3064.39.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59575 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753214AbcK2Rx7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Nov 2016 12:53:59 -0500
Content-Disposition: inline
In-Reply-To: <1480440649.3064.39.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, Nov 29, 2016 at 09:30:49AM -0800, Tim Chen wrote:
> I am following the convention in /proc/sys/kernel/sched_autogroup_enabled
> and sysctl_sched_autogroup_enabled that's also in /proc/sys/kernel.

That's hardly a convention to me:

$ ls -l /proc/sys/kernel/*abled
-rw-r--r-- 1 root root 0 Nov 29 18:47 /proc/sys/kernel/ftrace_enabled
-rw-r--r-- 1 root root 0 Nov 29 18:47 /proc/sys/kernel/kexec_load_disabled
-rw-r--r-- 1 root root 0 Nov 29 18:47 /proc/sys/kernel/modules_disabled

enabled, disabled, ...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
