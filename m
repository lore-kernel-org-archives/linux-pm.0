From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v8 4/7] of/irq: Adjust of pci irq parsing for multiple
 interrupts
Date: Mon, 30 Oct 2017 10:05:51 +0800
Message-ID: <59F688FF.9020806@rock-chips.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-5-jeffy.chen@rock-chips.com> <20171027143812.5i4vathfjpgld7wk@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171027143812.5i4vathfjpgld7wk@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 10/27/2017 10:38 PM, Rob Herring wrote:
>> +		prop = of_find_property(dn, "interrupt-names", NULL);
>> >+		for (name = of_prop_next_string(prop, NULL); name;
>> >+		     name = of_prop_next_string(prop, name), index++) {
>> >+			if (!strcmp(name, "pci"))
>> >+				break;
> Use of_property_match_string
>
i'm trying to find the first unnamed or "pci" named irq in the string 
array, so cannot use that API:)

but will change to of_property_for_each_string as Brian suggested.
