From: <kaustav.majumdar@wipro.com>
Subject: RE: Query regarding behavior of PCMCIA devices with
	respect to suspend and resume
Date: Wed, 18 Jan 2006 09:09:23 +0530
Message-ID: <05B7784238A51247A0A9FB4B348CECAE014CEC64@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45055936969067556=="
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
To: linux@dominikbrodowski.net
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============45055936969067556==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi
What I want to say is that if we will be doing a large file transfer
using the USB port of the PCMCIA device, then after suspend when we will
resume whether the file transfer will be resumed or it will be starting
all over again?
Let us suppose that the controller for the USB port has the capability
to resume the transfer. But the PCMCIA client driver will release the
configuration on suspension and get a new configuration on resumption
(as in a number of PCMCIA client driver). As the controller of the USB
port will be using the resources allocated by the PCMCIA client driver
and as per my understanding, during the new configuration the resources
can be allocated anywhere in the io space (no guarantee of getting
mapped in the same region of io space where it was before suspension), I
think it will be troublesome to handle suspend/resume in the controller
for the USB port if we will do nothing extra inside PCMCIA client
driver.
And sorry for using the term HCD. Actually I was trying to say the
controller for the USB port.
Thank you,
Regards,
Kaustav Majumdar

-----Original Message-----
From: Dominik Brodowski [mailto:linux@dominikbrodowski.net] 
Sent: Wednesday, January 18, 2006 1:11 AM
To: Kaustav Majumdar (WT01 - Semiconductors & Consumer Electronics)
Cc: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] Query regarding behavior of PCMCIA devices with
respect to suspend and resume

Hi,

On Tue, Jan 17, 2006 at 06:49:11PM +0530, kaustav.majumdar@wipro.com
wrote:
> If in a PCMCIA device, there will be a USB port, then suspend/resume
can
> be or will be handled by controller for that USB port.

If that driver supports a suspend and resume method, then yes, it will
be
handled automatically as the PCMCIA subsystem is fully integrated into
the
Linux kernel device model infrastructuire.

> But I am not sure
> whether in that case, the PCMCIA client driver should support the HCD
or
> not and if yes then in what way?

What do you mean with this? What do you mean with "HCD"?

	Domninik


--===============45055936969067556==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45055936969067556==--
