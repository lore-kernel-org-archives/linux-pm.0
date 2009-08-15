From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sat, 15 Aug 2009 23:21:53 +0200
Message-ID: <200908152321.53283.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908151143560.18415-100000@netrider.rowland.org>
	<200908152254.23227.rjw@sisk.pl>
	<20090815205817.GA30254@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090815205817.GA30254@srcf.ucam.org>
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
> On Sat, Aug 15, 2009 at 10:54:23PM +0200, Rafael J. Wysocki wrote:
> 
> > runtime_wakeup - if set, the device is allowed to do remote wakeup at run time
> >   That could be represented as 'runtime_wakeup' under 'power' with the
> >   following values:
> >   * no value (empty file) is 'runtime' is 'disabled'
> >   * 'enabled'
> >   * 'disabled'
> >   To set/unset the user space writes 'enabled'/'disabled' to it, respectively.
> >   The default is set.
> 
> Why would you ever want runtime_wakeup to be false unless 
> runtime_forbidden is true? Surely the point of runtime power management 
> is to be transparent to the user, in which case remote wakeup is 
> required?

Well, this was exactly my point previously. :-)

Still, although for the majority of devices 'runtime_wakeup' disabled would
mean no runtime PM at all IMO, there may be devices that actually work without
remote wakeup, although they support it in general.

I can even imagine a scenario where this setting might be useful, like when
we don't want a network adapter to be woken up from the outside.

Thanks,
Rafael
