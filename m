From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PM: Block races between runtime PM and
	system sleep
Date: Sun, 26 Jun 2011 14:22:00 +0200
Message-ID: <201106261422.00690.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106252235560.10907-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106252235560.10907-100000@netrider.rowland.org>
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
Cc: Tejun Heo <tj@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, June 26, 2011, Alan Stern wrote:
> On Fri, 24 Jun 2011, Rafael J. Wysocki wrote:
> 
> > > > I'm still not clear on why the error handler needs to run at this time.
> > > 
> > > Because SATA ports are suspended with the help of the SCSI error handling
> > > mechanism (which Tejun claims is the best way to do that).
> 
> > I've carried out this exercise to see how complicated it is going to be
> > and it doesn't really seem to be _that_ complicated.  The appended patch
> > illustrates this, but it hasn't been tested, so caveat emptor.
> 
> The patch is straightforward enough.  But will it be sufficient?
> 
> Suppose a SATA port is already in runtime suspend when the system sleep
> starts.  Will the error handler be able to do its special job?  I don't
> know...  It may turn out to be necessary for the SATA port to be
> runtime resumed somewhere along the line.

That's correct, but at least in the ususal situation (i.e. sdev_gendev is
not suspended at run time) the patch makes things work when runtime PM
is disabled during system suspend and enabled during system resume.

It still may be necessary to add code to the SATA subsystem if sdev_gendev
is to be suspended at run time for SATA controllers.  I'm not aware of any
of such cases, though.

Thanks,
Rafael
