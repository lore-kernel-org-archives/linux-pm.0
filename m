From: Sriram V <vshrirama@gmail.com>
Subject: Question on USB re-enumeration
Date: Sun, 15 Nov 2009 14:30:07 +0530
Message-ID: <8bf247760911150100i15434810r7be8e1c03f78c7f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0643424857160034671=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============0643424857160034671==
Content-Type: multipart/alternative; boundary=000e0cd32f549aad9a0478651e7d

--000e0cd32f549aad9a0478651e7d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have a couple of questions of re-enumeration of usb devices on
suspend-resume

I have a USB Device permanently connected to the host controller.

Upon resume - Should i usb device get re-enumerated?
If so, does Linux choose a different address for accessing it?

If i have a USB harddisk, I am accessing it using a device node say
/dev/sdb1
The harddisk is mounted as /dev/sdb1.

Now, i go into suspend and then resume - If i need to re-enumerate the
devices
It could be detected as /dev/sdc1... or something.

If that is the case i cannot access my harddisk - since im assuming
/dev/sdb1.

What im seeing here is - My usb device is permanently connected to the usb
host via an external phy.

 When i suspend - i turn off the clocks and upon resume - turn on the clocks
and reset the phy.

 For some time - i am able to access the device, What happens is - The
device gets re-enumerated to some other device node.

I am not sure if this is a device issue or a resume function issue.


Please advice.


Regards,
sriram

--000e0cd32f549aad9a0478651e7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have a couple of questions of re-enumeration of usb devices on=
 suspend-resume<br><br>I have a USB Device permanently connected to the hos=
t controller.<br><br>Upon resume - Should i usb device get re-enumerated?<b=
r>
If so, does Linux choose a different address for accessing it?<br><br>If i =
have a USB harddisk, I am accessing it using a device node say /dev/sdb1<br=
>The harddisk is mounted as /dev/sdb1.<br><br>Now, i go into suspend and th=
en resume - If i need to re-enumerate the devices<br>
It could be detected as /dev/sdc1... or something.<br><br>If that is the ca=
se i cannot access my harddisk - since im assuming /dev/sdb1.<br><br>What i=
m seeing here is - My usb device is permanently connected to the usb host v=
ia an external phy.<br>
=A0<br>=A0When i suspend - i turn off the clocks and upon resume - turn on =
the clocks and reset the phy.<br><br>=A0For some time - i am able to access=
 the device, What happens is - The device gets re-enumerated to some other =
device node.<br>
<br>I am not sure if this is a device issue or a resume function issue.<br>=
<br><br>Please advice.<br><br><br>Regards,<br>sriram<br><br><br><br><br><br=
><br><br><br><br><br>

--000e0cd32f549aad9a0478651e7d--

--===============0643424857160034671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0643424857160034671==--
