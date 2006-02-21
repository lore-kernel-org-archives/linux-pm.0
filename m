From: <kaustav.majumdar@wipro.com>
Subject: Regarding multifunction PC Card power management
Date: Tue, 21 Feb 2006 14:30:47 +0530
Message-ID: <05B7784238A51247A0A9FB4B348CECAE016F0581@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============026300039407713083=="
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
To: linux-pcmcia@lists.infradead.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============026300039407713083==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi all,

I had noted from the Linux 2.6 PCMCIA mini Howto that

pccardctl suspend  <---->  echo -n 3 >
/sys/class/pcmcia-socket/pcmcia-socket*/device/power/state

where * is socket number 0 or like that.

and on doing so, we are getting the PM_SUSPEND event in the pcmcia
client driver and the card is powered off. So it is working absolutely
fine.

But I had found inside
/sys/class/pcmcia_socket/pcmcia_socket*/device/*-0 directory which I
think represents the function of the card, which is always 0 in case of
a single function card. 

I had tried 
echo -n 3 > /sys/class/pcmcia_socket/pcmcia_socket*/*-0/power/state

but had not got any event inside the PCMCIA client driver's event
handler, whereas I think we should get a PM_SUSPEND event in the event
handler.

As per as my understanding, if the
/sys/class/pcmcia_socket/pcmcia_socket*/*-0/ represents the function 0
of the card, then for a multifunction card we will have *-0/ and *-1/
directories, representing the function0 and function 1. And by "echo"ing
3 in the power/state of the function representing directories, we should
be able to suspend a specific function (function 0 or function 1) of the
card.

I want to validate my understanding. Thank you in advance for any
suggestion.

Thank you,
With Regards,
Kaustav Majumdar


--===============026300039407713083==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============026300039407713083==--
