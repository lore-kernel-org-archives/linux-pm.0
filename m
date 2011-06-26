From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Block races between runtime PM and
 system sleep
Date: Sat, 25 Jun 2011 22:39:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106252235560.10907-100000__28004.0212361657$1309056032$gmane$org@netrider.rowland.org>
References: <201106240059.38687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106240059.38687.rjw@sisk.pl>
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
Cc: Tejun Heo <tj@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 24 Jun 2011, Rafael J. Wysocki wrote:

> > > I'm still not clear on why the error handler needs to run at this time.
> > 
> > Because SATA ports are suspended with the help of the SCSI error handling
> > mechanism (which Tejun claims is the best way to do that).

> I've carried out this exercise to see how complicated it is going to be
> and it doesn't really seem to be _that_ complicated.  The appended patch
> illustrates this, but it hasn't been tested, so caveat emptor.

The patch is straightforward enough.  But will it be sufficient?

Suppose a SATA port is already in runtime suspend when the system sleep
starts.  Will the error handler be able to do its special job?  I don't
know...  It may turn out to be necessary for the SATA port to be
runtime resumed somewhere along the line.

Alan Stern
