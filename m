From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: w1: document generic onewire and
 DS2760 bindings
Date: Fri, 6 Jul 2018 07:30:55 +0200
Message-ID: <de376c3a-9579-1f3f-26d6-b9ca367d6d40@zonque.org>
References: <20180704044411.2693-1-daniel@zonque.org>
 <20180704044411.2693-2-daniel@zonque.org>
 <20180705233245.GA16422@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705233245.GA16422@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu, sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org

On Friday, July 06, 2018 01:32 AM, Rob Herring wrote:
> On Wed, Jul 04, 2018 at 06:44:08AM +0200, Daniel Mack wrote:
>> This patch adds a generic w1 bindings document that merely describes how
>> slave deviceses are grouped under master nodes. It also adds a specific
>> binding for the ds2760 battery monitor.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>   .../bindings/power/supply/maxim,ds2760.txt    | 29 +++++++++++++++++++
> 
> This has grown enough now, you should probably make it a separate
> patch.

Right, will do.

Thanks for all the reviews, Rob. Much appreciated. Will send a v4.


Daniel
