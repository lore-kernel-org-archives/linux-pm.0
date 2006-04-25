From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Tue, 25 Apr 2006 22:53:18 +0200
Message-ID: <200604252253.19130.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net> <200604252056.56534.rjw@sisk.pl> <200604260628.41003.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604260628.41003.nigel@suspend2.net>
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
To: Nigel Cunningham <nigel@suspend2.net>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 25 April 2006 22:28, Nigel Cunningham wrote:
> On Wednesday 26 April 2006 04:56, Rafael J. Wysocki wrote:
> > You're saying that (9) is wrong, so could you please suggest what to do
> > instead of it?
> 
> 'scuse me for butting in, but here's my suggested modified version:
> 
> > Well, suppose we have a modular driver that's not loaded before resume.
> > Then it goes like that (approximately):
> > (1) We activate swsusp which calls .suspend() for all devices including our
> > driver (this is a real suspend).
> > (2) swsusp snapshots the system and creates the image.
> > (3) swsusp calls .resume() for all devices in order to be able to save the
> > image (.resume() for our driver is also called which is OK).
> > (4) swsusp turns off the system.
> > (5) (some time later) We start a new kernel and tell it to resume.
> > (6) It activates swsusp which reads the image.
> > (7) (without your change) swsusp calls .suspend() for all device drivers
> > that are present at that time, but our driver is not there, so its
> > .suspend() _won't_ be called.  [Of course with your change .suspend() won't
> > be called for any driver.]
> 
> We also make a list that is safely available after the atomic restore of 
> drivers that have had .suspend methods called.

Do you mean we place the list in a __nosave area?

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
