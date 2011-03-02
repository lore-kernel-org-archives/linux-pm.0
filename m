From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Wed, 2 Mar 2011 10:12:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103021010050.2015-100000__21590.6489211649$1299078818$gmane$org@iolanthe.rowland.org>
References: <201103020049.36902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103020049.36902.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Mar 2011, Rafael J. Wysocki wrote:

> > > How it works is, basically, that when the device signals wakeup, it either
> > > causes a PME# signal to be raised (parallel PCI), or a PME Message to be
> > > sent upstream (PCIe).  In the first case it will cause a platform event
> > > (eg. ACPI GPE) to occur and the handle of that event will resume your
> > > device (using pm_request_resume()).  In the second case it will cause the PCIe
> > > root port handling the PME Message to generate an interrupt and the handler of
> > > that interrupt will resume your device.
> > Thanks, that explain a lot how it works.
> > What I still dont understand is that the wake source I'll have (e.g.
> > sd card insert) is still an interrupt source.
> > So it is supposed to generate interrupt until the interrupt source is
> > acknowledged.
> > Are we supposed to mask that interrupt source while suspended to make
> > sure we have either wake or interrupt?
> 
> I think the interrupt should be masked while suspended and the driver's resume
> routine should unmask it.

Right.  That's how the PCI-based USB host controller drivers work.  
The suspend routine disables interrupt generation and enables PME
wakeup signals, and the resume routine does the reverse.

Alan Stern
