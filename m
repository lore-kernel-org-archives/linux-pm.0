From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PM: Add PM_RESUME_PREPARE and PM_POST_RESUME
	notifiers
Date: Tue, 30 Oct 2007 10:52:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710301041140.4306-100000@iolanthe.rowland.org>
References: <200710292334.12812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710292334.12812.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 29 Oct 2007, Rafael J. Wysocki wrote:

> On Monday, 29 October 2007 22:30, Alan Stern wrote:
> > Rafael:
> > 
> > How does this patch look?  Any reason not to have the resume notifiers?  
> 
> Yes.
> 
> The userland interface already uses PM_HIBERNATION_PREPARE and
> PM_POST_HIBERNATION for restore too, so if anything, we should call these
> from software_resume() either.

I could use those same notifiers, but are you sure that's a good idea?  
Drivers might want to do different things at the beginning of
hibernation and the beginning of a restore.

Alternatively, the user interface can be changed.  The current 
organization is slightly illogical; there should be different ioctls 
for prepare-to-create-snapshot and prepare-to-restore-snapshot instead 
of a single SNAPSHOT_FREEZE for both.  How about adding RESTORE_FREEZE 
and RESTORE_UNFREEZE; does this sound good?

Alan Stern

P.S.: While I'm updating things, the thought occurs that 
PM_RESTORE_PREPARE and PM_POST_RESTORE would be better names than 
PM_RESUME_PREPARE and PM_POST_RESUME.
