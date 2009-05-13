From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] why do we need run disk sync before entering S3
Date: Wed, 13 May 2009 16:16:26 +0200
Message-ID: <200905131616.27334.rjw__26227.4910034195$1242224456$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
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
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 13 May 2009, Alan Stern wrote:
> On Wed, 13 May 2009, Rafael J. Wysocki wrote:
> 
> > > > I generally agree, but I think we may also leave the syncing to the user space,
> > > > in both cases.
> > > 
> > > Well...
> > > 
> > > Normally kernel writes dirty data to disk each 30
> > > seconds. s2ram/s2disk breaks that promise, so it seems fair to add
> > > explicit sync to keep the "promise".
> > > 
> > > OTOH, I agree it would be more flexible if we left sync to
> > > userspace. In uswsusp case, it actually makes sense. In s2ram
> > > case... if we can do it while keeping compatibility with old
> > > behaviour... why not.
> > 
> > That really depends on the distrubution.  (open)SUSE always syncs before
> > suspend/hibernation AFAICS, but I don't know about the other distros.
> 
> This doesn't address the real question: Should the system be allowed to 
> go into S3 without doing a sync first?
> 
> Whether the sync is initiated by userspace or by the kernel doesn't 
> make any difference.  Likewise, it doesn't matter if there are two 
> syncs (because the second will be very fast, as Pavel said).
> 
> If you really wanted to speed up the suspend transition then you would
> leave out the sync entirely.  But IMO this would be a mistake; the risk
> of data loss is too great.  Which means the time overhead is necessary,
> one way or another.  If userspace does a sync first then the suspend
> transition will be faster, but this is just an accounting artifact (do
> you count the time required for the sync toward the time required for
> the suspend or not).

My point was in fact that if we left the syncing to the user space, then the
user would be able to decide not to sync risking data loss.  At the moment the
user has no choice. :-)

Thanks,
Rafael
