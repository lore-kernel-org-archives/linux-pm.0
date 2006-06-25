From: Jim Gettys <jg@laptop.org>
Subject: Re: [linux-pm] [PATCH] get USB suspend to work
	again on 2.6.17-mm1
Date: Sat, 24 Jun 2006 22:42:57 -0400
Message-ID: <1151203377.15365.389.camel@localhost.localdomain>
References: <20060622202952.GA14135@kroah.com>
	<200606221624.03182.david-b@pacbell.net>
	<20060622235112.GA30484@kroah.com>
	<200606222034.44085.david-b@pacbell.net>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200606222034.44085.david-b@pacbell.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@osdl.org, linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-06-22 at 20:34 -0700, David Brownell wrote:

> Under what scenario could it possibly be legitimate to suspend a
> usb device -- or interface, or anything else -- with its children
> remaining active?  The ability to guarantee that could _never_ happen
> was one of the fundamental motivations for the driver model ...
> 

I'm not sure this directly applies, but....

The Marvell wireless chip we're using this generation in the OLPC
machine is interfaced via USB.  Not ideal, but there's no other game in
town to let us keep the mesh network up while the main machine is STR.

We intend to leave the Marvell chip on (it can forward packets in the
mesh network, and/or wake up the CPU if there are inbound packets for
the machine that matter), and turn off the USB interface it is attached
to.
                        Regards,
                             - Jim

-- 
Jim Gettys
One Laptop Per Child



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
