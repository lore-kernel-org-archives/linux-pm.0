From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sun, 16 Aug 2009 11:57:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908161151020.6522-100000__36707.3244801306$1250438413$gmane$org@netrider.rowland.org>
References: <200908152321.53283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

On Sat, 15 Aug 2009, Rafael J. Wysocki wrote:

> > Why would you ever want runtime_wakeup to be false unless 
> > runtime_forbidden is true? Surely the point of runtime power management 
> > is to be transparent to the user, in which case remote wakeup is 
> > required?

Matthew, what makes you think remote wakeup is required?  Lots of
power-manageable devices don't support it at all (consider disk drives
or display screens).

> Well, this was exactly my point previously. :-)
> 
> Still, although for the majority of devices 'runtime_wakeup' disabled would
> mean no runtime PM at all IMO, there may be devices that actually work without
> remote wakeup, although they support it in general.

That last part is quite true.  For example, we might suspend the device
whenever no process has opened the device file.  It would be a degraded 
form of power management, but better than nothing.

> I can even imagine a scenario where this setting might be useful, like when
> we don't want a network adapter to be woken up from the outside.

Or if the device's support for remote wakeup is broken.

Alan Stern
