From: Mattia Dongili <malattia@linux.it>
Subject: Re: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Wed, 20 Jun 2007 23:45:33 +0900
Message-ID: <20070620144532.GA3761__581.480938899581$1182350834$gmane$org@inferi.kami.home>
References: <200706191326.10320.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0706191019090.3674-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0706191019090.3674-100000@iolanthe.rowland.org>
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
Cc: linux-acpi@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2007 at 10:20:32AM -0400, Alan Stern wrote:
> On Tue, 19 Jun 2007, Mattia Dongili wrote:
> 
> > > Try to enable the wakeup GPE for all the USB devices first.
> > > e.g. "#echo USB1 >/proc/acpi/wakeup" will enable GPE for USB1.
> > > USB1      S3     disabled  pci:0000:00:1d.0
> > > USB2      S3     disabled  pci:0000:00:1d.1
> > > USB3      S3     disabled  pci:0000:00:1d.2
> > > USB4      S3     disabled  pci:0000:00:1d.3
> > > USB7      S3     disabled  pci:0000:00:1d.7
> > > 
> > > Try STR and check if it resumes immediately after suspend.
> > > I think the same problem will happen without this patch.
> > 
> > only after enabling USB7 the broken behaviour showed.
> > 
> > 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
> > 
> > Quite consistent with the other findings.
> 
> Just as with Raphael, I suggest you build a kernel with 
> CONFIG_USB_DEBUG turned on and then post the dmesg log showing the USB 
> debugging messages during the suspend and immediate resume.  To reduce 
> the amount of clutter you might want to rmmod uhci-hcd before starting 
> the test.

here we go:
http://www.linux.it/~malattia/logs/dmesg-suspend-ehci-debug-log

and by the way:
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)

with ehci only:
Bus 005 Device 007: ID 054c:0281 Sony Corp. 
Bus 005 Device 004: ID 05ca:1830 Ricoh Co., Ltd 
Bus 005 Device 001: ID 0000:0000  

-- 
mattia
:wq!
