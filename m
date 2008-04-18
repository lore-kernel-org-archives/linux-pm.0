From: Greg KH <greg@kroah.com>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Fri, 18 Apr 2008 09:54:11 -0700
Message-ID: <20080418165411.GA21168@kroah.com>
References: <20080418160517.GA9051@kroah.com>
	<Pine.LNX.4.44L0.0804181244230.4903-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0804181244230.4903-100000@iolanthe.rowland.org>
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

On Fri, Apr 18, 2008 at 12:45:21PM -0400, Alan Stern wrote:
> On Fri, 18 Apr 2008, Greg KH wrote:
> 
> > > These -113 errors can be ignored.  They are fallout from the recent 
> > > conversion of the driver core's suspend/resume API.  Matching changes 
> > > have not yet been added to the USB core.
> > 
> > Ick, that's not good, is anyone going to at least send me a patch to
> > make them go away?  :)
> 
> It's included in a 9-part series I'm debugging right now.  If you want, 
> I can send just that portion separately this afternoon.

No, that's fine, I can wait, just want to make sure that it is taken
care of.

thanks,

greg k-h
