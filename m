From: <rasmit.ranjan@wipro.com>
Subject: Suspending usb function of PCMCIA multi-functional card
Date: Fri, 21 Apr 2006 18:30:21 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201BB4772@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89343510939335236=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============89343510939335236==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi all,
    I have a PCMCIA multi functional card hosting a usb and a serial
port.
The device tree for the usb is as follows:
    
 /sys/bus/pcmcia/devices/1-1/hcd/usb5/5-0:1.0/...............

1-1 represents usb functionality of my PCMCIA card connected to socket
no1. Similarlly my serial port will be listed as 1-0.

Now when I suspend 1-1 without suspening any down stream devices, it
allows me to do. I mean, the content of the .../power/state file is
changed to 3. Which means my usb_generic_suspend is not getting called
otherwise it would have failed. Also PCMCIA client driver is notified of
this suspend. I did not find any noticeable changes by suspending 1-1.

Then how this suspend is handled ? As the content of the power state
file is changed, means power management is marking the node(1-1) as
suspended. Then which function does this ?
Is it landed any where in HCD ?  
Please suggest.

Thanks and regards,
Rasmit. 
 


--===============89343510939335236==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89343510939335236==--
