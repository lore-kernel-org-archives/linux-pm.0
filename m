From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Mon, 4 Apr 2016 16:12:46 +0200
Message-ID: <CA+icZUUKT0+UUZZNpUNg8v_wrjz7NTVOTsSjdfmqL_RZyQzgew@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<1459376311.13525.108.camel@linux.intel.com>
	<003b01d18ad6$831941c0$894bc540$@net>
	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
	<002301d18b59$d208fe50$761afaf0$@net>
	<CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>
	<CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>
	<1459610923.5912.36.camel@linux.intel.com>
	<CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com>
	<CA+icZUUCEgs1-eeRje4zb_Lj=0=hWM8OPvoKrquMCAXAj=Gy4g@mail.gmail.com>
	<001201d18ddb$0102ccd0$03086670$@net>
	<CA+icZUVhnH563=8zyrsvH86y0HTqeT57OJ1ETES5_ZsDOwae-w@mail.gmail.com>
	<002f01d18e39$3b1691f0$b143b5d0$@net>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36350 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbcDDOMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 10:12:47 -0400
In-Reply-To: <002f01d18e39$3b1691f0$b143b5d0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>

On Mon, Apr 4, 2016 at 8:14 AM, Doug Smythies <dsmythies@telus.net> wro=
te:
> On 2016.03.04 22:14 Sedat Dilek wrote:
>> On Sun, Apr 3, 2016 at 8:59 PM, Doug Smythies <dsmythies@telus.net> =
wrote:
>>> On 2016.04.02 11:21 Sedat Dilek wrote:
>>>> On Sat, Apr 2, 2016 at 7:19 PM, J=C3=B6rg Otte wrote:
>>>>> 2016-04-02 17:28 GMT+02:00 Srinivas Pandruvada wrote:
>>>>>
>
>> are you involved in the Ubuntu-OS? Developer for Canonical?
>
> I try to help with Ubuntu as a community volunteer.
> I am not a developer with Canonical.
>
> ... [cut]...
>
>>> As far as I know the /etc/init.d/ondemand is working properly. It s=
ets the acpi-cpufreq
>>> driver to use the "ondemand" governor and it sets the intel_pstate =
driver to use the
>>> "powersave" governor.
>>>
>
>> I haven't looked at this exactly.
>> The ondemand-script is not saying to fall back to "powersave" in cas=
e
>> of intel_pstate-driver (here on Ubuntu/precise).
>
> It is likely that newer versions of /etc/init.d/ondemand script
> were never backported to the older 12.04 precise release.
> Why not? Well, because, as far as I know, that release never used the
> intel_pstate driver by default and so never had to fall through
> to the powersave alternative.
>
> Earlier on this thread, Srinivas correctly asked J=C3=B6rg what distr=
ibution
> was being used, so as to hopefully make it easier to reproduce the is=
sue.
> If we want to continue this distro specific conversation, perhaps
> we should move it off-list or to some Ubuntu specific forum.
>

Yes, it is getting off-topic.
Sorry for this.
I know I am here on my own and I think how to fix this.
( Honestly, I forgot about the initial issue. )

- Sedat -
