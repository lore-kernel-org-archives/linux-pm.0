From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v5 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date: Tue, 12 Mar 2019 10:18:14 +0100
Message-ID: <a8eafa27-1dc5-f4cf-9c1d-b4cbce80ec62@partner.samsung.com>
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa@eucas1p1.samsung.com>
        <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
        <20190311220650.GB4082@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311220650.GB4082@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 3/11/19 11:06 PM, Rob Herring wrote:
> On Tue,  5 Mar 2019 11:19:04 +0100, Lukasz Luba wrote:
>> Define new IDs for clocks used by Dynamic Memory Controller in
>> Exynos5422 SoC.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
I have skipped your ACK because of the hack which is implemented in v5
clocks. Chanwoo refused the driver code because it uses 2 registers from
the clock register set without Common Clock Framework API.
He said that he will not accept this code and I have to figure out new
approach using CCF.
Thus, I have modeled these two registers as 'gates', but these registers
are for Dynamic Memory Controller PAUSE feature (which stops
transactions) and the other is for switching between
two set of registers with timings for the LPDDR3 memory (normal
operation and alternative clock source operation aka 'bypass').
These registers should be (in my opinion) in the DMC registers and not
in the clocks.

Sylwester pointed out offline that it could be done using regmap.
These are the problematic clocks added in v5:
+#define CLK_CDREX_PAUSE		531
+#define CLK_CDREX_TIMING_SET	532

I have mentioned about it in the cover letter, but you are right I could
also add a comment for this particular patch that I have skipped your
ACK.
Thank you for sharing the information about the process.
I will keep it in mind next time and will add a comment below the commit
message for a particular patch and explicit information in cover letter
that I am not including an ACK.

Regards,
Lukasz
> 
> 
