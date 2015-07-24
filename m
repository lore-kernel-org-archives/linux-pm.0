From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 21:36:28 +0900
Message-ID: <CAJKOXPdJH99yPgyduHw5Cb2SCuXiV125wT1SovOATd23qu2JBA@mail.gmail.com>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
	<20150724122622.GA22105@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150724122622.GA22105@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2015-07-24 21:26 GMT+09:00 Sebastian Reichel <sre@kernel.org>:
> Hi,
>
> Thanks for the cleanup patch.
> I have a couple of comments inlined.
>
>> Subject: Re: [PATCH] power_supply: Adjust devm usage
>
> Please make this "power_supply: bq24735: ...".
>
> On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
>> Use devm_kasprintf instead of kasprintf. Also, remove various
>> gotos by direct returns and drop unneeded label err_free_name.
>
> Please also use devm_power_supply_unregister() instead
> of power_supply_unregister() to further simplify the driver.
>
>> @@ -267,8 +267,9 @@ static int bq24735_charger_probe() {}
>> [...]
>
> Your patch is missing removal of the
> kfree(charger->charger_desc.name) in bq24735_charger_remove().

Right, I missed that... My review was not sufficient.

Best regards,
Krzysztof
