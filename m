From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Mon, 13 May 2013 12:24:58 -0700
Message-ID: <51913E0A.6060402@gmail.com>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan> <51911826.907@gmail.com> <519120CC.10403@gmx.de> <51912990.8020206@intel.com> <51913B45.80901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <51913B45.80901@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/13/2013 12:13 PM, Toralf F=C3=B6rster wrote:
> On 05/13/2013 07:57 PM, Dirk Brandewie wrote:
>>      cd /sys/fs/cgroup/cpu
>>      mkdir bonic
>>      echo 400 > boinc/cpu.shares
>>      boinc &
>>      echo $! > boinc/tasks
>
> In many places of my scripts for automated testing I use currently th=
e
> "nice -n" prefix at my ThinkPad to keep a long battery life, quiet fa=
n,
> cool CPU. The CPU just runs with minimal frequency but will give
> med/max. power on demand.
>
> If the P-State governor will be the replacement the old behaviour -
>
> the kernel menu config says "will become the perferred ... (sic!)
> ...scaling driver for Sandy bridge processors" -
>
> is there a nifty user space tool which replaces "nice" and do all cgr=
oup
> stuff for the user ?
>

cgexec from the libcgroup-tools package (fedora name) look like it will=
 place
a process in a group for you.

https://wiki.archlinux.org/index.php/Cgroups

Has some useful examples.

--Dirk
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
