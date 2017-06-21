From: Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: dts: register Hi3660's thermal sensor
Date: Wed, 21 Jun 2017 09:58:13 +0800
Message-ID: <CAFGCpxyHowrssdhT1RffDO1o4-5=ksqAz+r8Q23-myVCi5h_fA@mail.gmail.com>
References: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <CAFGCpxwmN3jAZn2chK+QQ-YKg7TwWJOTHSi1VzwcSQ7Mm3gQng@mail.gmail.com> <7abe5b01-c728-accd-d6bb-05d9ceee2176@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7abe5b01-c728-accd-d6bb-05d9ceee2176-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 20, 2017 at 4:32 PM, Wangtao (Kevin, Kirin)
<kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org> wrote:
>
>
> =E5=9C=A8 2017/6/20 15:38, Guodong Xu =E5=86=99=E9=81=93:
>>
>>
>>
>> 2017=E5=B9=B46=E6=9C=8820=E6=97=A5 =E4=B8=8A=E5=8D=8811:49=EF=BC=8C"Tao =
Wang" <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
>> <mailto:kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>>=E5=86=99=E9=81=93=EF=BC=9A
>>
>>     Bind thermal sensor driver for Hi3660.
>>
>>     Signed-off-by: Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
>> <mailto:kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>>
>>     Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>> <mailto:leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>>
>>     ---
>>       arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    7 +++++++
>>       1 file changed, 7 insertions(+)
>>
>>     diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>     index 3983086..cc67958 100644
>>     --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>     +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>     @@ -156,5 +156,12 @@
>>
>>
>> i am wondering which tree this patch should be applied to. Actually Olof
>> Johansson olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org <mailto:olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> just merged hi3660 dts =
into
>> his tree. You should better rebase you dts patch onto that.
>
> Can you share me the git path?

As of this morning, it has shown up in linux next tag: next-20170620

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/ar=
ch/arm64/boot/dts/hisilicon?h=3Dnext-20170620

-Guodong


>>
>>
>>
>>                              clock-names =3D "uartclk", "apb_pclk";
>>                              status =3D "disabled";
>>                      };
>>     +
>>     +               tsensor: tsensor {
>>     +                       compatible =3D "hisilicon,thermal-hi3660";
>>     +                       reg =3D <0x0 0xfff30000 0x0 0x1000>;
>>     +                       #thermal-sensor-cells =3D <1>;
>>     +                       status =3D "ok";
>>
>>
>> please remove status ok. that's default. redundant.
>
> ok
>>
>>
>>     +               };
>>              };
>>       };
>>     --
>>     1.7.9.5
>>
>>
>>     _______________________________________________
>>     linux-arm-kernel mailing list
>>     linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> <mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
>>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
