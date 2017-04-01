From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH V4 2/2] thermal: broadcom: add Northstar thermal driver
Date: Sat, 01 Apr 2017 13:20:11 -0700
Message-ID: <DC208578-DA81-4113-B073-64AA920F7FFA@gmail.com>
References: <20170331073132.21457-2-zajec5@gmail.com> <20170331201124.656-1-zajec5@gmail.com> <20170331201124.656-2-zajec5@gmail.com> <20170401195443.GE28514@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36657 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdDAUUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 16:20:13 -0400
In-Reply-To: <20170401195443.GE28514@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Jon Mason <jon.mason@broadcom.com>

On April 1, 2017 12:54:45 PM PDT, Eduardo Valentin <edubezval@gmail=2Ecom> =
wrote:
>Also, I have just merged a BRCM driver=2E Does it make sense to move it
>here too?

I think it does make sense to have all Broadcom SoCs thermal drivers under=
 a broadcom/ directory=2E As a matter of fact, I will be submitting another=
 one (for brcmstb SoCs) shortly=2E
Hi Eduardo,
--=20
Florian
