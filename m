From: <kaustav.majumdar@wipro.com>
Subject: power management for pcmcia based USB hc driver
Date: Tue, 21 Feb 2006 15:42:59 +0530
Message-ID: <05B7784238A51247A0A9FB4B348CECAE016F05CE@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13069861725741294=="
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

--===============13069861725741294==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi all,

We are facing an issue regarding power management of a PCMCIA based USB
Host Controller driver. 

When we are issuing the command "echo -n "3" >
/sys/class/pcmcia-socket/pcmcia-socket1/device/power/state" from the
command line (the PC Card was in socket 1), we received the "PM_SUSPEND"
event in the event handler of the PCMCIA client driver. On getting that,
inside the client driver, we are releasing the configuration by calling
pcmcia_release_configuration.

When we debugged the code, we noted that though we are getting suspend
event in the pcmcia client driver, the suspend entry points in the hc
driver are not being called.

So from that I think a mechanism is needed to communicate this event to
the hc driver. One possible solution is to set a variable in the PCMCIA
client driver on suspend and polling that variable from the hc driver.

Pl. suggest a better solution. Looking forward to your suggestions.

Thank you,
With Regards,
Kaustav Majumdar


--===============13069861725741294==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============13069861725741294==--
