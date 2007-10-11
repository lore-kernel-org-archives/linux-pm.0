From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pm qos infrastructure and interface
Date: Wed, 10 Oct 2007 22:17:04 -0700
Message-ID: <20071010221704.6e438c71.akpm__24734.9288351417$1192079913$gmane$org@linux-foundation.org>
References: <20071004215139.GA20078@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071004215139.GA20078@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: mark.gross@intel.com, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 4 Oct 2007 14:51:39 -0700 Mark Gross <mgross@linux.intel.com> wrote:

> The following patch is a generalization of the latency.c implementation
> done by Arjan last year.  It provides infrastructure for more than one
> parameter, and exposes a user mode interface for processes to register
> pm_qos expectations of processes.
> 
> 
> This interface provides a kernel and user mode interface for registering
> performance expectations by drivers, subsystems and user space
> applications on one of the parameters.
> 
> Currently we have {cpu_dma_latency, network_latency, network_throughput}
> as the initial set of pm_qos parameters.
> 
> The infrastructure exposes multiple misc device nodes one per
> implemented parameter.  The set of parameters implement is defined by
> pm_qos_power_init() and pm_qos_params.h.  This is done because having
> the available parameters being runtime configurable or changeable from a
> driver was seen as too easy to abuse.

I'm a bit surprised that this change appears to have no configurability.
If one has set CONFIG_PM=n (for example), shouldn't it all go away?
