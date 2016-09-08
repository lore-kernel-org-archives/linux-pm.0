From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Replacement][PATCH v2 6/8] acpi: bus: Enable HWP CPPC objects
Date: Thu, 8 Sep 2016 10:10:09 +0200
Message-ID: <20160908081009.GZ10138@twins.programming.kicks-ass.net>
References: <1472775242-10268-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbcIHIKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 04:10:16 -0400
Content-Disposition: inline
In-Reply-To: <1472775242-10268-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com

On Thu, Sep 01, 2016 at 05:14:02PM -0700, Srinivas Pandruvada wrote:
> Need to set platform wide _OSC bits to enable CPPC and CPPC version 2.
> If platform supports CPPC, then BIOS exposess CPPC tables.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Replacement: Fix error reported by 0-day for compile issue on ARM

Oh, here it is.. I hadn't seen it. Please send such patches in-thread as
a reply to the patch they replace.
