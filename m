From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH 5/5] Documentation: Add documentation for rt5033
 multifunction device
Date: Mon, 10 Nov 2014 14:40:57 +0900
Message-ID: <54604FE9.8070902@samsung.com>
References: <1415328727-16245-1-git-send-email-beomho.seo@samsung.com>
 <1415328727-16245-6-git-send-email-beomho.seo@samsung.com>
 <20141107103440.GD8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34596 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbaKJFlI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 00:41:08 -0500
In-reply-to: <20141107103440.GD8509@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Thank you for your advice.
I'll fix them and send v2 patch soon.

On 11/07/2014 07:34 PM, Mark Brown wrote:
> On Fri, Nov 07, 2014 at 11:52:07AM +0900, Beomho Seo wrote:
> 
>> +Required properties:
>> +- compatible = Must be "richtek,rt5033-regulator"
>> +
>> +	regulators {
>> +		compatible = "richtek,rt5033-regulator";
> 
> There should be no need for this extra compatible, it's not adding
> anything we didn't know from the fact that it's part of the MFD.
> 
>> +		regulator-name {
>> +			regulator-name = LDO/BUCK
>> +			standard regulator constraints...
>> +		};
> 
> Better to just say something like "regulator subnodes called X, Y and Z"
> described using the standard regulator binding in...
> 

Best regards,
Beomho Seo
