From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Thu, 19 May 2016 15:16:47 -0500
Message-ID: <CAPBZ5QcF4tKYLxAw1bsNv2Ma=JutRRvta9kiYMHM0XKoXni5SA@mail.gmail.com>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
	<1463634020-17252-4-git-send-email-andy.gross@linaro.org>
	<573E1982.7090402@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <573E1982.7090402@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 19 May 2016 at 14:52, Stanimir Varbanov <stanimir.varbanov@linaro.org> wrote:
> Hi Andy,
>
> On 05/19/2016 08:00 AM, Andy Gross wrote:
>> This patch adds the qcom,idle-state-spc compatible to the SPC idle
>> state.  This compatible indicates that the state is one which supports
>> freeze.
>>
>> Signed-off-by: Andy Gross <andy.gross@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> index 208af00..032e411 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> @@ -104,7 +104,7 @@
>>
>>               idle-states {
>
> Is this change depends on some another patchset, I cannot find
> idle-states dt node on mainline nor linux-next ?

The cover letter gives a link to the patchset that contains the basis
for the changes.  You can also check out my posted branch which merges
in a part of those changes.

The link to the specific patch is:
http://www.spinics.net/lists/linux-arm-msm/msg19675.html

or you can look at this:
https://git.linaro.org/people/andy.gross/linux-pm.git/shortlog/refs/heads/for-pramod
