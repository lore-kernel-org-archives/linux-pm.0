From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] Convert several sysdev users to
	using struct syscore_ops
Date: Fri, 11 Mar 2011 21:29:24 +0100
Message-ID: <201103112129.24876.rjw__42795.3546903611$1299875411$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103100134.02675.rjw@sisk.pl>
	<20110311171231.GB10437@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110311171231.GB10437@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Friday, March 11, 2011, Greg KH wrote:
> On Thu, Mar 10, 2011 at 01:34:02AM +0100, Rafael J. Wysocki wrote:
> > Some subsystems need to carry out suspend/resume and shutdown
> > operations with one CPU on-line and interrupts disabled and they
> > define sysdev classes and sysdevs specifically for this purpose.
> > This leads to unnecessarily complicated code and excessive memory
> > usage, so switch them to using struct syscore_ops objects for this
> > purpose instead.
> 
> Heavily-Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> :)

Heh, thanks!

> Do you want to resend this with a signed-off-by and your first one so I
> can apply it to my tree, or do you want to take it through yours?

Well, I'm going to resend with sign-offs anyway.  Besides, I'm not sure if
I should split [2/2] into a few smaller patches.  At least the stuff outside
of arch/x86 should be done in separate patches IMHO.

Apart from this, there are other architectures using sysdevs for defining
"very late" and "very early" PM callbacks, ARM in particular (that one is going
to be fun to untangle).

I thought about two different possible ways forward:

(1) Push [1/2] and the patches converting things that x86 depends on first,
    followed perhaps by a patch introducing something like
    CONFIG_ARCH_NO_SYSDEV_OPS that would simply disable
    sysdev_{suspend|resume|shutdown}() (x86 would set it).  The other arches
    might then be converted over time.

(2) Prepare patches converting everything that can be converted in the tree
    and push them all in one shot.

The advantage of (1) is that we can start making changes RSN and the
advantage of (2) seems to be that we may avoid some potential suspend/resume
ordering issues on non-x86 architectures that may arise in principle if some
subsystems are converted to using struct syscore_ops while the others are
not (syscore_suspend() is executed after sysdev_suspend(), so if we move
something from the latter to the former, it may end up being executed after
things that it was executed before previously).

Please let me know what your opinion is.

> thanks again for doing this.

No big deal really. :-)

Thanks,
Rafael
