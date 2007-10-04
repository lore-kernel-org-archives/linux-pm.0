From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [PATCH] PM_QOS 1 of 2
Date: Thu, 4 Oct 2007 13:39:52 -0700
Message-ID: <20071004203952.GB19803__32977.0633987666$1191530535$gmane$org@linux.intel.com>
References: <20071001234528.GA5238@linux.intel.com>
	<20071004125356.69e01dfe.akpm@linux-foundation.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071004125356.69e01dfe.akpm@linux-foundation.org>
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

On Thu, Oct 04, 2007 at 12:53:56PM -0700, Andrew Morton wrote:
> On Mon, 1 Oct 2007 16:45:28 -0700
> Mark Gross <mgross@linux.intel.com> wrote:
> 
> > The following is the cleaned up patch implementing the power management
> > quality of service infrastructure discussed at the pm summit last June.
> > 
> > It is a genralization of the latency code put into the kernel last year
> > by Arjan.
> > 
> > I would like to get this code included in the MM tree and to get some
> > milage on it.
> > 
> > One thing to note about this implementation is that it exposes an
> > interface to user space for registering pm_qos constraints in addition
> > to the kernel exports.  Its a file based interface where a module can
> > register a constraint and the constraint is valid only as long as the
> > device node is held open.  Upon closing of the device node that
> > constraint is cleaned up.
> > 
> > The patch set is in two postings.  
> > 1) the base parameter code (this email)
> > 2) replacing of latency.c/latenc.h with pm_qos_params.c/pm_qos_params.h
> 
> I wouldn't really view this as an adequate changelog.
> 
> - The Subject:s are pretty pathetic (please see my suggesed replacements)

uhg.  Your right.

> 
> - There is no description of the proposed new kernel<->userspace
>   interfaces.
> 

the above description is light on specific details. 

>   As you are proposing new and permanent enhancements to the Linux API,
>   this is something which should be spelled out in some detail.  Because we
>   can change the implementation, but we can not ever change your interface.
> 
>   It would be nice to get that interface described in Documentation/
>   somewhere, but it is *critical* that the design be fully revealed right
>   now, during review.

I'll provide this.

> 
> 
> Anyway, I am not a suitable person to review this submission.
> 
> I'll put the patches in -mm for a bit of eyeball-and-test (not that anyone
> will know how to test it, due to the secret interfaces) but I do not want
> to move this code into mainline until someone who is familiar with the PM
> code has performed a detailed review of both the implementation and the
> design (whatever that is!).
> 
> Please send new, complete descriptions of these patches.  I don't think
> they can be effectively reviewed without that information.  Except perhaps
> by someone who was at the PM summit, but that's cheating.
> 

I will do this.

--mgross
