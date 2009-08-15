From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sat, 15 Aug 2009 22:27:56 +0100
Message-ID: <20090815212756.GA31784__20877.666216302$1250371753$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0908151143560.18415-100000@netrider.rowland.org>
	<200908152254.23227.rjw@sisk.pl>
	<20090815205817.GA30254@srcf.ucam.org>
	<200908152321.53283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908152321.53283.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 15, 2009 at 11:21:53PM +0200, Rafael J. Wysocki wrote:

> I can even imagine a scenario where this setting might be useful, like when
> we don't want a network adapter to be woken up from the outside.

I think in that case we'd probably just want the interface to be downed? 
Some of this is going to require device-specific policy, I think - for 
the network case we probably want something in between IF_RUNNING and 
IF_DOWN (IF_CARRIER, perhaps) that indicates that we want the PHY to be 
powered. Pushing this out to sysfs would mean we'd have a consistent 
interface but varying semantics, and I'm not convinced that's an 
especially helpful interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
