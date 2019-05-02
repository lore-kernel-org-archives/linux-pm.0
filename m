From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
Date: Thu, 2 May 2019 11:16:24 +0200
Message-ID: <e29648bb-9e94-1b02-5c6e-03b099ad807e@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
        <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
        <20190430223358.GA22052@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430223358.GA22052@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org



On 5/1/19 12:33 AM, Rob Herring wrote:
> On Fri, 19 Apr 2019 15:48:05 +0200, Lukasz Luba wrote:
>> This patch add support of a new feature which can be used in DT:
>> Performance Monitoring Unit with defined event data type.
>> In this patch the event data types are defined for Exynos PPMU.
>> The patch also updates the MAINTAINERS file accordingly and
>> adds the header file to devfreq event subsystem.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>   create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> 
Thank you, added to the commit message for the next patch set version.

Regards,
Lukasz
