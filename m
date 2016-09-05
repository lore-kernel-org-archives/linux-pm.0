From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 1/5] Documentation: Add support for TI System Control
 Interface (TI-SCI) protocol
Date: Mon, 5 Sep 2016 10:09:10 +0300
Message-ID: <6c63b044-3db9-9202-b790-350a88b9eab0@ti.com>
References: <20160830130647.6828-1-nm@ti.com>
 <20160830130647.6828-2-nm@ti.com> <20160902150628.GA19493@rob-hp-laptop>
 <CAGo_u6q0xxnUj5ary82OU1uP=kTHfA_3N7_d7OiSEwS1_5dXuw@mail.gmail.com>
 <57C9E0A8.4010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57C9E0A8.4010701-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02/09/16 23:27, Dave Gerlach wrote:
> On 09/02/2016 12:07 PM, Nishanth Menon wrote:
>> Rob,
>>
>> On Fri, Sep 2, 2016 at 10:06 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Tue, Aug 30, 2016 at 08:06:43AM -0500, Nishanth Menon wrote:
>> [...]
>>>> +
>>>> +TI-SCI Client Device Node:
>>>> +========================
>>>> +
>>>> +Client nodes refer to the required TI-SCI device using the "ti,sci"
>>>> property.
>>>
>>> As I mentioned for power domains, for clients that are self contained
>>> (i.e. a single function) I think the should be child nodes.
>>>
>>
>> Thanks for the feedback. I think we should be able to do that and also
>> assume you have no further improvements you'd like to see here.
>>
>> Looking at current Documentation/devicetree/bindings/arm/arm,scpi.txt
>> -> it makes sense to stick along the same lines as you mentioned.
>>
>> Dave, Tero: do you guys have any objections?
>
> No objections, I think this is a logical move.

Yea, sounds like a valid change. I believe you are going to post a new 
version so I can modify the clock driver also accordingly?

-Tero

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
