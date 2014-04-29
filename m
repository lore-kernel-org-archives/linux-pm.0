From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RFC 0/5] Dove PMU support
Date: Tue, 29 Apr 2014 11:15:27 +0200
Message-ID: <535F6DAF.1010400@gmail.com>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk> <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:43183 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbaD2JPw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 05:15:52 -0400
In-Reply-To: <20140428083144.GB6650@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>

On 04/28/2014 10:31 AM, Andrew Lunn wrote:
>> Russell,
>>
>> thanks for dropping those patches. I know you are packed with a bunch
>> of other patch sets, so if you agree, I can pick up your Dove related
>> patches and finish them.
>>
>> One thing that comes into my mind is, that we moved Dove DT to
>> mach-mvebu starting with v3.15-rc1 so we need to find a better place
>> for the driver than mach-dove.
>
> Create drivers/pmu ?

Hmm, I see no other folder it could sit in. Maybe, yes.

> The cpufreq driver also needs access to registers within the pmu
> range. Should it be part of pmu.c, or should we export a regmap which
> cpufreq can use?

Not only cpufreq but also pinctrl as the first 16 mpps can have PMU
related functions mapped to them. Syscon should do the trick.

Sebastian

