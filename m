From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for exynos5422
Date: Wed, 18 Jul 2018 01:28:31 +0530
Message-ID: <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-4-git-send-email-linux.amoon@gmail.com> <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 17 July 2018 at 17:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> e-fuse range min~max range is 16~76. if e-fuse value is out of
>
> s/e-fuse/Fuse/
> s/if/If/
>
> Can you share the sources confirming that fuse values are between 16 and 76?
>
Below is my patch :
https://github.com/hardkernel/linux/commit/52c4c9b295930bc53b215d38e274aeb0780917f1

e-Fuse range min/max values are from exynos5422 user manual.

Best Regards
-Anand
