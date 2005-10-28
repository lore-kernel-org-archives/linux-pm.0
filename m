From: "Gross, Mark" <mark.gross@intel.com>
Subject: RE: Research on device power management
Date: Fri, 28 Oct 2005 09:42:41 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470BADB2AD@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39612700336252171=="
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============39612700336252171==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Your right.  I miss spoke.  The USB bus is polled for low / speed
devices such as mice and keyboards at 1000Hz, but this is done by the
host controller or root hub.

--mgross

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Friday, October 28, 2005 9:36 AM
>To: Gross, Mark
>Cc: Holger Macht; linux-pm@lists.osdl.org
>Subject: RE: [linux-pm] Research on device power management
>
>On Fri, 28 Oct 2005, Gross, Mark wrote:
>
>> Also, I would be interested in USB mouse and wireless mouse effects
on
>> the system.  I know low speed usb devices result in a PCI interrupt
>> every msec,
>
>No they don't.  Interrupts occur only when data is transferred.
>
>On the other hand, connecting USB devices (of any speed) causes ongoing
>DMA activity, which can prevent CPUs from entering their most
power-saving
>states.
>
>Alan Stern



--===============39612700336252171==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39612700336252171==--
