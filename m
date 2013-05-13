From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Mon, 13 May 2013 19:20:12 +0200
Message-ID: <519120CC.10403@gmx.de>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan> <51911826.907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:49517 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab3EMRUQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 13:20:16 -0400
Received: from mailout-de.gmx.net ([10.1.76.34]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Mb5SX-1Uw5xs0otn-00KdvS for
 <linux-pm@vger.kernel.org>; Mon, 13 May 2013 19:20:15 +0200
In-Reply-To: <51911826.907@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 05/13/2013 06:43 PM, Dirk Brandewie wrote:
> I spent some more time looking for a solution to this you can get sam=
e
> behavior
> by setting a config option in BOINC  "Use at most X % CPU time"

yes - that's true. But BOINC is just an example.

If "nice -19 <loooong running background job" is nowadays so uncommon,
then I'm just curious what's the modern (easy) way of doing that ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
