From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC] usb: Add support for runtime power
	management	of the hcd
Date: Thu, 13 Aug 2009 22:42:19 +0100
Message-ID: <20090813214219.GB14532__30431.1506603428$1250199884$gmane$org@srcf.ucam.org>
References: <200908081625.57333.rjw@sisk.pl>
	<200908131416.42189.oliver@neukum.org>
	<20090813123034.GA25770@srcf.ucam.org>
	<200908131626.33891.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908131626.33891.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 13, 2009 at 04:26:33PM +0200, Oliver Neukum wrote:
> Am Donnerstag, 13. August 2009 14:30:34 schrieb Matthew Garrett:
> > > Your earlier failures don't look promising regarding BIOSes.
> > > What do you have in mind?
> >
> > They range from pragmatic to ugly. We could blacklist all Dells, though
> > I'm trying to find out if there's a BIOS date that guarantees the system
> > is fixed. Alternatively, it's a single-line bug in the DSDT - we could
> > implement some kind of fixup in the ACPI parsing code. I find the latter
> > interesting but possibly too hideous to live :)
> 
> Is there any indication only those BIOSes are affected?

Based on what I've looked at, other BIOSes either indicate that they 
don't support this or should work properly. Real life may disagree.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
