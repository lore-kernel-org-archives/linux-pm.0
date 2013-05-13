From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Mon, 13 May 2013 21:13:09 +0200
Message-ID: <51913B45.80901@gmx.de>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan> <51911826.907@gmail.com> <519120CC.10403@gmx.de> <51912990.8020206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:53687 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab3EMTRS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 15:17:18 -0400
Received: from mailout-de.gmx.net ([10.1.76.35]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LflnY-1UA0Cl00mQ-00pOIr for
 <linux-pm@vger.kernel.org>; Mon, 13 May 2013 21:17:17 +0200
In-Reply-To: <51912990.8020206@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 05/13/2013 07:57 PM, Dirk Brandewie wrote:
>     cd /sys/fs/cgroup/cpu
>     mkdir bonic
>     echo 400 > boinc/cpu.shares
>     boinc &
>     echo $! > boinc/tasks

In many places of my scripts for automated testing I use currently the
"nice -n" prefix at my ThinkPad to keep a long battery life, quiet fan,
cool CPU. The CPU just runs with minimal frequency but will give
med/max. power on demand.

If the P-State governor will be the replacement the old behaviour -

the kernel menu config says "will become the perferred ... (sic!)
=2E..scaling driver for Sandy bridge processors" -

is there a nifty user space tool which replaces "nice" and do all cgrou=
p
stuff for the user ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
