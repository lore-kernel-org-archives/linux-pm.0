From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH v3 5/7] PM / Hibernate: Allow arch code to influence CPU
 hotplug during hibernate
Date: Wed, 29 Jun 2016 18:02:39 +0800
Message-ID: <57739CBF.2090706@intel.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
 <1467125510-18758-6-git-send-email-james.morse@arm.com>
 <7811260.OWJXivZiAP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62519 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbcF2Jzb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 05:55:31 -0400
In-Reply-To: <7811260.OWJXivZiAP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>



On 2016=E5=B9=B406=E6=9C=8829=E6=97=A5 08:10, Rafael J. Wysocki wrote:
> On Tuesday, June 28, 2016 03:51:48 PM James Morse wrote:
>> Architecture code may need to do extra work when secondary CPUs are
>> disabled during hibernate and resume. This may include pushing sleep=
ing
>> CPUs into a deeper power-saving state, or influencing which CPU resu=
me
>> occurs on.
>>
>> Define a macro arch_hibernation_disable_cpus(), which defaults to ca=
lling
>> disable_nonboot_cpus() if undefined. Architectures that need to do e=
xtra
>> work around these calls can use this to influence disable_nonboot_cp=
us()
>> behaviour. The macro should be defined in asm/suspend.h, and
>> ARCH_HIBERNATION_CPUHP should be added to Kconfig.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
> As you noted, this could be used to address the x86 issue that Yu is =
working on,
> so I'd like it to go in as the first patch in the series and through =
the PM tree.
>
This patch looks friendly for that fix :), thanks.
> For the x86 case we'll also need the complementary "enable", so why d=
on't
> you add it here and then use it instead of the enable_nonboot_cpus()?
>
Agreed.

Yu
