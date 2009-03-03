From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][Patch 0/3] Fix device_move() vs. dpm_list
 issues.
Date: Tue, 3 Mar 2009 14:53:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0903031302330.3274-100000@iolanthe.rowland.org>
References: <20090303162446.3aff4457@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090303162446.3aff4457@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Mar 2009, Cornelia Huck wrote:

> On Tue, 3 Mar 2009 09:55:27 -0500 (EST),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> > I agree; it would be cleaner if device_move() could fix up dpm_list 
> > directly.  If it doesn't have enough information to do so then change 
> > the interface so that it does.  That should be pretty easy since there 
> > are only a handful of callers.
> 
> The only really obvious one is 'move to NULL' -> 'move to end of
> dpm_list'.
> AFAICS, for that device_move() would need the following
> parameters:
> - device to be moved
> - new parent

Those two are, of course, the parameters it already has.

> - which device to move in dpm_list (device, parent, or none)
> and then still the moves I do in the s390 code don't seem obvious for
> the driver core to get.

After looking through your s390 patch more carefully, I get a mixed-up 
feeling -- as though you think dpm_list goes in reverse order.  It 
doesn't; devices are added in order of registration, so parents come 
_before_ children.  Thus, this makes no sense:

 	ret = device_move(&cdev->dev, &sch->dev);
...

+	/*
+	 * We already reorder dpm_list here since we may not hold
+	 * the dpm_list mutex when deregistering other_sch.
+	 * Order of devices will be correct after moving sch since
+	 * sch's parent (the css) is guaranteed to be after cdev
+	 * already.
+	 */
+	device_pm_move_after(&sch->dev, &cdev->dev);

The existing code makes cdev a child of sch, so when the dust clears we
want sch to come _before_ cdev in dpm_list.  But the new code does the
opposite; it puts sch after cdev.


Anyway, the moves you add in the s390 and Bluetooth patches all fall
into one of these three patterns:

	Move the device to just after its new parent;

	Move the parent to just before the device;

	Move the device to the end.

Therefore all you need to do is add a third argument to device_move(); 
it can be a enumeration taking on one of the values

	DPM_ORDER_DEV_AFTER_PARENT,
	DPM_ORDER_PARENT_BEFORE_DEV,
	DPM_ORDER_DEV_LAST.

(Come to think of it, I don't understand the reason for moving the
device to the end of dpm_list.  What point is there in doing this?)


> Given that the callers still need to specify what to do, I find it much
> easier (and the resulting code much more understandable) if the callers
> fix up dpm_list...

I disagree.  Doing it the way described above would add less than 10
lines of code to device_move() and one argument to each caller, whereas
your changes are a lot more extensive.

Alan Stern
