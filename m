From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] power: supply: max77693_charger: fix unintentional
 fall-through
Date: Thu, 19 Jul 2018 08:54:59 -0500
Message-ID: <0bbc5227-1b69-91bc-fe3b-221e5685d494@embeddedor.com>
References: <20180717214739.GA19410@embeddedor.com>
 <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 07/18/2018 01:14 AM, Krzysztof Kozlowski wrote:
> On 17 July 2018 at 23:47, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>> It seems that a *break* is missing in order to avoid a fall-through.
>> Otherwise, the calculation of *data* makes no sense.
>>
>> Addresses-Coverity-ID: 1271172 ("Missing break in switch")
>> Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/power/supply/max77693_charger.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

BTW, I think this also should be tagged for stable.

Thanks
--
Gustavo
