From: <kaustav.majumdar@wipro.com>
Subject: RE: Behavior of PCMCIA based HCD in the event of SUSPEND
Date: Wed, 19 Apr 2006 10:32:30 +0530
Message-ID: <05B7784238A51247A0A9FB4B348CECAE01A2B646@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49196123368153172=="
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
To: linux@dominikbrodowski.net, stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============49196123368153172==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit


-----Original Message-----
From: Dominik Brodowski [mailto:linux@dominikbrodowski.net] 
Sent: Tuesday, April 18, 2006 8:08 PM
To: Alan Stern
Cc: Kaustav Majumdar (WT01 - Semiconductors & Consumer Electronics);
linux-pm@lists.osdl.org; linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-pm] Behavior of PCMCIA based HCD in the event of
SUSPEND

> On Tue, Apr 18, 2006 at 09:45:50AM -0400, Alan Stern wrote:
>> On Tue, 18 Apr 2006 kaustav.majumdar@wipro.com wrote:
>>> Also the PCMCIA subsystem's behavior is to power off the socket
>>> irrespective of whether the PCMCIA client driver has successfully
>>> handled the SUSPEND event or not.
>> 
>> I don't know how the PCMCIA subsystem works.  If it behaves the way
you 
>> described then it is broken and should be fixed.
>
> At least with latest 2.6.17-rc1, if the PCMCIA driver returns an error
in
> its suspend function, this error is passed to the PM layer which
should     > stop
> the suspend-to-?-path. If you're calling "pccardctl suspend", the
PCMCIA
> layer itself checks for this error AFAICS.

Actually we are developing the driver using 2.6.15.4 kernel. What I had
written is based upon the ds.c code in that kernel.
May be later it was fixed.

>	Dominik


--===============49196123368153172==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49196123368153172==--
