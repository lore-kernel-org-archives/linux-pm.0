From: Mark Gross <mgross@linux.intel.com>
Subject: Re: pm qos infrastructure and interface
Date: Thu, 11 Oct 2007 08:08:04 -0700
Message-ID: <20071011150804.GA7293__16010.3036360399$1192115434$gmane$org@linux.intel.com>
References: <20071004215139.GA20078@linux.intel.com>
	<20071010221704.6e438c71.akpm@linux-foundation.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071010221704.6e438c71.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mark.gross@intel.com, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2007 at 10:17:04PM -0700, Andrew Morton wrote:
> On Thu, 4 Oct 2007 14:51:39 -0700 Mark Gross <mgross@linux.intel.com> wrote:
> 
> > The following patch is a generalization of the latency.c implementation
> > done by Arjan last year.  It provides infrastructure for more than one
> > parameter, and exposes a user mode interface for processes to register
> > pm_qos expectations of processes.
> > 
> > 
> > This interface provides a kernel and user mode interface for registering
> > performance expectations by drivers, subsystems and user space
> > applications on one of the parameters.
> > 
> > Currently we have {cpu_dma_latency, network_latency, network_throughput}
> > as the initial set of pm_qos parameters.
> > 
> > The infrastructure exposes multiple misc device nodes one per
> > implemented parameter.  The set of parameters implement is defined by
> > pm_qos_power_init() and pm_qos_params.h.  This is done because having
> > the available parameters being runtime configurable or changeable from a
> > driver was seen as too easy to abuse.
> 
> I'm a bit surprised that this change appears to have no configurability.
> If one has set CONFIG_PM=n (for example), shouldn't it all go away?

We considered that as an option but as latency.c didn't offer it I
didn't either.  

I could see the user mode interface portion of the implementation be
made as a compile time option but the kernel infrastructure will
continue to be needed by at least cpu-idel, pcm_native.c and ipw2100.

You know it could make sense to have the user mode interface part of the
patch as configurable or a build time dependent of sysfs and misc device
support for the linux-tiny guys.  Is it practical to make a linux-tiny
without the sysfs infrastructure needed to make a misc device?  I'll ask
on the linux-tiny list.

--mgross
