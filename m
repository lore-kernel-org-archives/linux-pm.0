From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] power: supply: ltc2941-battery-gauge: Release device_node
 in ltc294x_i2c_probe()
Date: Tue, 8 May 2018 22:16:31 +0300
Message-ID: <8fef316f-85d0-0bd4-4bbe-2d8330dfe2ec@ispras.ru>
References: <1524954955-22107-1-git-send-email-khoroshilov@ispras.ru>
 <20180501123908.z3kuokp2b6umnnda@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501123908.z3kuokp2b6umnnda@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
List-Id: linux-pm@vger.kernel.org


Hi,

On 01.05.2018 15:39, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Apr 29, 2018 at 01:35:55AM +0300, Alexey Khoroshilov wrote:
>> There is of_node_get(client->dev.of_node) in ltc294x_i2c_probe(),
>> but these is no of_node_put() somethere in the driver.
>>
>> The patch adds one on error and normal paths.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> 
> That is ugly. Let's replace of_property_read_u32(np, ...) with
> device_property_read_u32(dev, ...) and get rid of np instead.
> 

Ok, I will prepare v2.

What is the right way to replace
info->supply_desc.name = np->name;
?

If lifetime of 'client->dev.of_node' = 'np' cannot be less than lifetime
of 'client->dev', should we use just
info->supply_desc.name = client->dev.of_node->name;
?

Thank you,
Alexey
