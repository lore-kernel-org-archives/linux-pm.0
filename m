From: Greg KH <greg@kroah.com>
Subject: Re: problem in swsusp with usb-serial convertor attached
Date: Fri, 20 Jan 2006 10:01:23 -0800
Message-ID: <20060120180123.GA24266@kroah.com>
References: <380D9721A8E2114485644D71E87C6AB2014368BB@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20080761723172741=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB2014368BB@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============20080761723172741==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2006 at 12:30:36PM +0530, rasmit.ranjan@wipro.com wrote:
> hi,
>     In my system Linux-2.6.13.3 swsusp works properly.

Have you tried 2.6.15?  And enabled CONFIG_USB_SUSPEND?

> Now one usb-serial convertor device is attached to my system. I manually
> loaded the driver for the device and attached the device to my system.At
> this stage swsusp works properly. But my device is not in use. So resume
> works properly.
> Now i opened minicom terminal for ttyUSB0 and ttyS0 ( now my device is
> in use ) and suspend my system. My system got suspended but did not get
> resumed and showed the follwing messages on screen.
>  
> usb 1-1: USB disconnect,address 4
> usb 1-1: usb_disable_device nuking all URBs
> usb 1-1: unregistering interface 1-1:1.0
> rasmit 1-1:1.0 device disconnected
> usb 1-1:1.0 : hot plug
>  
> My device was connected to 1-1:1.0
> The driver for usb-serial convertor does not have suspend/resume
> functions.

Which usb-serial driver are you using for this device?

> Is it happening because of the driver does not handle suspend/resume or
> for any other reason ?

None of the usb-serial drivers handle suspend/resume natively, they rely
on the usb core to do a disconnect and reconnect, which will probably
cause your terminal to be disconnected, like you see.

So, I guess everything is working properly :)

thanks,

greg k-h

--===============20080761723172741==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20080761723172741==--
