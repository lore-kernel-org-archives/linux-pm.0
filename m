From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Thu, 20 Aug 2009 18:17:04 +0200
Message-ID: <200908201817.04231.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908201115020.2656-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908201115020.2656-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 20 August 2009, Alan Stern wrote:
> On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> 
> > Usually, however, restoring the PCI config space twice doesn't hurt, although
> > it evidently does hurt on your system.
> > 
> > Hm, there's a patch that should help here I think.  Can you please test
> > this one: http://patchwork.kernel.org/patch/40062/ ?
> 
> Testing confirms that Alex's patch (pci: check saved state before
> restore) fixes the resume problem.

Thanks for the confirmation.

> IMO it should be merged before 2.6.31 is released.

Well, that's a Jesse's decision, I've already acked the patch.

There is a small risk related to it, though, because it's going to affect
all of the drivers that do their own pci_restore_state().

Thanks,
Rafael
