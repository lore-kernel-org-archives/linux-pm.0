From: <kaustav.majumdar@wipro.com>
Subject: Query regarding behavior of PCMCIA devices with respect
	to suspend and resume
Date: Tue, 17 Jan 2006 14:12:20 +0530
Message-ID: <05B7784238A51247A0A9FB4B348CECAE014CEACE@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15644151003122664=="
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============15644151003122664==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi all,

I am new to linux power management.... I had seen some PCMCIA client
drivers, where in the event handler for events CARD_SUSPEND and
CARD_RESUME nothing generic had been done but those events ultimately
causes release and get configuration only.....
So does that mean the expected behavior from any PCMCIA device in case
of suspend/resume activity is to release its configurations on
suspension and getting new configuration without actually resuming the
task the device was performing at the time of suspension???
I am looking forward to any kind of suggestion regarding the doubt. And
please reply in my mail id too as I am not subscribed to the list.
Thank you, 
Regards,
Kaustav Majumdar


--===============15644151003122664==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15644151003122664==--
