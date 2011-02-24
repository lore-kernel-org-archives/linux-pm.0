From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [Bug 29802] New: [REGRESSION 2.6.38-rc1+] bisected
 to: USB: use the no_callbacks flag for interfaces
Date: Thu, 24 Feb 2011 19:09:16 +0800
Message-ID: <AANLkTikcfYvw0ztFUBwkLK+wqPjNYyVRgUsZ3mJVb5fi__29466.1519852982$1298545830$gmane$org@mail.gmail.com>
References: <bug-29802-11382@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd5174c8f3317049d053efa
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <bug-29802-11382@https.bugzilla.kernel.org/>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bettiah@gmail.com
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, linux-usb <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--000e0cd5174c8f3317049d053efa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi bettiah,

2011/2/24  <bugzilla-daemon@bugzilla.kernel.org>:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D29802
>
> =A0 =A0 =A0 =A0 =A0 Summary: [REGRESSION 2.6.38-rc1+] bisected to: USB: u=
se the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0no_callbacks flag for interfaces
> =A0 =A0 =A0 =A0 =A0 Product: Power Management
> =A0 =A0 =A0 =A0 =A0 Version: 2.5
> =A0 =A0Kernel Version: 2.6.38-rc6
> =A0 =A0 =A0 =A0 =A0Platform: All
> =A0 =A0 =A0 =A0OS/Version: Linux
> =A0 =A0 =A0 =A0 =A0 =A0 =A0Tree: Mainline
> =A0 =A0 =A0 =A0 =A0 =A0Status: NEW
> =A0 =A0 =A0 =A0 =A0Severity: normal
> =A0 =A0 =A0 =A0 =A0Priority: P1
> =A0 =A0 =A0 =A0 Component: Other
> =A0 =A0 =A0 =A0AssignedTo: power-management_other@kernel-bugs.osdl.org
> =A0 =A0 =A0 =A0ReportedBy: bettiah@gmail.com
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC: tom.leiming@gmail.com
> =A0 =A0 =A0 =A0Regression: Yes
>
>
> On an embedded system, (beagleboard using Asix CONFIG_USB_NET_AX8817X
> statically compiled, =A0usb/ethernet bridge, rootfs over nfs), =A0:
>
> [ =A0 =A06.817382] usb 1-2.4: new high speed USB device using ehci-omap a=
nd address
> 3
> [ =A0 =A06.940979] usb 1-2.4: rpm_resume flags 0x0
> [ =A0 =A06.945373] usb 1-2.4: rpm_resume returns 1
> [ =A0 =A06.961700] usb 1-2.4: New USB device found, idVendor=3D0b95, idPr=
oduct=3D772a
> [ =A0 =A06.968963] usb 1-2.4: New USB device strings: Mfr=3D1, Product=3D=
2,
> SerialNumber=3D3
> [ =A0 =A06.976684] usb 1-2.4: Product: AX88772
> [ =A0 =A06.980834] usb 1-2.4: Manufacturer: ASIX Elec. Corp.
> [ =A0 =A06.986145] usb 1-2.4: SerialNumber: 000065
> [ =A0 =A06.996917] usb 1-2.4: rpm_resume flags 0x4
> [ =A0 =A07.001312] usb 1-2.4: rpm_resume returns 1
> [ =A0 =A07.007507] usb 1-2.4: rpm_resume flags 0x4
> [ =A0 =A07.011901] usb 1-2.4: rpm_resume returns 1
> [ =A0 =A07.040679] mmc0: new SD card at address 9ffc
> [ =A0 =A07.049255] mmcblk0: mmc0:9ffc SD01G 968 MiB
> [ =A0 =A07.061950] =A0mmcblk0: p1 p2
> [ =A0 =A07.259307] usb usb2: rpm_suspend flags 0x9
> [ =A0 =A07.263732] usb usb2: rpm_suspend returns 0
> [ =A0 =A07.268310] usb usb2: rpm_suspend flags 0xa
> [ =A0 =A07.272735] usb usb2: rpm_suspend returns 0
> [ =A0 =A07.945953] asix 1-2.4:1.0: eth0: register 'asix' at usb-ehci-omap=
.0-2.4,
> ASIX AX88772 USB
> 2.0 Ethernet, 00:00:00:00:00:65
> [ =A0 =A07.957794] asix 1-2.4:1.0: rpm_suspend flags 0x4
> [ =A0 =A07.962738] asix 1-2.4:1.0: rpm_suspend returns 0
> [ =A0 =A07.967956] hub 1-2:1.0: rpm_resume flags 0x4
> [ =A0 =A07.972534] hub 1-2:1.0: rpm_resume returns 1
> [ =A0 =A07.977386] hub 1-2:1.0: rpm_suspend flags 0x4
> [ =A0 =A07.982055] hub 1-2:1.0: rpm_suspend returns 0
> [ =A0 =A08.333007] asix 1-2.4:1.0: rpm_resume flags 0x4
> [ =A0 =A08.337890] asix 1-2.4:1.0: rpm_resume returns 0
> [ =A0 =A08.343933] eth0: link down
> [ =A0 =A09.368652] Sending DHCP requests .
> [ =A0 =A09.949462] asix 1-2.4:1.0: rpm_resume flags 0x4
> [ =A0 =A09.954498] asix 1-2.4:1.0: rpm_resume returns 1
> [ =A0 =A09.961425] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> [ =A0 12.134307] .
> [ =A0 12.135864] asix 1-2.4:1.0: rpm_resume flags 0x5
> [ =A0 12.140869] asix 1-2.4:1.0: rpm_resume returns 1
> [ =A0 12.649963] ,
> [ =A0 12.651489] asix 1-2.4:1.0: rpm_resume flags 0x5
> [ =A0 12.656524] asix 1-2.4:1.0: rpm_resume returns 1
> [ =A0 12.665618] =A0OK
> [ =A0 12.667480] IP-Config: Got DHCP answer from 0.0.0.0, my address is
> 192.168.1.102
> [ =A0 12.678771] IP-Config: Complete:
> [ =A0 12.682250] =A0 =A0 =A0device=3Deth0, addr=3D192.168.1.102, mask=3D2=
55.255.255.0,
> gw=3D192.168.1.1,
> [ =A0 12.690246] =A0 =A0 =A0host=3D192.168.1.102, domain=3D, nis-domain=
=3D(none),
> [ =A0 12.696533] =A0 =A0 =A0bootserver=3D0.0.0.0, rootserver=3D192.168.1.=
106, rootpath=3D,
> mtu=3D576
> [ =A0 12.715637] asix 1-2.4:1.0: rpm_resume flags 0x5
> [ =A0 12.720489] asix 1-2.4:1.0: rpm_resume returns 1
> [ =A0 12.725830] asix 1-2.4:1.0: rpm_resume flags 0x5
> [ =A0 12.730651] asix 1-2.4:1.0: rpm_resume returns 1
> [ =A0 12.742034] asix 1-2.4:1.0: rpm_resume flags 0x5
> [ =A0 12.746887] asix 1-2.4:1.0: rpm_resume returns 1
> [ =A0 12.752075] asix 1-2.4:1.0: rpm_resume flags 0x5
> [ =A0 12.756927] asix 1-2.4:1.0: rpm_resume returns 1

>From the debug messages above, seems all is OK, and
runtime pm does work well.

The commit 63defa73c8c1193c1273474440c30d34c2524597

        USB: use the no_callbacks flag for interfaces

you bisected may cause more messages above dumped out
than before.

If you want to see less runtime pm messages, please disable
CONFIG_PM_DEBUG.

Or you can try the attachment patch to see if less 'rpm_resume'
messages will be dumped out, but let Alan decide if it should
be taken.  This part in the commit was added by Alan.

thanks,
--=20
Lei Ming

--000e0cd5174c8f3317049d053efa
Content-Type: text/x-patch; charset=US-ASCII; name="rpm_resume.patch"
Content-Disposition: attachment; filename="rpm_resume.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkjki0ez0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvZHJpdmVyLmMgYi9kcml2ZXJzL3VzYi9jb3Jl
L2RyaXZlci5jCmluZGV4IGZjYTYxNzIuLmQ5MzNmNzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNi
L2NvcmUvZHJpdmVyLmMKKysrIGIvZHJpdmVycy91c2IvY29yZS9kcml2ZXIuYwpAQCAtMTU2NCw5
ICsxNTY0LDE4IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHVzYl9hdXRvcG1fZ2V0X2ludGVyZmFjZSk7
CiAgKi8KIGludCB1c2JfYXV0b3BtX2dldF9pbnRlcmZhY2VfYXN5bmMoc3RydWN0IHVzYl9pbnRl
cmZhY2UgKmludGYpCiB7Ci0JaW50CXN0YXR1czsKKwlpbnQgICAgICAgICAgICAgc3RhdHVzID0g
MDsKKwllbnVtIHJwbV9zdGF0dXMgczsKKworCS8qIERvbid0IHJlcXVlc3QgYSByZXN1bWUgdW5s
ZXNzIHRoZSBpbnRlcmZhY2UgaXMgYWxyZWFkeSBzdXNwZW5kaW5nCisJICogb3Igc3VzcGVuZGVk
LiAgRG9pbmcgc28gd291bGQgZm9yY2UgYSBydW5uaW5nIHN1c3BlbmQgdGltZXIgdG8gYmUKKwkg
KiBjYW5jZWxsZWQuCisJICovCisJcG1fcnVudGltZV9nZXRfbm9yZXN1bWUoJmludGYtPmRldik7
CisJcyA9IEFDQ0VTU19PTkNFKGludGYtPmRldi5wb3dlci5ydW50aW1lX3N0YXR1cyk7CisJaWYg
KHMgPT0gUlBNX1NVU1BFTkRJTkcgfHwgcyA9PSBSUE1fU1VTUEVOREVEKQorCSAgICAgICAgc3Rh
dHVzID0gcG1fcmVxdWVzdF9yZXN1bWUoJmludGYtPmRldik7CiAKLQlzdGF0dXMgPSBwbV9ydW50
aW1lX2dldCgmaW50Zi0+ZGV2KTsKIAlpZiAoc3RhdHVzIDwgMCAmJiBzdGF0dXMgIT0gLUVJTlBS
T0dSRVNTKQogCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoJmludGYtPmRldik7CiAJZWxzZQo=
--000e0cd5174c8f3317049d053efa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd5174c8f3317049d053efa--
