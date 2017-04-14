From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
Date: Fri, 14 Apr 2017 17:19:55 +0200
Message-ID: <CACna6rynSmGP20wSe0nUDGSYqb1N-ZbB3nZ4Jo9=v+303-qj=Q@mail.gmail.com>
References: <20170331201124.656-1-zajec5@gmail.com> <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com> <20170407044218.GA12447@localhost.localdomain>
 <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl> <20170414151613.GA24429@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32791 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdDNPUG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 11:20:06 -0400
In-Reply-To: <20170414151613.GA24429@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Mason <jon.mason@broadcom.com>

On 14 April 2017 at 17:16, Eduardo Valentin <edubezval@gmail.com> wrote:
> Hello Rafal,
>
> On Fri, Apr 14, 2017 at 02:16:36PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
>> On 04/07/2017 06:42 AM, Eduardo Valentin wrote:
>> >On Mon, Apr 03, 2017 at 05:48:29PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote=
:
>> >>From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>> >>
>> >>Northstar is a SoC family commonly used in home routers. This commit
>> >>adds a driver for checking CPU temperature. As Northstar Plus seems to
>> >>also have this IP block this new symbol gets ARCH_BCM_IPROC dependency=
.
>> >>
>> >>Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>> >>Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> >
>> >If no objection, I am applying this series.
>>
>> Cool, hopefully there aren't any more objections :) Once applied should =
I
>> expect this in
>> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-therm=
al.git/log/?h=3Dnext
>> ?
>
> They were already applied, but in my #linus branch. Now they are also in
> my #next branch. The #linus branch goes to the coming merge window. The
> #next branch goes to linux-next testing. Your change is now on
> linux-next test, kernelci testing, and for the coming merge windown.

I got it, thank you!

--=20
Rafa=C5=82
