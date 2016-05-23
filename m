From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RESEND v2] power: reset: keystone: Enable COMPILE_TEST
Date: Mon, 23 May 2016 08:12:31 +0200
Message-ID: <CAJKOXPdACNfhYj8cbrU6sUU+R7vSe+TOsRCPizhvu753KjavoA@mail.gmail.com>
References: <1459298988-20530-1-git-send-email-k.kozlowski@samsung.com>
	<20160415142752.GC24087@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32903 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcEWGMc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 02:12:32 -0400
In-Reply-To: <20160415142752.GC24087@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 15, 2016 at 4:27 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Mar 30, 2016 at 09:49:48AM +0900, Krzysztof Kozlowski wrote:
>> Enable the COMPILE_TEST to get build coverage, except on platforms
>> !HAS_IOMEM (required by selected MFD_SYSCON).
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Thanks, queued.

Hey,

I can't find this patch in your recent pull request. What happened?

Best regards,
Krzysztof
