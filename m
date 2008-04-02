From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 6)
Date: Wed, 2 Apr 2008 11:13:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804021104190.6272-100000__20798.4016197317$1207149377$gmane$org@iolanthe.rowland.org>
References: <200804021622.04461.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804021622.04461.oliver@neukum.org>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Apr 2008, Oliver Neukum wrote:

> We need to do something about devices that don't want to be resumed.
> There's code like this:
> 
> 
> static int usb_resume(struct device *dev)
> {
> 	struct usb_device	*udev;
> 
> 	if (!is_usb_device(dev))	/* Ignore PM for interfaces */
> 		return 0;
> 	udev = to_usb_device(dev);
> 
> 	/* If udev->skip_sys_resume is set then udev was already suspended
> 	 * when the system suspend started, so we don't want to resume
> 	 * udev during this system wakeup.  However a reset-resume counts
> 	 * as a wakeup event, so allow a reset-resume to occur if remote
> 	 * wakeup is enabled. */
> 	if (udev->skip_sys_resume) {
> 		if (!(udev->reset_resume && udev->do_remote_wakeup))
> 			return -EHOSTUNREACH;
> 	}
> 	return usb_external_resume_device(udev);
> }
> 
> Do we want to keep this in the subsystems?

Basically yes.  Subsystems and drivers are allowed to keep devices
suspended if they were suspended before the system went to sleep.  
Remember, the purpose of the resume method is to let drivers know that
the system is now awake, not to force them to put their devices into a
high-power state.

But under these circumstances we don't want to return an error code,
since nothing really went wrong in the method.  So the -EHOSTUNREACH
should be changed to 0.

Alan Stern
