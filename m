From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
Date: Tue, 8 Dec 2015 19:50:38 +0100
Message-ID: <5667267E.2080601@gmail.com>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com> <20151207190355.GE28024@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35291 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbLHSus (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 13:50:48 -0500
In-Reply-To: <20151207190355.GE28024@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

On 07.12.2015 20:03, Mark Rutland wrote:
> On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
>>
>> On 07/12/15 18:24, Geert Uytterhoeven wrote:
>>> +	L2_CA57: cache-controller@0 {
>>> +		compatible = "cache";
>>> +		arm,data-latency = <4 4 1>;
>>> +		arm,tag-latency = <3 3 3>;
>>
>> Interesting, only PL2xx/3xx cache controller driver reads this from the
>> DT and configures the controller. The integrated L2 found in
>> A15/A7/A57/A53 needs doesn't make use of these values from the DT.
>
> These properties seem to be from l2cc.txt, which really only corresponds
> to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.
>
> I don't see that these are necessary at all.


What's about a documentation patch like [1], then?


For what is the arm64 dts entry

cpu@0 {
	...
	next-level-cache = <&L2_0>;
};

L2_0: l2-cache0 {
	compatible = "cache";
};

good for at all, then?


Best regards

Dirk


[1]

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt 
b/Documentation/devicetree/bindings/arm/l2cc.txt
index 06c88a4..f687aed 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -1,12 +1,18 @@
  * ARM L2 Cache Controller

-ARM cores often have a separate level 2 cache controller. There are 
various
+ARM 32-bit cores often have a separate level 2 cache controller. 
There are various
  implementations of the L2 cache controller with compatible 
programming models.
  Some of the properties that are just prefixed "cache-*" are taken 
from section
  3.7.3 of the ePAPR v1.1 specification which can be found at:
 
https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf

-The ARM L2 cache representation in the device tree should be done as 
follows:
+ARM 64-bit cores (e.g. A15/A7/A57/A53) have an integrated level 2 
cache which
+doesn't make use of any values from the kernel device tree. There is no
+L2 cache configuration done in the kernel. The L2 cache is assumed to be
+preconfigured by early secure boot code.
+
+The ARM L2 cache representation for 32-bit cores in the device tree 
should be done
+as follows:

  Required properties:


