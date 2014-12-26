From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH] regulator: rt5033-regulator: Use regulator_nodes/of_match
 in the descriptor
Date: Fri, 26 Dec 2014 09:09:12 +0900
Message-ID: <549CA728.4050606@samsung.com>
References: <1418901216-19030-1-git-send-email-beomho.seo@samsung.com>
 <20141222151025.GY17800@sirena.org.uk> <54992212.8050707@samsung.com>
 <20141224125600.GB17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12884 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaLZAJP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Dec 2014 19:09:15 -0500
In-reply-to: <20141224125600.GB17800@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lgirdwood@gmail.com, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com

On 12/24/2014 09:56 PM, Mark Brown wrote:
> On Tue, Dec 23, 2014 at 05:04:34PM +0900, Beomho Seo wrote:
>> On 12/23/2014 12:10 AM, Mark Brown wrote:
> 
>>> This isn't replacing existing code with use of the framework, it's
>>> adding new bindings where there were none before so it needs to add a
>>> binding document too.
> 
>> Actually, RT5033 device tree binding document sent at mainling list already.
>> link is below,
>> http://marc.info/?l=linux-pm&m=141890859525642&w=2
>> It include regulator device node but above patch not applied yet.
>> If you want, I will revise dt binding document patch and send to mailing list.
> 
> OK, I've applied this but please in future send the code and binding
> documentation together to avoid such confusion.
> 

Thank you for response.
I will send code and binding documentation together at early date.
