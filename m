From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 1/2] power: rt5033_charger: Add RT5033 charger device
 driver
Date: Thu, 22 Jan 2015 12:59:12 +0900
Message-ID: <54C07590.9080707@samsung.com>
References: <1421887092-4070-1-git-send-email-beomho.seo@samsung.com>
 <1421887092-4070-2-git-send-email-beomho.seo@samsung.com>
 <20150122031240.GA17627@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20150122031240.GA17627-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Thank you for review.

On 01/22/2015 12:12 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 22, 2015 at 09:38:11AM +0900, Beomho Seo wrote:
>> This patch add device driver of Richtek RT5033 PMIC. The driver
>> support switching charger. rt5033 charger provide three charging
>> mode.  Three charging mode are pre charge mode, fast cahrge mode
>> and constant voltage mode. They are have vary charge rate, charge
>> parameters. The charge parameters can be controlled by i2c
>> interface.
>>
>> [...]
>>
>> +	charger->psy.name = "rt5033-charger",
>> +	charger->psy.type = POWER_SUPPLY_TYPE_BATTERY,
>>
>> [...]
> 
> POWER_SUPPLY_TYPE_MAINS?
> 
> -- Sebastian
> 

OK I will change power supply type.

Thanks,
Beomho Seo

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
