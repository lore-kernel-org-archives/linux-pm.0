From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for exynos5422
Date: Tue, 17 Jul 2018 22:07:23 +0200
Message-ID: <CAJKOXPc74_5XT_nscxWLmbqRMNdBQaN-0=qV+C4uoBcwBMy0xw@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-4-git-send-email-linux.amoon@gmail.com> <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
 <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 July 2018 at 21:58, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> On 17 July 2018 at 17:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> e-fuse range min~max range is 16~76. if e-fuse value is out of
>>
>> s/e-fuse/Fuse/
>> s/if/If/
>>
>> Can you share the sources confirming that fuse values are between 16 and 76?
>>
> Below is my patch :
> https://github.com/hardkernel/linux/commit/52c4c9b295930bc53b215d38e274aeb0780917f1
>
> e-Fuse range min/max values are from exynos5422 user manual.

Indeed. Can you mention in commit msg, User Manual as the reference of this?

Best regards,
Krzysztof
