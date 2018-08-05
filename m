From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] power: supply: max77693_charger: fix unintentional
 fall-through
Date: Sat, 4 Aug 2018 21:01:46 -0500
Message-ID: <20a2e89f-1715-9659-f65f-5ace0b2073fb@embeddedor.com>
References: <20180717214739.GA19410@embeddedor.com>
 <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
 <20180722221717.fgx6nzljnfrw3d5a@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180722221717.fgx6nzljnfrw3d5a@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 07/22/2018 05:17 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 18, 2018 at 08:14:50AM +0200, Krzysztof Kozlowski wrote:
>> On 17 July 2018 at 23:47, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>>> It seems that a *break* is missing in order to avoid a fall-through.
>>> Otherwise, the calculation of *data* makes no sense.
>>>
>>> Addresses-Coverity-ID: 1271172 ("Missing break in switch")
>>> Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/power/supply/max77693_charger.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Thanks, queued to power-supply's fixes branch.
> 

I think this should be tagged for stable.

Thanks
--
Gustavo
