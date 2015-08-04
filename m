From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
Date: Tue, 04 Aug 2015 10:31:59 +0900
Message-ID: <55C0160F.6080301@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <3141301.RS9TLygaba@amdc1976> <20150727113641.GB10181@linux>
 <2681271.3UazeZ9PAQ@amdc1976> <55BA36A7.3050107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39760 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbbHDBcK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 21:32:10 -0400
In-reply-to: <55BA36A7.3050107@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 30.07.2015 23:37, Kukjin Kim wrote:
> On 07/27/15 20:47, Bartlomiej Zolnierkiewicz wrote:
>> On Monday, July 27, 2015 05:06:41 PM Viresh Kumar wrote:
>>> On 27-07-15, 13:14, Bartlomiej Zolnierkiewicz wrote:
>>>> Sorry but you don't seem to understand the issue.
>>>
>>> :)
>>>
>>> No, I did. I understand that if someone uses opp bindings today with
>>> some entries as turbo OPPs, cpufreq will use them as normal
>>> frequencies. And that may harm the board.
>>>
>>> BUT, opp-v2 code isn't ready to be used yet. And platforms should see
>>> what all is implemented before trying to use them.
>>
>> OK.
>>
>>> All I was saying is, this isn't a FIX as we haven't introduced the
>>> feature yet. Otherwise I had no issues with the patch.
>>
>> I will update the description for the next patchset revision.
>>
> Hi Bart,
> 
> When will you re-post v3? Because I have a plan to send a pull-request
> to arm-soc until this weekend...

Dear Kukjin,

We are already at 4.2-rc5 and you did not send the pull request before
the weekend as you said. It is really late and there is no special
reason for delaying the request. What happened?

Best regards,
Krzysztof

