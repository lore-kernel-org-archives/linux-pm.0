From: =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/14] thermal: Add support for sun8i THS on
 Allwinner H3
Date: Sat, 25 Jun 2016 02:35:42 +0200
Message-ID: <f6015f63-f8e6-6aa4-aab3-48a8152f0df5@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-4-megous@megous.com>
 <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw@mail.gmail.com>
Reply-To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3Pg3jK0BLPjgKWrlpgJ0SdCTknL5Kp2cO"
Return-path: <linux-sunxi+bncBDXLF6FR5INBBY5DW65QKGQEWA3GSEQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: dev <dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Pg3jK0BLPjgKWrlpgJ0SdCTknL5Kp2cO
Content-Type: multipart/mixed; boundary="ORgQ4O8JilJloVgcJGoCox2bXDse8f51g"
From: =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: dev <dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org>,
 linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <f6015f63-f8e6-6aa4-aab3-48a8152f0df5-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/14] thermal: Add support for sun8i THS on Allwinner H3
References: <20160623192104.18720-1-megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
 <20160623192104.18720-4-megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
 <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--ORgQ4O8JilJloVgcJGoCox2bXDse8f51g
Content-Type: text/plain; charset=UTF-8

On 24.6.2016 05:09, Chen-Yu Tsai wrote:
>> +static int sun8i_ths_h3_init(struct platform_device *pdev,
>> +                            struct sun8i_ths_data *data)
>> +{
>> +       int ret;
>> +       size_t callen;
>> +       s32 *caldata;
>> +
>> +       data->busclk = devm_clk_get(&pdev->dev, "ahb");
>> +       if (IS_ERR(data->busclk)) {
>> +               ret = PTR_ERR(data->busclk);
>> +               dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       data->clk = devm_clk_get(&pdev->dev, "ths");
>> +       if (IS_ERR(data->clk)) {
>> +               ret = PTR_ERR(data->clk);
>> +               dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       data->reset = devm_reset_control_get(&pdev->dev, "ahb");
> 
> IIRC with the new shared reset control stuff merged, you are supposed
> to specify whether you want a shared or exclusive one when you ask for
> it.

Here devm_reset_control_get will get the exclusive reference. So this
should be ok.

regards,
  Ondrej

> 
> Regards
> ChenYu
> 
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.9.0
>>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--ORgQ4O8JilJloVgcJGoCox2bXDse8f51g--

--3Pg3jK0BLPjgKWrlpgJ0SdCTknL5Kp2cO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXbdHeAAoJEG5kJsZ3z+/xwwAP/jujcjRFy6xSls5iyTLtqF2R
IsnQYMKv3nuSKrijkt86TO0YdqcJg8sOsViw7skCyemPkczz8neD5C/FMowTsQ5t
OqaxRMmbfrXcOqt3ls4SNtInSPvUnnB9vcBWV4HhvCz2WQ9iPkpRXqWQCVIegZek
jvmHMHXE9ez00ZL0Cq2jdkPB6KMYbg5k+93odHHQfFjVv23/+Tti2nqDBtWRykip
lF5wt+mKRTtNddvS9HhNCmeZ8Rd29q7CdZLIus34UnqLcvvAlM5UaQfIf4CxqztZ
/NaBEhnkDbfftOr86035/JeZETlUwKA4SrSAKZq8J+v2aR+/44yWKkDSaUFwSIVx
Sec3hvLAX6A0GlL0cONZrJwnWQpra9ZCU48m5YzmTH8QWcYuQqR6aOj/fh6RQLBB
oSD7CR8Mb+BFkktFdft48Weud0n9lcDkfQXsSSDqpHDU9QVVK2WlxzVETAvU5mh9
Ftn1o//Up/TUc8yjUw2bzB3q7TF5VPhD0qrBNs3cNKl8CqiAJYzEXJdjvujEQr3i
a8NytkOt0U2DJweO4MYlztro3WDNWgZM80jQGQ2JEQl6drQxidWSc+xJUU8RxPE8
3gl3OvtyN0r6c/kXJbeRFmKODcnjn7p5wXixXMGb8fE5l9aJZZEwsPkqJ8hBcDn0
I6d3CeLTRFm0fgJc57sb
=aahp
-----END PGP SIGNATURE-----

--3Pg3jK0BLPjgKWrlpgJ0SdCTknL5Kp2cO--
