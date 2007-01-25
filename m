From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [PATCH]switching off
	autosuspend	through sysfs
Date: Thu, 25 Jan 2007 09:32:42 -0600 (CST)
Message-ID: <200701251532.l0PFWgYN012047@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-reply-to: Greg KH's message of Wed, 24 Jan 2007 17:28:13 -0800
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: greg@kroah.com
Cc: oneukum@suse.de, gregkh@suse.de, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org


| From: Greg KH<greg@kroah.com>
| 
| ...
| > > 
| > > Would it help to add a flag somewhere in struct device (or struct
| > > dev_pm_info) for indicating that the device is not cognizant of PM?  For
| > > instance, all those USB endpoint pseudo-devices we create -- it's a waste
| > > of time to try doing power management on them and it generates a bunch of
| > > useless and distracting warning messages in the system log.
| > 
| > Yes.  In fact we should just make it a "has pm" type flag, as the
| > majority of devices do not.
| > 
| > So, what kind of devices do support these files?  I can think of:
| > 	PCI
| > 	USB
| > and that's it right now.  Do platform devices really use those files?
| 
| Something as simple as this patch perhaps?
| 
| thanks,
| 
| greg k-h
| 
| ---
|  drivers/base/power/sysfs.c |    7 +++++--
|  drivers/pci/probe.c        |    1 +
|  include/linux/device.h     |    1 +
|  3 files changed, 7 insertions(+), 2 deletions(-)
| 
| --- gregkh-2.6.orig/drivers/base/power/sysfs.c
| +++ gregkh-2.6/drivers/base/power/sysfs.c
| @@ -156,10 +156,13 @@ static struct attribute_group pm_attr_gr
|  
|  int dpm_sysfs_add(struct device * dev)
|  {
| -	return sysfs_create_group(&dev->kobj, &pm_attr_group);
| +	if (dev->supports_power)
| +		return sysfs_create_group(&dev->kobj, &pm_attr_group);
| +	return 0;
|  }
|  ...
---

Hmm - could you make it "dev->pm_aware" or "dev->supports_pm" rather
than "supports_power"?

thanks,
scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
