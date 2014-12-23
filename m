From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH] regulator: rt5033-regulator: Use regulator_nodes/of_match
 in the descriptor
Date: Tue, 23 Dec 2014 17:04:34 +0900
Message-ID: <54992212.8050707@samsung.com>
References: <1418901216-19030-1-git-send-email-beomho.seo@samsung.com>
 <20141222151025.GY17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64302 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbaLWIFE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 03:05:04 -0500
In-reply-to: <20141222151025.GY17800@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lgirdwood@gmail.com, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com

On 12/23/2014 12:10 AM, Mark Brown wrote:
> On Thu, Dec 18, 2014 at 08:13:36PM +0900, Beomho Seo wrote:
>> This patch is add regulator_nodes/of_match in the regulator descriptor
>> for using information from DT instead of sppecific codes.
> 
>>  drivers/regulator/rt5033-regulator.c |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> This isn't replacing existing code with use of the framework, it's
> adding new bindings where there were none before so it needs to add a
> binding document too.
> 

Actually, RT5033 device tree binding document sent at mainling list already.
link is below,
http://marc.info/?l=linux-pm&m=141890859525642&w=2
It include regulator device node but above patch not applied yet.
If you want, I will revise dt binding document patch and send to mailing list.

Best regards,
Beomho Seo

