From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 5 Oct 2016 15:57:59 +0800
Message-ID: <CAMz4kuKFj=pVoKSA7=2ojGh_MMF4x1DD_d_QmVSPh-k7BbXA0w@mail.gmail.com>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name> <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com>
 <87twdo7ouz.fsf@notabene.neil.brown.name> <CAMz4kuLXyLK2jFmaoxxceq01FT4fo+N-iAtCLPyQzJh5R24uOw@mail.gmail.com>
 <CAMz4kuLHEv16yBDxW=peVyPB3_K27QUDyKHT0ecBZxAQR-2VXA@mail.gmail.com> <878tu3p78u.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878tu3p78u.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>, NeilBrown <nfbrown-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TasMV2rI37PzA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Felipe,

On 5 October 2016 at 15:47, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> Hi Baolin,
>
> Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>> But you do!
>>>> The mA number from the USB configuration is passed to usb_gadget_vbus_draw.
>>>> Your patch passes that to usb_charger_set_cur_limit_by_type()
>>>> which calls __usb_charger_set_cur_limit_by_type() which will set the
>>>> cur_limit for whichever type uchger->type currently is.
>>>>
>>>> So when it is not relevant, your code *does* set some current limit.
>>>
>>> Suppose the charger type is DCP(it is not relevant to the mA number
>>> from the USB configuration ), it will not do the USB enumeration, then
>>> no USB configuration from host to set current.
>>
>> From the talking, there are some issues (thanks for Neil's comments)
>> need to be fixed as below:
>> 1. Need to add the method getting charger type from extcon subsystem.
>> 2. Need to remove the method getting charger type from power supply.
>> 3. There are still some different views about reporting the maximum
>> current or minimum current to power driver.
>>
>> Now the current v16 patchset can work well on my Spreadtrum platform
>> and Jun's NXP platform, if you like to apply this patchset then I can
>> send out new patches to fix above issues. If you don't like that, I
>> can send out new version patchset to fix above issues. Could you  give
>> me some suggestions what should I do next step? Thanks.
>
> Merge window just opened, nothing will happen for about 2 weeks. How
> about you send a new version after merge window closes and we go from
> there? Fixing 1 and 2 is needed. 3 we need to consider more

Sure. I will send out the new version with fixing these issues. Thanks.

> carefully. Perhaps report both minimum and maximum somehow?
>
> Neil, comments?
>
> --
> balbi



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
