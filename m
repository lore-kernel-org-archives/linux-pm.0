From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb_id segfaulting on 2.6.23
Date: Tue, 6 Nov 2007 11:11:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711061108220.3883-100000@iolanthe.rowland.org>
References: <47308229.5010207@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47308229.5010207@gentoo.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Oliver Neukum <oneukum@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-hotplug-devel@lists.sourceforge.net, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 6 Nov 2007, Daniel Drake wrote:

> Oliver Neukum wrote:
> > Am Dienstag 06 November 2007 schrieb Daniel Drake:
> >> Oliver Neukum wrote:
> >>> Is bcdDevice present without CONFIG_SUSPEND? Which attributes are
> >>> present?
> > 
> > Looks like a failure in drivers/usb/core/sysfs.c::usb_create_sysfs_dev_files()
> > Can you put printks there to show where it fails?
> 
> Done. It fails here:
> 
> 	retval = add_power_attributes(dev);
> 	if (retval)
> 		goto error;
> 
> add_power_attributes returns -2.
> 
> Digging further, inside add_power_attributes(), the first call to 
> sysfs_add_file_to_group() returns -2. The second one is therefore not 
> attempted.

Ah, okay.  This is a known problem, a configuration-related issue.  
The PM core doesn't create a device's /sys/.../power subdirectory
unless CONFIG_PM_SLEEP is set.  In fact it should be created whenever
CONFIG_PM is set.

I haven't had time to write a patch for this yet.  Do you want to try?

Alan Stern
