From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related
 device nodes
Date: Tue, 12 Dec 2017 10:34:42 +0100
Message-ID: <a68c5382-2a9c-6c3c-ea67-99db46bdff1a@gmail.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20171211075719.GD25177@vireshk-i7> <1758225.tOgn8eUOoH@aspire.rjw.lan>
 <20171212072625.GL25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41310 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdLLJep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 04:34:45 -0500
In-Reply-To: <20171212072625.GL25177@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>, mark.rutland@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, devicetree@vger.kernel.org

Hi,

On 12/12/2017 08:26 AM, Viresh Kumar wrote:
> On 12-12-17, 02:17, Rafael J. Wysocki wrote:
>> On Monday, December 11, 2017 8:57:19 AM CET Viresh Kumar wrote:
>>> On 08-12-17, 14:07, Andrew-sh Cheng wrote:
>>>> Add opp v2 information,
>>>> and also add clocks, regulators and opp information into cpu nodes
>>>>
>>>> Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
>>>> ---
>>>>  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
>>>>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
>>>>  2 files changed, 84 insertions(+)
>>>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Of course, DT bindings require ACKs from DT maintainers to be applied.
> 
> I didn't knew that we need Acks from DT maintainers for dts files as well? Yeah,
> its very much required while defining new bindings for sure.
> 

I will take the dts parts through the Mediatek SoC tree, so you don't have to
worry about them.

Please let me know when you take patch 1 and 2.

Regards,
Matthias
