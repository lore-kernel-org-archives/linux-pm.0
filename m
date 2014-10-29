From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: v3.18-rc2 compilation under a x86 KVM failed in drivers/thermal/thermal_core.c:
Date: Wed, 29 Oct 2014 10:27:17 +0000
Message-ID: <9hhh9ynxjay.fsf@arm.com>
References: <544E6F5C.7040900@gmx.de> <9hh1tpsz1x0.fsf@arm.com>
	<544FD915.40200@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:53393 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932072AbaJ2K1W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Oct 2014 06:27:22 -0400
In-Reply-To: <544FD915.40200@gmx.de> ("Toralf =?utf-8?Q?F=C3=B6rster=22's?=
 message of "Tue, 28
	Oct 2014 18:57:41 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

Toralf F=C3=B6rster <toralf.foerster@gmx.de> writes:

> On 10/28/2014 03:47 PM, Punit Agrawal wrote:
>> Is there anything special about building the kernel in a kvm?
>>=20
>
> Nope, I'm just using gcc-4.7.3-r1
>
>> Could you attach the failing config please?
> ofc done

I started with a clean kernel source tree and tried building the
attached config. I still don't see the build failure.

Perhaps you had stale artifacts from previous builds causing failure to
link? Can you try building from a clean source tree?=20

Otherwise, I am out of ideas...

=46or reference,=20

$ gcc --version
gcc (Debian 4.9.1-16) 4.9.1
