From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 23:21:57 +0100
Message-ID: <20090814222157.GA20015__31566.4810398177$1250288593$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0908141032070.2987-100000@iolanthe.rowland.org>
	<200908142205.20093.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908142205.20093.rjw@sisk.pl>
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

On Fri, Aug 14, 2009 at 10:05:19PM +0200, Rafael J. Wysocki wrote:

> Well, sometimes the user may want a device to be power managed at run time
> and not to be able to wake up the system from sleep states.  For example,
> I'd like the USB controller in my box to be suspended at run time whenever it's
> not used, but surely I wouldn't like it to do system-wide wakeup, because it
> does that when I move the mouse which is a cordless one.  Simply turning the
> mouse on causes the system to wake up. :-)

Right, so clearly my code is broken right now.

> Why don't we add a flag indicating whether or not the device is allowed to
> be power managed at run time, something like runtime_forbidden, that the
> user space will be able to set through sysfs?

I think even having a runtime_wakeup flag (which defaults to on) would 
be sufficient. If the worst case is scenario is that we have to resume 
devices in order to apply the correct policy when going into a 
systemwide suspend state, I think that's acceptable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
