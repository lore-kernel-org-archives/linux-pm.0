From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Mon, 28 May 2007 19:26:59 +0200
Message-ID: <200705281927.00277.rjw@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl> <200705272230.04478.rjw@sisk.pl>
	<20070528131243.GP18807@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070528131243.GP18807@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 28 May 2007 15:12, Pavel Machek wrote:
> Hi!
> 
> > Make it possible to register hibernation and suspend notifiers, so that
> > subsystems can perform hibernation-related or suspend-related operations that
> > should not be carried out by device drivers' .suspend() and
> > .resume() routines.
> 
> I believe it adds _way_ too many notifiers.
> 
> > +PM_PRE_FREEZE		The system is going to hibernate or suspend, tasks will
> > +			be frozen immediately
> 
> 80 columns.

OK

> Anyway yes, this one is needed. 
> 
> > +PM_POST_THAW		Tasks have just been thawed after a resume or restore
> > +			from a hibernation image
> 
> Symetrical with the previous one, useful for freeing firmware images, ok.
> 
> > +PM_HIBERNATION_PREPARE	The system is preparing for hibernation.  Tasks have
> > +			been frozen, memory is going to be freed and devices
> > +			are going to be suspended.
> 
> What is this one good for?

Allocating memory before the hibernation, mainly.  Anything done after freezing
tasks.

> > +PM_SNAPSHOT_FAILED	The creation of hibernation image has failed.  Tasks
> > +			will be thawed immediately.
> 
> Does this one need to be different from POST_THAW?

Do you mean POST_RESTORE?  Well, maybe not.  Yesterday I thought it would be
for a specific reason, but now I can't recall what it was. :-(

> I do not see the need for the other chains. Notice that we do not
> _want_ to have too many of them, because changing anything in the
> hibernation will become impossible with 10 chains having intimate
> details of suspend sequence.

I think the two suspend-specific might be handy.

What about:

PM_PRE_FREEZE
PM_HIBERNATION_PREPARE
PM_POST_HIBERNATION (handling failed snapshots too)
PM_POST_THAW

plus PM_RESTORE_PREPARE for the restore and

PM_SUSPEND_PREPARE
PM_POST_SUSPEND (handling failed suspends too)

for the suspend code path?

Rafael
