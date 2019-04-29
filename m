From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
Date: Mon, 29 Apr 2019 14:05:58 +0200
Message-ID: <68bf0a3f-6fb4-979d-bfdc-fdab930248f1@partner.samsung.com>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
        <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
        <20190425195338.GB31128@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425195338.GB31128@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org



On 4/25/19 9:53 PM, Rob Herring wrote:
> On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
>> The device tree bindings for LPDDR3 SDRAM memories.
> 
> Also, 'dt-bindings: ddr: ' for the subject. You've got a mixture of
> subjects with no consistency.
Right, I will change it.
> 
>>
>> For specifying the AC timing parameters of the memory device
>> the 'lpddr3' binding uses binding 'lpddr2-timings'.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> 
> 
