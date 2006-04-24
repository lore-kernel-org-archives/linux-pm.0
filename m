From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Mon, 24 Apr 2006 15:47:37 -0700
Message-ID: <200604241547.38692.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net> <200604242347.36257.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604242347.36257.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Monday 24 April 2006 2:47 pm, Rafael J. Wysocki wrote:
> 
> I agree with this change but I think it'll cause some strange things to happen
> for some time.

Let's see.  :)  I think it's less likely to be drivers with broken
shutdown() callbacks than drivers which are missing them.

Plus, one of the main reasons that driver suspend/resume handling
is _still_ so goofy is that most drivers are stupid, and just reinit
devices from scratch in their resume() methods.  Drivers like that
should not notice any difference.  :)

- Dave



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
