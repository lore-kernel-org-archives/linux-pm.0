From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 9 Sep 2015 18:50:03 -0500
Message-ID: <55F0C5AB.5060609@kernel.org>
References: <20150811151736.GO18282@x1> <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1> <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux> <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux> <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux> <20150909163620.GF3260@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150909163620.GF3260@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 09/09/2015 11:36 AM, Lee Jones wrote:
>>> Or have I got the wrong end of the stick?
>>>
>>> NB: Note the suggested new property names.
>>
>> Yeah, all looks fine to me.
> 
> I think these names are better:
> 
>   opp-supply-range-name => opp-microvolt-names
>   opp-cuts              => opp-supported-hw
> 
> Apart from that, the binding is starting to come together.
> 
> Let's see what Rob and Stephen have to say about it.

Seems reasonable to me.

Rob
