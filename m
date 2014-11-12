From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v2 2/5] regulator: rt5033: Add RT5033 Regulator device
 driver
Date: Wed, 12 Nov 2014 10:25:31 +0900
Message-ID: <5462B70B.5090400@samsung.com>
References: <1415603987-32475-1-git-send-email-beomho.seo@samsung.com>
 <1415603987-32475-3-git-send-email-beomho.seo@samsung.com>
 <20141110190403.GH3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52965 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbaKLBZe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 20:25:34 -0500
In-reply-to: <20141110190403.GH3815@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, cw00.choi@samsung.com, geunsik.lim@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Liam Girdwood <lgirdwood@gmail.com>

Sorry, I will include your e-mail address next revision all patch-set.

On 11/11/2014 04:04 AM, Mark Brown wrote:
> On Mon, Nov 10, 2014 at 04:19:44PM +0900, Beomho Seo wrote:
>> This patch add device driver of Richtek RT5033 PMIC.
>> The driver support multiple regulator like LDO and synchronous Buck.
>> The integrated synchronous buck converter is designed to provide 0.6 A
>> application with high efficiency. Two LDOs are integrated. One safe LDO is
>> for 60mA and the other one LDO is for 150 mA.
> 
> I'm missing all the other patches in this series...
> 

Regards,
Beomho Seo

