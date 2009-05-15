From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] why do we need run disk sync before entering S3
Date: Fri, 15 May 2009 16:36:00 +0200
Message-ID: <200905151636.01318.rjw__45557.7445486144$1242398294$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090514094249.GG6417@elf.ucw.cz>
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
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Pavel Machek wrote:
> 
> > > > That really depends on the distrubution.  (open)SUSE always syncs before
> > > > suspend/hibernation AFAICS, but I don't know about the other distros.
> > > 
> > > This doesn't address the real question: Should the system be allowed to 
> > > go into S3 without doing a sync first?
> > > 
> > > Whether the sync is initiated by userspace or by the kernel doesn't 
> > > make any difference.  Likewise, it doesn't matter if there are two 
> > > syncs (because the second will be very fast, as Pavel said).
> > > 
> > > If you really wanted to speed up the suspend transition then you would
> > > leave out the sync entirely.  But IMO this would be a mistake; the risk
> > > of data loss is too great.  Which means the time overhead is necessary,
> > > one way or another.  If userspace does a sync first then the suspend
> > > transition will be faster, but this is just an accounting artifact (do
> > > you count the time required for the sync toward the time required for
> > > the suspend or not).
> > 
> > My point was in fact that if we left the syncing to the user space, then the
> > user would be able to decide not to sync risking data loss.  At the moment the
> > user has no choice. :-)
> 
> Well, if you can add the choice, without adding anything ugly and with
> staying back-compatible, why not. (sync has to stay by default). I
> believe ioctls() on /dev/snapshot may already enable you to do s2ram
> without sync; if not they could be extended.
> 
> But remember there are even in-kernel s2ram triggers, for example on
> zaurus when battery goes critical.
> 
> (And s2ram without sync _is_ "wrong": writeback timeouts are not
> honored).

OK, so I think the answer is we need the sync() as long as our filesystems
don't support suspend-resume directly.

Thanks,
Rafael
