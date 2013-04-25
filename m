From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 1/2] ARM: s3c64xx: cpuidle: use init/exit common routine
Date: Fri, 26 Apr 2013 00:31:01 +0900
Message-ID: <51794C35.6070400@samsung.com>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org> <5178F8E0.6010606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5178F8E0.6010606@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, lethal@linux-sh.org, kgene.kim@samsung.com, ben-linux@fluff.org, horms+renesas@verge.net.au, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/25/13 18:35, Daniel Lezcano wrote:
> On 04/23/2013 04:41 PM, Daniel Lezcano wrote:
>> Remove the duplicated code and use the cpuidle common code for initialization.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
>
> Hi Kim and Ben,
>
> It is the last patch in the series which was not acked-by.
> Rafael is willing to take it in its tree if you ack it.
>
> Are you ok if this patch ?
>
Looks OK to me, please go ahead with my ack if you want:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin
