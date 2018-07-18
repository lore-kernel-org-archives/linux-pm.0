From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
Date: Wed, 18 Jul 2018 14:40:16 +0200
Message-ID: <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-2-daniel@zonque.org>
 <20180711150157.GA18150@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711150157.GA18150@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu, sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 11, 2018 05:01 PM, Rob Herring wrote:
> On Fri, Jul 06, 2018 at 07:35:48AM +0200, Daniel Mack wrote:
>> This patch adds a generic w1 bindings document that describes how w1
>> slave deviceses are grouped under master nodes. It also augments the
>> existing w1-gpio.txt document a bit.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>   .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
>>   Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
>>   2 files changed, 33 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Note that this will conflict with a unit-address fix that I have queued
> up for 4.18 (will send this week).

How would we best handle this? Sebastian, are you going to apply this 
series, and add a note to the PR for 4.19 on how to resolve the conflict?


Thanks everyone!
Daniel
