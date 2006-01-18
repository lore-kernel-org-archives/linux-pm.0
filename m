From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: Query regarding behavior of PCMCIA devices with
	respect to suspend and resume
Date: Wed, 18 Jan 2006 10:20:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601181007260.5567-100000@iolanthe.rowland.org>
References: <05B7784238A51247A0A9FB4B348CECAE014CEC64@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72194287114610711=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE014CEC64@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: kaustav.majumdar@wipro.com
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

--===============72194287114610711==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 18 Jan 2006 kaustav.majumdar@wipro.com wrote:

> Hi
> What I want to say is that if we will be doing a large file transfer
> using the USB port of the PCMCIA device, then after suspend when we will
> resume whether the file transfer will be resumed or it will be starting
> all over again?
> Let us suppose that the controller for the USB port has the capability
> to resume the transfer. But the PCMCIA client driver will release the
> configuration on suspension and get a new configuration on resumption
> (as in a number of PCMCIA client driver). As the controller of the USB
> port will be using the resources allocated by the PCMCIA client driver
> and as per my understanding, during the new configuration the resources
> can be allocated anywhere in the io space (no guarantee of getting
> mapped in the same region of io space where it was before suspension), I
> think it will be troublesome to handle suspend/resume in the controller
> for the USB port if we will do nothing extra inside PCMCIA client
> driver.

This question should be posted on linux-usb-devel, since it's really 
asking about the behavior of USB host controller drivers.

Right now, the only USB host controller with a PCMCIA driver is sl811,
so you should also CC: the author of the sl811_cs.c file.

Alan Stern


--===============72194287114610711==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72194287114610711==--
