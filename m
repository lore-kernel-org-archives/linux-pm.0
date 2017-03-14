From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 14 Mar 2017 10:03:36 +0800
Message-ID: <CAMz4ku+-=5EFDVjrTk57_qDXCfKMYtYNzGv5od5+LDBThxEsrQ@mail.gmail.com>
References: <cover.1487578977.git.baolin.wang@linaro.org> <87zih3m73h.fsf@notabene.neil.brown.name>
 <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com>
 <AM5PR04MB29614C707DE344E5A05FAB3889210@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuJ31wVhbYOV+LB9tu=Wb7x9gRifcUnQPMiQSqRUjER_kQ@mail.gmail.com>
 <AM5PR04MB296177A37D96564D510FA90389210@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4ku+wkZ7webuCK+V9DPuDzdT_Tyy6Dso8==bQPyN9m06vGw@mail.gmail.com>
 <AM5PR04MB29610364B8FA56AE7AD8A68989200@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuLNa=sdYQrzXZspPd9ug-Opn2jfUCGHtq2qNT4Omax4Mw@mail.gmail.com>
 <AM5PR04MB29613EEC7C49426020A538B089200@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4ku+jy-Z0L4avYsDGstNnV+f=XhjmP8WS9SLOkB1eGWjjXA@mail.gmail.com>
 <AM5PR04MB29615806A8D175E3BF4BD8B089250@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuL=h-2BM093t3BQi9f+ygR2GJ=xBVghJe69HX47re_RTQ@mail.gmail.com> <HE1PR04MB2972189B0532136078A5221D89240@HE1PR04MB2972.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <HE1PR04MB2972189B0532136078A5221D89240-6LN7OEpIatUyGO52j9nQIM9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
Cc: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVjdc2367bhdW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 14 March 2017 at 09:10, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Baolin Wang [mailto:baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
>> Sent: Monday, March 13, 2017 4:44 PM
>> To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
>> Cc: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>; Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Greg KH
>> <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Dmitry
>> Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; David Woodhouse
>> <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Marek Szyprowski
>> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>; Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>;
>> Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>; Alan Stern
>> <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>; grygorii.strashko-l0cyMroinI0@public.gmane.org; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>; Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>;
>> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>;
>> Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>;
>> patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org; Linux PM list <linux-
>> pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; device-
>> mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org; LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with
>> the usb gadget power negotation
>>
> ... ...
>> >> That is same what USB charger did, from this point, we need USB
>> >> charger to send out vbus draw information according to speed and usb
>> >> state. But I should listen to other guys suggestion. Peter and Felipe, what
>> do you think?
>
> Instead of waiting for maintainer's comments on this long discussion, I'd suggest
> you directly post the patches for the required change, so they can easily know
> what's the conclusion/solution looks like.

That's right, I am creating patches for adding extcon_dev in
phy/usb_phy. Thanks.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
