From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pci: Updates to Rafael's runtime PCI PM
	patch set
Date: Wed, 11 Nov 2009 21:47:50 +0100
Message-ID: <200911112147.50830.rjw__21867.5283169889$1257972531$gmane$org@sisk.pl>
References: <200910090051.50932.rjw@sisk.pl> <200911112058.20331.rjw@sisk.pl>
	<20091111200503.GA22328@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091111200503.GA22328@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 November 2009, Matthew Garrett wrote:
> On Wed, Nov 11, 2009 at 08:58:20PM +0100, Rafael J. Wysocki wrote:
> 
> > The PME was supposed to be turned on by pci_prepare_to_sleep().
> > I guess it wasn't in practice?
> 
> Only if the device is set as a wakeup device, which seems messy.

Right.  Plus there was an implicit assumption that devices which could wake up
would also be able to generate PME at run time.  It turns out that that need
not be the case, though.

> Though there may need to be a check there to avoid duplicate PME setup.

Hmm, I need to think about that for a while.

> > Generally, some parts of it belong to the
> > "PCI PM: Run-time callbacks for PCI bus type" patch and the others belong
> > to "PCI / ACPI PM: Platform support for PCI PME wake-up" patch.  Should I fold
> > the changes into them?
> 
> Feel free!

OK, thanks!
