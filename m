From: Greg KH <greg@kroah.com>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 11:14:03 -0700
Message-ID: <20080924181403.GA6336__37589.2358403236$1222280485$gmane$org@kroah.com>
References: <48DA64FC.4020706@gmail.com>
	<Pine.LNX.4.44L0.0809241229070.5963-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0809241229070.5963-100000@iolanthe.rowland.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 24, 2008 at 12:38:45PM -0400, Alan Stern wrote:
> On Wed, 24 Sep 2008, Jiri Slaby wrote:
> 
> > > In fact neither of those logs includes USB debugging messages.  Maybe
> > > you omitted a mkinitrd step.
> > 
> > I don't think so. I don't use neither vanilla nor initrd so this must be the
> > kernel. Anyway I recompiled with .config linked in and did
> > # dmesg >dmesg_config.hcd
> > # zcat /proc/config.gz >>dmesg_config.hcd
> > in the built kernel. The file is here:
> > http://decibel.fi.muni.cz/~xslaby/dmesg_config.hcd
> 
> Still no debugging messages.  It's because you have 
> CONFIG_DYNAMIC_PRINTK_DEBUG enabled.

If you have that enabled, you can turn on debugging "on the fly" by
writing to the debugfs file as described in the documentation for that
option.

thanks,

greg k-h
