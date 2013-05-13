From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Mon, 13 May 2013 10:57:36 -0700
Message-ID: <51912990.8020206@intel.com>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan> <51911826.907@gmail.com> <519120CC.10403@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56425 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3EMR5k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2013 13:57:40 -0400
In-Reply-To: <519120CC.10403@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 05/13/2013 10:20 AM, Toralf F=C3=B6rster wrote:
> On 05/13/2013 06:43 PM, Dirk Brandewie wrote:
>> I spent some more time looking for a solution to this you can get sa=
me
>> behavior
>> by setting a config option in BOINC  "Use at most X % CPU time"
>
> yes - that's true. But BOINC is just an example.
>
> If "nice -19 <loooong running background job" is nowadays so uncommon=
,
> then I'm just curious what's the modern (easy) way of doing that ?
>

I believe using CGROUP's is the right answer for limiting this type
of load.

I have not tested it but from reading:
	Documentation/scheduler/sched-design-CFS.txt
	https://wiki.archlinux.org/index.php/Cgroups

You should be able to do something like the following:

	cd /sys/fs/cgroup/cpu
	mkdir bonic
	echo 400 > boinc/cpu.shares
	boinc &
	echo $! > boinc/tasks

Should limit the boinc group to ~40% of the cpu.

WARNING completely untested YMMV

--Dirk
