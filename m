From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/5 v2] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
Date: Tue, 6 Sep 2016 14:24:20 +0200
Message-ID: <CAMuHMdWujzjS9pDett3BT+xboS6DnhWmyF_hRQMJ2QUOJfPnjw@mail.gmail.com>
References: <SIXPR06MB09069C18D1F37BE5DB1284B3A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
 <CAMuHMdXjywuuQG8LLMddOTjCpC5Ady3hVWvm_SM_AcpFScwWDw@mail.gmail.com> <SIXPR06MB09064A12322A3E45026399B1A8F90@SIXPR06MB0906.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SIXPR06MB09064A12322A3E45026399B1A8F90-ptTgG45MbElcr699GEGyj20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Hien Dang <hien.dang.eb-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Toru Oishi <toru.oishi.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Khiem,

On Tue, Sep 6, 2016 at 2:19 PM, Khiem Nguyen
<khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>> > +static int rcar_gen3_thermal_probe(struct platform_device *pdev) {
>>
>> > +       priv->id = of_alias_get_id(dev->of_node, "tsc");
>> > +       if (priv->id < 0) {
>> > +               dev_err(dev, "Failed to get alias id (%d)\n", priv->id);
>> > +               ret = priv->id;
>> > +               goto error_unregister;
>> > +       }
>>
>> In v1, Morimoto-san wondered whether the alias is really needed, but you haven't
>> addressed his question.
>>
>> While aliases can be useful in DT source files, using aliases like this imposes
>> hardcoded instance numbers, which is something we try to avoid these days.
>> Also, this puts a hard requirement on the presence of the alias in DT, which should
>> be documented in the DT bindings.
>
> OK.
> I prefer updating DT binding to describe alias.
>
> There is requirement about coefficient to calculate temperature,
> and the coefficient value (fixed value) is different among thermal sensors.

>From DT, you can still refer to a specific instance using a phandle to a label.
You do not need aliases for that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
