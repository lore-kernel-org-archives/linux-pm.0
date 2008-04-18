From: Greg KH <greg@kroah.com>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Fri, 18 Apr 2008 09:05:17 -0700
Message-ID: <20080418160517.GA9051@kroah.com>
References: <20080417222125.99e807b6.akpm@linux-foundation.org>
	<Pine.LNX.4.44L0.0804181116590.6252-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0804181116590.6252-100000@iolanthe.rowland.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 18, 2008 at 11:19:51AM -0400, Alan Stern wrote:
> On Thu, 17 Apr 2008, Andrew Morton wrote:
> 
> > But this:
> > 
> > <cold boot>
> > <suspend-to-ram>
> > <resume-from-ram>
> > <suspend-to-disk>
> > <resume-from-disk>
> > 
> > hangs at the end of resume-from-disk.
> > 
> > 
> > During the suspend-to-disk I saw:
> > 
> > ipw2200: Radio Frequency Kill Switch is On:
> > Kill switch must be turned off for wireless networking to work.
> > PM: Device usb1 failed to (unknown PM event): error -113
> > PM: Device usb2 failed to (unknown PM event): error -113
> > PM: Device usb3 failed to (unknown PM event): error -113
> > PM: Device usb4 failed to (unknown PM event): error -113
> 
> These -113 errors can be ignored.  They are fallout from the recent 
> conversion of the driver core's suspend/resume API.  Matching changes 
> have not yet been added to the USB core.

Ick, that's not good, is anyone going to at least send me a patch to
make them go away?  :)

thanks,

greg k-h
