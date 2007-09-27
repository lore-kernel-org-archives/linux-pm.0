From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: The evilness of struct usb_device->auto_pm
Date: Thu, 27 Sep 2007 21:44:59 +0200
Message-ID: <200709272145.00092.rjw__42853.5080202439$1190921608$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0709271202150.7735-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0709271202150.7735-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thursday, 27 September 2007 18:05, Alan Stern wrote:
> On Thu, 27 Sep 2007, Oliver Neukum wrote:
> 
> > Hi,
> > 
> > doing autosuspend for the storage driver, this feature was a sore point.
> > At some point we have to cross subsystem borders when doing runtime
> > suspend on a subtree of the device tree. Drivers need to know whether
> > they are doing a system wide suspend or a runtime suspend. The locking
> > requirements at the very least are different.
> > We need a standardised way to tell drivers what kind of suspension they
> > are dealing with. So I think it has to move into the generic struct device
> > or become a part of the message parameter.
> 
> If it goes anywhere, it ought to be in the message parameter.  My
> reason for putting it in struct usb_device originally was because there
> was no other choice at the time.
> 
> But there's a problem, in that the resume methods don't take a message 
> parameter.  So they wouldn't know whether they were doing a runtime 
> resume or a system resume.

This is a general problem with the .resume() routines.

If you want to use one for runtime resume, the driver needs to preserve
information allowing it to figure out what kind of resume is going to happen.

Greetings,
Rafael
