From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: The evilness of struct usb_device->auto_pm
Date: Thu, 27 Sep 2007 12:05:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709271202150.7735-100000__41128.9021409631$1190909304$gmane$org@iolanthe.rowland.org>
References: <200709271356.28884.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709271356.28884.oliver@neukum.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Sep 2007, Oliver Neukum wrote:

> Hi,
> 
> doing autosuspend for the storage driver, this feature was a sore point.
> At some point we have to cross subsystem borders when doing runtime
> suspend on a subtree of the device tree. Drivers need to know whether
> they are doing a system wide suspend or a runtime suspend. The locking
> requirements at the very least are different.
> We need a standardised way to tell drivers what kind of suspension they
> are dealing with. So I think it has to move into the generic struct device
> or become a part of the message parameter.

If it goes anywhere, it ought to be in the message parameter.  My
reason for putting it in struct usb_device originally was because there
was no other choice at the time.

But there's a problem, in that the resume methods don't take a message 
parameter.  So they wouldn't know whether they were doing a runtime 
resume or a system resume.

Alan Stern
