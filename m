From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [patch 1/5] powercap/intel_rapl: Add missing domain data update
 on hotplug
Date: Tue, 22 Nov 2016 17:22:17 -0800
Message-ID: <20161122172217.28e77ed6@jacob-builder>
References: <20161122210518.079483154@linutronix.de>
        <20161122211438.432984735@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23312 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755902AbcKWBUS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 20:20:18 -0500
In-Reply-To: <20161122211438.432984735@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, jacob.jun.pan@linux.intel.com

On Tue, 22 Nov 2016 21:15:58 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> The more interesting question is why rapl_update_domain_data() exists
> at all as nothing ever uses that data.

You are right, initial domain data are read at initialization time but
not used. I seem to remember I did this trying to save and restore rapl
raw settings between module load and unload. But I forgot to use it
for restore :(.

Thanks,

Jacob
