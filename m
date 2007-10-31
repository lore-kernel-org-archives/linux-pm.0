From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PM: Add PM_RESUME_PREPARE and PM_POST_RESUME
	notifiers
Date: Wed, 31 Oct 2007 23:09:00 +0100
Message-ID: <200710312309.01306.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0710311707250.8202-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710311707250.8202-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 31 October 2007 22:11, Alan Stern wrote:
> On Tue, 30 Oct 2007, Rafael J. Wysocki wrote:
> 
> > > Drivers might want to do different things at the beginning of
> > > hibernation and the beginning of a restore.
> > > 
> > > Alternatively, the user interface can be changed.  The current 
> > > organization is slightly illogical; there should be different ioctls 
> > > for prepare-to-create-snapshot and prepare-to-restore-snapshot instead 
> > > of a single SNAPSHOT_FREEZE for both.  How about adding RESTORE_FREEZE 
> > > and RESTORE_UNFREEZE; does this sound good?
> > 
> > Hm, we could define separate FREEZE ioctls for restore, but if they end up
> > doing the same as the analogous snapshot ones, they'll be somewhat redundant
> > ...
> 
> How do you like this version of the patch then?  Redundancy is kept to 
> a minimum.
> 
> (Strictly speaking, we should have two different notification codes for 
> PM_POST_HIBERNATION: one for use after the atomic snapshot has been 
> created and one for use after it has been restored.  But I'm not going 
> to worry about that right now.)

IIRC, the notifiers are not called after creating the image.  Do you think that
they should be called at that time?  If so, then why?

As far as the patch is concerned, I'd prefer not to add new ioctls(), mainly
because there's userland out there that doesn't know about them and we can't
make people switch overnight.  I'd prever to move the notifier calls to
snapshot_open() and snapshot_release().

Greetings,
Rafael
