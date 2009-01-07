From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Wed, 7 Jan 2009 19:11:40 +0100
Message-ID: <200901071911.41094.rjw@sisk.pl>
References: <736164.14603.qm@web36804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <736164.14603.qm@web36804.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, dqarras@yahoo.com
List-Id: linux-pm@vger.kernel.org

On Wednesday 07 January 2009, Daniel Qarras wrote:
> Hi!
> 
> > Apparently, one of devices is set up to wake up the system
> > and it does that right after it's been put to sleep.  I don't think
> > it's a PCI device, because 2.6.28 prevents PCI devices from doing this,
> > unless they are intentionally set up for system wake-up.
> > 
> > Can you send me the output of /proc/acpi/wakeup, please?
> 
> Sure, please see below:
> 
> localhost:~> cat /proc/acpi/wakeup 
> Device	S-state	  Status   Sysfs node
> RP01	  S4	 disabled  pci:0000:00:1c.0
> RP02	  S4	 disabled  pci:0000:00:1c.1
> RP04	  S4	 disabled  
> USB1	  S3	 disabled  pci:0000:00:1d.0
> USB2	  S3	 disabled  pci:0000:00:1d.1
> USB3	  S3	 disabled  pci:0000:00:1d.2
> USB4	  S3	 disabled  pci:0000:00:1d.3
> USB7	  S3	 disabled  pci:0000:00:1d.7
> LANC	  S4	 disabled  pci:0000:06:08.0
> MODM	  S3	 disabled  pci:0000:00:1e.3
> localhost:~> 

OK, thanks.

Can you try to unload the USB controller drivers before hibernation and see
what happens?

Rafael
