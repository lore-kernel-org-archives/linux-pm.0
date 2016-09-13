From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/8] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu
 topology for ITMT
Date: Tue, 13 Sep 2016 09:26:13 +0200
Message-ID: <20160913072613.GB5008@twins.programming.kicks-ass.net>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <alpine.DEB.2.20.1609101505290.2804@nanos>
 <1473713415.3916.48.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473713415.3916.48.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 12, 2016 at 01:50:15PM -0700, Tim Chen wrote:
> > No. We first rework the code so that the IMT stuff can be added in a later
> > patch easily.
> 
> I'll move this patch to come after current patch 5.

Split the patch, one doing the topo cleanup, one adding the
x86_*_flags().


