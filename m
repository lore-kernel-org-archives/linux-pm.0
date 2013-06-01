From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: CPU governor ondemand misbehaves after s2ram for kernel 3.10-rcX
Date: Sat, 01 Jun 2013 11:02:36 +0200
Message-ID: <51A9B8AC.8000808@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:49696 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab3FAJCm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 1 Jun 2013 05:02:42 -0400
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LZkBu-1TzQj62VHY-00lWhq for
 <linux-pm@vger.kernel.org>; Sat, 01 Jun 2013 11:02:40 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net

If I s2ram my ThinkPad T420 (latest BIOS) and wake it up, CPU speeds up
to 2.4 GHz/2.6GHz (max freq. without boost for the i5) and temperature
increases to 70=C2=B0-80=C2=B0.
Switching to governor powersave and back to ondemand helps, CPU are at
800 MHz and temperature at 49=C2=B0.
3.9.X works fine.

=46ew dmesg/lspci data are in [1] (different ACPI bug, same system)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D59011

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
