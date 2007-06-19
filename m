From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Tue, 19 Jun 2007 10:20:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706191019090.3674-100000@iolanthe.rowland.org>
References: <20070619100919.GA4016@inferi.kami.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070619100919.GA4016@inferi.kami.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Jun 2007, Mattia Dongili wrote:

> > Try to enable the wakeup GPE for all the USB devices first.
> > e.g. "#echo USB1 >/proc/acpi/wakeup" will enable GPE for USB1.
> > USB1      S3     disabled  pci:0000:00:1d.0
> > USB2      S3     disabled  pci:0000:00:1d.1
> > USB3      S3     disabled  pci:0000:00:1d.2
> > USB4      S3     disabled  pci:0000:00:1d.3
> > USB7      S3     disabled  pci:0000:00:1d.7
> > 
> > Try STR and check if it resumes immediately after suspend.
> > I think the same problem will happen without this patch.
> 
> only after enabling USB7 the broken behaviour showed.
> 
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
> 
> Quite consistent with the other findings.

Just as with Raphael, I suggest you build a kernel with 
CONFIG_USB_DEBUG turned on and then post the dmesg log showing the USB 
debugging messages during the suspend and immediate resume.  To reduce 
the amount of clutter you might want to rmmod uhci-hcd before starting 
the test.

Alan Stern
