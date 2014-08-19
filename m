From: "Du, ChangbinX" <changbinx.du@intel.com>
Subject: RE: [BUG]  usb_dev_resume returns -113 due to work items queued by
 usb on pm_wq is not executed before suspending.
Date: Tue, 19 Aug 2014 10:08:35 +0000
Message-ID: <0C18FE92A7765D4EB9EE5D38D86A563A01BA8636@SHSMSX103.ccr.corp.intel.com>
References: <0C18FE92A7765D4EB9EE5D38D86A563A01BA7FD0@SHSMSX103.ccr.corp.intel.com>
 <Pine.LNX.4.44L0.1408181019470.1332-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9006 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbaHSKIo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Aug 2014 06:08:44 -0400
In-Reply-To: <Pine.LNX.4.44L0.1408181019470.1332-100000@iolanthe.rowland.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Nyman, Mathias" <mathias.nyman@intel.com>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Wu, Hao" <hao.wu@intel.com>

> Commit d6236f6d1d88 prevents the roothub resuming work item from being
> queued.
> 
> > 4) We force system suspending process aborted (by modifying code) just
> after the usb
> >   Device suspend callback is invoked.
> > 5) Then PM core will call resume callback of the usb device to recovery. On
> this step
> >   usb_dev_resume() invokes and it return -113 error. Because the
> can_submit flag of
> >   root hub is 0. Root hub resuming work item is still pending.
> 
> I still think that commit has already fixed your problem.
> 
> Alan Stern

Yes, thanks. Issue didn't reproduce after applying that patch.
