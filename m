From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v3 1/8] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu
 topology for ITMT
Date: Mon, 19 Sep 2016 09:01:47 -0700
Message-ID: <1474300907.3916.104.camel@linux.intel.com>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
         <alpine.DEB.2.20.1609101505290.2804@nanos>
         <1473713415.3916.48.camel@linux.intel.com>
         <20160913072613.GB5008@twins.programming.kicks-ass.net>
         <20160919091141.GA1083@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160919091141.GA1083@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-09-19 at 11:11 +0200, Jiri Olsa wrote:
> On Tue, Sep 13, 2016 at 09:26:13AM +0200, Peter Zijlstra wrote:
> > 
> > On Mon, Sep 12, 2016 at 01:50:15PM -0700, Tim Chen wrote:
> > > 
> > > > 
> > > > No. We first rework the code so that the IMT stuff can be added in a later
> > > > patch easily.
> > > I'll move this patch to come after current patch 5.
> > Split the patch, one doing the topo cleanup, one adding the
> > x86_*_flags().
> hi,
> could you please CC me on the next version,
> I'm interested in that cleanup patch..

Sure. Will do.

Tim
