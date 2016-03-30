From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 12:17:32 +0200
Message-ID: <CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
	<4187911.uaFVupaTVL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36799 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcC3KRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 06:17:34 -0400
In-Reply-To: <4187911.uaFVupaTVL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

2016-03-29 23:34 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Tuesday, March 29, 2016 07:32:27 PM J=C3=B6rg Otte wrote:
>> 2016-03-29 19:24 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
>> > in v4.5 and earlier intel-pstate downscaled idle processors (load
>> > 0.1-0.2%) to minumum frequency, in my case 800MHz.
>> >
>> > Now in v4.6-rc1 the characteristic has dramatically changed. If in
>> > idle the processor frequency is more or less a few MHz around 2500=
Mhz.
>> > This is the maximum non turbo frequency.
>> >
>> > No difference between powersafe or performance governor.
>> >
>> > I currently use acpi_cpufreq which works as usual.
>> >
>> > Processor:
>> > Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz (family: 0x6, model: 0x3c=
,
>> > stepping: 0x3)
>> >
>> > Last known good kernel is: 4.5.0-01127-g9256d5a
>> > First known bad kernel is: 4.5.0-02535-g09fd671
>> >
>> > There is
>> > commit 277edba Merge tag 'pm+acpi-4.6-rc1-1' of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> > in between, which brought a few changes in intel_pstate.
>
> Can you please check commit a4675fbc4a7a (cpufreq: intel_pstate: Repl=
ace timers
> with utilization update callbacks)?
>
Yes , this solved the problem for me.
I had to resolve some conflicts myself when reverting that
commit. Hard work :).

Here is a 10-seconds trace of the used frequencies when
in "desktop-idle":

driver          cpu0 cpu1 cpu2 cpu3
-------------------------------------
intel_pstate (  800  928  941 1200) MHz   load:( 0.2)%
intel_pstate (  800  928 1181 1800) MHz   load:( 0.0)%
intel_pstate ( 1675 1576 1347  800) MHz   load:( 0.0)%
intel_pstate ( 1198 1576  842  800) MHz   load:( 0.5)%
intel_pstate (  800 1181 1113 1600) MHz   load:( 0.0)%
intel_pstate (  808 1181  805  800) MHz   load:( 0.5)%
intel_pstate (  844 1191  900 1082) MHz   load:( 0.3)%
intel_pstate (  816 1191  800  800) MHz   load:( 0.0)%
intel_pstate (  800  905  892 1082) MHz   load:( 0.2)%
intel_pstate (  945  905 1340  800) MHz   load:( 0.3)%


Thanks, J=C3=B6rg
