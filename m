From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] get USB suspend to work again on
	2.6.17-mm1
Date: Fri, 23 Jun 2006 08:38:57 -0700
Message-ID: <200606230838.57957.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-usb-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>, pavel@suse.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 7:51 am, Alan Stern wrote:

> Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> it because it doesn't need them, or is it because nobody has written them 
> yet?  In the latter case, failing the suspend or unbinding the driver are 
> the only safe courses.

I think the former would ba a dangerous assumption ... in the category
of "intermittent bugs triggering later on" rather than "easily reproduced
bugs triggering right at the trouble spot" (like the latter).

- Dave

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
