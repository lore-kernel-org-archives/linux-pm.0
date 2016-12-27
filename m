From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 6/9] pinctrl: samsung: Replace syscore ops with standard
 platform device pm_ops
Date: Tue, 27 Dec 2016 11:17:45 +0100
Message-ID: <742a6c77-3ae9-ce5f-984d-4da3cc790865@samsung.com>
References: <CGME20161223122535epcas1p475bc33007e9ea9b206dec6d10d019d7f@epcas1p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <1482495889-6201-7-git-send-email-m.szyprowski@samsung.com>
 <CA+Ln22G80htJ6Va4hSD7ML3=h5QKUhdHm9X3Znnj1KBjyOrROw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CA+Ln22G80htJ6Va4hSD7ML3=h5QKUhdHm9X3Znnj1KBjyOrROw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,


On 2016-12-26 06:57, Tomasz Figa wrote:
> 2016-12-23 21:24 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>> Once the dependency on PMU driver (for pad retention control) has been
>> removed, there is no reason to use syscore_ops based suspend/resume.
> Does it also hold true for other platforms using this driver? I.e.
> s3c24xx, s3c64xx and s5pv210?

I've checked and I didn't find any code related to retention control in
s3c24xx and 23c64xx, but you are right that I need to add support for
s5pv210 (retention is controlled via S5P_OTHERS register). Thanks for
pointing this.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
