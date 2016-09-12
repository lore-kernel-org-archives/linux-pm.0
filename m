From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v3 1/8] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu
 topology for ITMT
Date: Mon, 12 Sep 2016 13:50:15 -0700
Message-ID: <1473713415.3916.48.camel@linux.intel.com>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
         <alpine.DEB.2.20.1609101505290.2804@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1609101505290.2804@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2016-09-10 at 15:10 +0200, Thomas Gleixner wrote:
> On Thu, 8 Sep 2016, Srinivas Pandruvada wrote:
> > 
> > From: Tim Chen <tim.c.chen@linux.intel.com>
> > 
> > We uses ASYM_PACKING feature in the scheduler to move tasks to more
> > capable cpus that can be boosted to higher frequency. This is enabled by
> > Intel Turbo Boost Max Technology 3.0 (ITMT).  We mark the sched domain
> > topology level with SD_ASYM_PACKING flag for such systems to indicate
> > scheduler can use the ASYM_PACKING feature to move load to the
> > more capable cpus.
> Sigh. This changelog does not tell anything about the nature of the patch,
> the rationale for it etc. It's just a meaningless blurb.

Okay, I can add more details about ITMT.  Will also be clearer if
the ITMT patch (patch 5) comes before this one.



> > +}
> > +#else
> > +#define x86_core_flags cpu_core_flags
> > +#define x86_smt_flags cpu_smt_flags
> > +#endif
> No. We first rework the code so that the IMT stuff can be added in a later
> patch easily.

I'll move this patch to come after current patch 5.

Thanks.

Tim
