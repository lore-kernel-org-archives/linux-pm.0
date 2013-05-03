From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Fri, 03 May 2013 14:43:11 -0700
Message-ID: <51842F6F.1050005@intel.com>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan> <518427D4.3050104@gmail.com> <51842B79.8060302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56843 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760475Ab3ECVnO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 17:43:14 -0400
In-Reply-To: <51842B79.8060302@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 05/03/2013 02:26 PM, Toralf F=C3=B6rster wrote:
> On 05/03/2013 11:10 PM, Dirk Brandewie wrote:
>>
>> ignore_nice_load is a feature of the ondemand governor.
>> The intel_pstate driver is seeing the load presented by the BOINC cl=
ient
>> and is adjusting the pstate accordingly.
>
> Is the intel_pstate driver a choice for a notebook and friends where =
a
> grid software is running as a low-prio back ground job ?
>

Probably not.

> Because the CPU will be running mostly at high(er) frequency - which
> always results in a high temperature and short battery time.
>

It would be better IMHO if the client software limited the resources
it uses when the system is not on wall power but that is a seperate
discussion :-)

--Dirk

