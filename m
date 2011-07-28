From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Fw: Panic while enabling 2nd CPU core after suspend
 to ram on Intel Atom CPU
Date: Thu, 28 Jul 2011 10:40:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107281030570.1990-100000@iolanthe.rowland.org>
References: <20110727155452.913e913a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110727155452.913e913a.akpm@linux-foundation.org>
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
Cc: Ingo Molnar <mingo@elte.hu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 27 Jul 2011, Andrew Morton wrote:

> On Tue, 26 Jul 2011 22:03:25 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Thursday, July 21, 2011, Andrew Morton wrote:
> > > 
> > > who would be an appropriate person to look at this one? 
> > > 
> > > The suspend_test warning is Rafael, I guess.  But the mwait_idle oops?
> > 
> > The suspend_test warning only means that the resuming of devices took
> > too much time.
> 
> OK, but why did mwait_idle() oops?

I ran across a similar problem some time ago on a UP system (Bugzilla
#15385).  It has since been fixed (commit 85a0e7539781d), but maybe
this is related.

By default, Intel CPUs do not accept the mwait instruction.  It has to 
be enabled specifically by setting a bit in a machine-specific 
register.  Normally the BIOS handles this, but some BIOSes don't when 
resuming from suspend.  As a result, the first mwait executed during 
the resume causes an invalid instruction exception.

The kernel now restores the register value when bringing the primary
CPU back up (that was the fix for my bug), but maybe this doesn't
happen for secondary CPUs.

Alan Stern
