From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and
 scaling_cur_freq
Date: Fri, 1 Apr 2016 10:29:23 +0200
Message-ID: <20160401082923.GH11035@twins.programming.kicks-ass.net>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
 <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
 <20160401080328.GC3448@twins.programming.kicks-ass.net>
 <9222CD56-C603-449C-A049-E518DAFA6883@linux.intel.com>
 <20160401082323.GE3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160401082323.GE3448@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 01, 2016 at 10:23:23AM +0200, Peter Zijlstra wrote:
> 
> Trim your emails
> 
> On Fri, Apr 01, 2016 at 10:16:42AM +0200, Stephane Gasparini wrote:
> 
> > > That means these delta's can be arbitrarily large, in fact the MSRs can
> > > have wrapped however many times.
> > 
> > 64 bits is 18 446 744 073 709 551 615
> > 
> > so even assuming a 10 GHz frequency if my math are good this is more than
> > 58 years before the MSR wrap around, assuming the device ran always at max
> > freq.
> 
> fair enough.. but going with 10Ghz, cpu_khz would be 10e6 ~ 33 bits,

I can't do maths this morning; 23 bits

> which effectively reduces the wrap/overflow time to just 31 bits, which
> per that frequency is just ~1/4th of a second.

41 giving lots more, but a reasonable time to wrap/overflow.
