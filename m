From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
Date: Wed, 9 Dec 2015 17:16:58 +0000
Message-ID: <5668620A.9070908@arm.com>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com> <20151207190355.GE28024@leverpostej>
 <5667267E.2080601@gmail.com> <20151208191656.GD11797@leverpostej>
 <56685DBE.8030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50934 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbbLIRRD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 12:17:03 -0500
In-Reply-To: <56685DBE.8030001@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org



On 09/12/15 16:58, Dirk Behme wrote:
> On 08.12.2015 20:16, Mark Rutland wrote:

[...]

>>
>> With the other properties from ePAPR you can acquire information on the
>> geometry of the cache, which cannot be acquired from architected
>> registers.
>
>
> Just for my understanding: Yes, if other properties from ePAPR like
> geometry of the cache are added to the device tree l2 cache entries then
> it makes sense to have them.
>
> But an "empty" entry like the one given in the example above doesn't
> make much sense and could be removed without loosing any functionality?
>

No they are required to detect the cache hierarchy as there's no
architectural way of detecting the same.

> It looks to me that most of the L2 entries we have in
> arch/arm64/boot/dts are such "empty" entries.
>

True *so far*, we have not seen a case where we need to override the
values read in a architectural way.

-- 
Regards,
Sudeep
