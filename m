From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v10 6/7] arm64: dts: sdm845: Add interconnect provider DT
 nodes
Date: Wed, 5 Dec 2018 18:01:02 +0200
Message-ID: <9db2cd8c-62ad-1029-c1f5-7db272abc8de@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-7-georgi.djakov@linaro.org>
 <CAE=gft4XEqkL4oON=Q1oji=AoYeEdL5DFjy3h6hN6uFR9oRA4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4XEqkL4oON=Q1oji=AoYeEdL5DFjy3h6hN6uFR9oRA4A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 12/1/18 02:39, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Add RSC (Resource State Coordinator) provider
>> dictating network-on-chip interconnect bus performance
>> found on SDM845-based platforms.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index b72bdb0a31a5..856d33604e9c 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1324,6 +1324,11 @@
>>                                 compatible = "qcom,sdm845-rpmh-clk";
>>                                 #clock-cells = <1>;
>>                         };
>> +
>> +                       qnoc: qnoc {
>> +                               compatible = "qcom,sdm845-rsc-hlos";
>> +                               #interconnect-cells = <1>;
>> +                       };
> 
> Should we alphabetize this node above rpmhcc?

Sure!

Thanks,
Georgi
