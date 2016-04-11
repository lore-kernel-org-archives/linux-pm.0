From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Tue, 12 Apr 2016 05:15:01 +0900
Message-ID: <CAGTfZH3AVbo6w9KDVNNCs+JMi=+-CA0oL6pQ+3jcOFihtKaK3Q@mail.gmail.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
	<570B218E.5000908@samsung.com>
	<20160411195557.GA6426@kozik-lap>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34859 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbcDKUPC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 16:15:02 -0400
In-Reply-To: <20160411195557.GA6426@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anand Moon <linux.amoon@gmail.com>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>device

Hi Krzysztof,

On Tue, Apr 12, 2016 at 4:55 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On Mon, Apr 11, 2016 at 01:01:18PM +0900, Chanwoo Choi wrote:
>> Dear Myungjoo and Krzysztof,
>>
>> This patch-set already get the acked-by or signed-off-by tag
>> from Exynos SoC and DEVFREQ maintainer except for patch10.
>>
>> If there is no comment, could you pick this patch-set?
>
> I cannot find any description of dependencies between the patches so I
> assume the obvious one: DTS patches do not depend on anything. This
> means that:
> 1. driver/devfreq related changes (including dt-bindings documentation)
>    go to Myungjoo,
> 2. I can pick DTS changes.

Yes.

>
> But first I would like to see the bindings documentation beeing applied
> by someone as a proof that there won't be more development in DTS in
> these series. There is no sense of picking DTS if after comments from
> Rob, you will rework them, right?

I already discussed the Rob's question on December, last year on
patchset[1]. But, after that, I didn't receive the any reply from him.
[1] https://lkml.org/lkml/2015/12/10/943

So, I thought that there is no comment.  But, today, he give some
question after 4 months.

But I'll again reply to Rob's question.

>
> Anyway I see Rob's questions. For these bindings I think you should get
> DT-guys ack first.

OK.

Best Regards,
Chanwoo Choi
