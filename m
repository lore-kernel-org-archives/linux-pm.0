From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
Date: Tue, 17 Jul 2018 22:01:29 +0200
Message-ID: <CAJKOXPfSs7rRN9z7oOOX-0O3cC=+jT=WVGvaQ3j+yL=MD_ifUA@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-5-git-send-email-linux.amoon@gmail.com> <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
 <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 July 2018 at 21:56, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi
>
> On 17 July 2018 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> add tmuctrl aliases node for exynos542x
>>
>> Please use full sentence, starting with capital letter and ending with
>> a dot. Also please explain why you need tmuctrl aliases.
>>
>
> As per the [0] Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>
> For multi-instance tmu each instance should have an alias correctly
> numbered in "aliases" node.

Ah, right. However except reading value of alias and storing it, the
driver does not use it later. Maybe this should be just removed.

Best regards,
Krzysztof
