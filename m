From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 02/27] PM / Domains: Allow domain power states to be
 read from DT
Date: Tue, 15 Dec 2015 15:14:28 -0700
Message-ID: <20151215221428.GF992@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-3-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFrZFMfE9XNRS8CpTPXU6fzfY9wv0cn+DTcg=SUnDyUQ0A@mail.gmail.com>
 <566FE652.1030602@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566FE652.1030602@baylibre.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15 2015 at 03:07 -0700, Marc Titinger wrote:
>On 10/12/2015 17:53, Ulf Hansson wrote:
>>On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:

>>>diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>>index 025b5e7..e2f542e 100644
>>>--- a/Documentation/devicetree/bindings/power/power_domain.txt
>>>+++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>>@@ -29,6 +29,44 @@ Optional properties:
>>>     specified by this binding. More details about power domain specifier are
>>>     available in the next section.
>>>
>>>+- power-states : A phandle of an idle-state that shall be soaked into a
>>>+                generic domain power state. The power-state shall be
>>>+               compatible with "linux,domain-state".
>>
>>Why mention the Linux specific "generic power domain" here?
>>
>>Let's instead try to describe this without using specific terminology
>>from Linux.
>
>Hmm, I will need Lina's help to answer this one.
>Following a previous review actually I dropped this power-states 
>compatible, to stick with idle-states.
>
I didnt want this to be ARM specific. An arm,idle-state is too specific
to be reused for generic PM domains, hence this compatible. We dont need
a compatible property, but I thought it would be nice to have the
property to give structure to the power state node.

>>
>>>+
>>>+==Power state==
>>>+
>>>+A PM domain power state describes an idle state of a domain and must be
>>>+have the following properties -
>>>+
>>>+       - compatible
>>>+               Usage: Required
>>>+               Value type: <stringlist>
>>>+               Definition: Must be "linux,domain-state"
>>
>>Why do you need a compatible string?
>>
>>You already have the phandle available, I suppose you can use that
>>instead of parsing for a new compatible string.
>>
Hmm.. okay.

>>>+
>>>+       - entry-latency-us
>>>+               Usage: Not required if wakeup-latency-us is provided.
>>>+               Value type: <prop-encoded-array>
>>>+               Definition: u32 value representing worst case latency in
>>>+               microseconds required to enter the idle state.
>>>+               The exit-latency-us duration may be guaranteed
>>>+               only after entry-latency-us has passed.
>>>+
>>>+       - exit-latency-us
>>>+               Usage: Not required if wakeup-latency-us is provided.
>>>+               Value type: <prop-encoded-array>
>>>+               Definition: u32 value representing worst case latency
>>>+               in microseconds required to exit the idle state.
>>>+
>>>+       - wakeup-latency-us:
>>>+               Usage: Not required if entry-latency-us and exit-latency-us
>>>+               are provided.
>>>+               Value type: <prop-encoded-array>
>>>+               Definition: u32 value representing maximum delay between the
>>>+               signaling the wakeup of the domain and the domain resuming
>>>+               regular operation.
>>>+               If omitted, this is assumed to be equal to:
>>>+                       entry-latency-us + exit-latency-us
>>
>>I think we should decide which of the two alternatives to use, we
>>shouldn't make it more complicated than needed.
>
>Agreed.
>
I like the entry + exit option.

Thanks,
Lina
