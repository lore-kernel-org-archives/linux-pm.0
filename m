From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: 4.14.0-rc7: cpufreq interface in sysfs removed ?
Date: Wed, 1 Nov 2017 10:49:49 -0700
Message-ID: <CAGt4E5tdttASaxx5Nuc8_6Pm9=Mkdp95-uWB9rAoH8YZoHA=-Q@mail.gmail.com>
References: <CADDKRnDjXzSU=toFVH6pYOS9co4rp-hQ8rv6U9zBnChj_bLAvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54833 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdKARtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 13:49:50 -0400
Received: by mail-wm0-f54.google.com with SMTP id r68so6409174wmr.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2017 10:49:50 -0700 (PDT)
In-Reply-To: <CADDKRnDjXzSU=toFVH6pYOS9co4rp-hQ8rv6U9zBnChj_bLAvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 1 November 2017 at 10:06, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> In 4.14.0-rc7-00009-g287683d cpufreq directory under
> /sys/devices/system/cpu/cpufreq
> is empty. Also link /sys/devices/system/cpu/cpu0/cpufreq is missing.

It is looking fine on my system.

# dmesg | grep cpufreq
<6>[    1.313374] brcmstb-avs-cpufreq f04c4000.avs-cpu-data-mem: registered

# find /sys -name \*cpufreq\*
/sys/devices/system/cpu/cpu3/cpufreq
/sys/devices/system/cpu/cpu1/cpufreq
/sys/devices/system/cpu/cpufreq
/sys/devices/system/cpu/cpu2/cpufreq
/sys/devices/system/cpu/cpu0/cpufreq
/sys/bus/platform/drivers/cpufreq-dt
/sys/bus/platform/drivers/brcmstb-avs-cpufreq
/sys/module/cpufreq

# uname -a
Linux (none) 4.14.0-rc7 #1 SMP Wed Nov 1 10:34:11 PDT 2017 armv7l GNU/Linux

> Is this change intentional?

This sounds more like your cpufreq driver didn't load. It is probably
worth investigating in that direction.

Also, you didn't mention anything about your hardware or your configuration=
.

> J=C3=B6rg
