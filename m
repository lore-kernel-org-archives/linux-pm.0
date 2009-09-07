From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/3] PCI PM: Run-time callbacks for PCI
	bus type
Date: Mon, 7 Sep 2009 22:26:18 +0200
Message-ID: <200909072226.18975.rjw__37711.72211641$1252355218$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0909062155340.30707-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0909062155340.30707-100000@netrider.rowland.org>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 September 2009, Alan Stern wrote:
> On Mon, 7 Sep 2009, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce run-time PM callbacks for the PCI bus type.  Make the new
> > callbacks work in analogy with the existing system sleep PM
> > callbacks, so that the drivers already converted to struct dev_pm_ops
> > can use their suspend and resume routines for run-time PM without
> > modifications.
> 
> Do you want to arrange things so that PCI devices with no driver will 
> get runtime-suspended by default?

This certainly is worth doing at one point, but initially I'd rather avoid
that.  We seem to have pretty bad experience with kexec vs devices in D3,
so I'm a bit cautious.

My goal for now is to make a couple of PCI drivers use runtime PM to get
some experience.

Thanks,
Rafael
