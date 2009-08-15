From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sat, 15 Aug 2009 23:44:46 +0200
Message-ID: <200908152344.46898.rjw__44422.701400663$1250372699$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908151143560.18415-100000@netrider.rowland.org>
	<200908152321.53283.rjw@sisk.pl>
	<20090815212756.GA31784@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090815212756.GA31784@srcf.ucam.org>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 15 August 2009, Matthew Garrett wrote:
> On Sat, Aug 15, 2009 at 11:21:53PM +0200, Rafael J. Wysocki wrote:
> 
> > I can even imagine a scenario where this setting might be useful, like when
> > we don't want a network adapter to be woken up from the outside.
> 
> I think in that case we'd probably just want the interface to be downed? 
> Some of this is going to require device-specific policy, I think - for 
> the network case we probably want something in between IF_RUNNING and 
> IF_DOWN (IF_CARRIER, perhaps) that indicates that we want the PHY to be 
> powered. Pushing this out to sysfs would mean we'd have a consistent 
> interface but varying semantics, and I'm not convinced that's an 
> especially helpful interface.

I'm not disagreeing with that.

At this point I'd like to know the Alan's opinion.  I would gladly use the
'runtime_forbidden' flag only, but if we overlook something now, it's going
to be difficult to fix later.

Thanks,
Rafael
