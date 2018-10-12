From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 8/8] arm64: dtsi: sdm845: Add cpu power domain
 support
Date: Fri, 12 Oct 2018 11:52:55 -0600
Message-ID: <20181012175255.GJ2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-9-git-send-email-rplsssn@codeaurora.org>
 <20181012173500.GB23170@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012173500.GB23170@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12 2018 at 11:35 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 02:50:55AM +0530, Raju P.L.S.S.S.N wrote:
>> Add cpu power domain support
>>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index d3662a8..aadaa20 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -96,6 +96,7 @@
>>  			reg = <0x0 0x0>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_0: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -111,6 +112,7 @@
>>  			reg = <0x0 0x100>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_100>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_100: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -123,6 +125,7 @@
>>  			reg = <0x0 0x200>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_200>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_200: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -135,6 +138,7 @@
>>  			reg = <0x0 0x300>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_300>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_300: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -147,6 +151,7 @@
>>  			reg = <0x0 0x400>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_400>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_400: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -159,6 +164,7 @@
>>  			reg = <0x0 0x500>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_500>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_500: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -171,6 +177,7 @@
>>  			reg = <0x0 0x600>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_600>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_600: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -183,6 +190,7 @@
>>  			reg = <0x0 0x700>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_700>;
>> +			power-domains = <&cpu_pd>;
>>  			L2_700: l2-cache {
>>  				compatible = "cache";
>>  				next-level-cache = <&L3_0>;
>> @@ -1170,6 +1178,11 @@
>>  					  <WAKE_TCS    3>,
>>  					  <CONTROL_TCS 1>;
>>
>> +			cpu_pd: power-domain-controller {
>> +				compatible = "qcom,cpu-pm-domain";
>> +				#power-domain-cells = <0>;
>> +			};
>> +
>
>After all the discussions, I see this power domain actually influence
>not just CPUs but other devices. So this should be top most power domain
>in the system with lots of devices or their power domains pointing to it.
>Why is this just pointing to cpus ?
>
The domain powers off even when devices remains powered on. The devices
themselves are not part of this domain, they have their own rails,
clocks and domains. Those domains will get powered off when the devices
are suspended or the device are not in use.

This CPU domain is responsible for setting the domain controller to
enter a low power state and in addition help lower the state of the
shared resources that are used by the devices even when the devices
themselves are powered on.

-- Lina
