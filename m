From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH 2/2] Convert several sysdev users to
 using struct syscore_ops
Date: Fri, 11 Mar 2011 12:33:05 -0800
Message-ID: <20110311203305.GA21045__5888.86345872215$1299876026$gmane$org@suse.de>
References: <201103100131.58206.rjw@sisk.pl> <201103100134.02675.rjw@sisk.pl>
	<20110311171231.GB10437@suse.de> <201103112129.24876.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103112129.24876.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 11, 2011 at 09:29:24PM +0100, Rafael J. Wysocki wrote:
> I thought about two different possible ways forward:
> 
> (1) Push [1/2] and the patches converting things that x86 depends on first,
>     followed perhaps by a patch introducing something like
>     CONFIG_ARCH_NO_SYSDEV_OPS that would simply disable
>     sysdev_{suspend|resume|shutdown}() (x86 would set it).  The other arches
>     might then be converted over time.
> 
> (2) Prepare patches converting everything that can be converted in the tree
>     and push them all in one shot.
> 
> The advantage of (1) is that we can start making changes RSN and the
> advantage of (2) seems to be that we may avoid some potential suspend/resume
> ordering issues on non-x86 architectures that may arise in principle if some
> subsystems are converted to using struct syscore_ops while the others are
> not (syscore_suspend() is executed after sysdev_suspend(), so if we move
> something from the latter to the former, it may end up being executed after
> things that it was executed before previously).
> 
> Please let me know what your opinion is.

Hm, I would prefer (1) as that lets us get this moving sooner, and "flag
days" are never good to have.  If there are problems that arise because
of it, as you have noted, it will be simple just to convert the parts
that were using the "old" methods to the new ones to fix the issue,
right?

thanks,

greg k-h
