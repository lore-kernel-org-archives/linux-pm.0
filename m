From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Mon, 24 Apr 2006 23:47:35 +0200
Message-ID: <200604242347.36257.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604241429.52022.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday 24 April 2006 23:29, David Brownell wrote:
> I've noticed a bunch of problem reports that go like this:
> 
>  - boot system with some USB devices attached
>  - echo disk > /sys/power/state
>  - ... later resume ...
>  - now those USB devices don't work right
>  - unplug them/replug them, all is OK
> 
> I recently observed this myself and tracked down one problem.  The solution
> involves what kexec() does in much the same situation:  before starting a
> new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
> instead, which is the root cause of the problem.
> 
> This seems like something that might need to sit in the MM tree for
> a while, as it's a longstanding bug and the fix could shake loose driver
> goofs.  Luckily there's a partial workaround already in wide use:  link
> drivers as modules if they use true suspend states (like all USB HCDs),
> don't link them statically into the kernel image.
> 
> That workaround is partial because when BIOS takes over a controller, the
> resume() method has to handle that nasty case too!  Last I checked, all
> the USB HCDs do handle that case; and few drivers other than those HCDs
> would ever need to worry about such issues.

I agree with this change but I think it'll cause some strange things to happen
for some time.

Greetings,
Rafael


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
