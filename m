From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: document Rockchip thermal
Date: Thu, 18 Sep 2014 10:18:12 -0700
Message-ID: <20140918171809.GD14809@core.coreip.homeip.net>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
 <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com>
 <CAAObsKA61Ano85P6PehOY7WqR0FgTz_Rfur8UAt56ZXoNyoyqQ@mail.gmail.com>
 <541ADD58.7070901@rock-chips.com>
 <CAAObsKCYGEBNEvDTs=iQD9KT0YomQWHg0W-vwHG4nLZbqogF=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKCYGEBNEvDTs=iQD9KT0YomQWHg0W-vwHG4nLZbqogF=g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Caesar Wang <caesar.wang@rock-chips.com>, heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, addy.ke@rock-chips.com, zyf@rock-chips.com, cjf@rock-chips.com
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 18, 2014 at 04:19:26PM +0200, Tomeu Vizoso wrote:
> On 18 September 2014 15:25, Caesar Wang <caesar.wang@rock-chips.com> =
wrote:
> > Tomeu,
> >
> > =E5=9C=A8 2014=E5=B9=B409=E6=9C=8818=E6=97=A5 17:27, Tomeu Vizoso =E5=
=86=99=E9=81=93:
> >>
> >> On 17 September 2014 05:59, Caesar Wang <caesar.wang@rock-chips.co=
m>
> >> wrote:
> >>>
> >>> This add the necessary binding documentation for the thermal
> >>> found on Rockchip SoCs
> >>
> >> Hi Caesar,
> >>
> >> is there any reason to not use the existing thermal bindings? You =
can
> >> find a description in
> >> Documentation/devicetree/bindings/thermal/thermal.txt and example =
code
> >> in omap, or in the patches for Tegra recently posted by Mikko
> >> Perttunen.
> >>
> >> Regards,
> >>
> >> Tomeu
> >
> >
> > Why should I use the existing thermal bindings?
>=20
> Because otherwise, you are asking to merge duplicated code. There's a
> generic way to define thermal zones, trip points, cooling devices,
> etc. And also code to parse and plug them together. Why add
> soc-specific code to do the same?
>=20
> > I believe omap,tegar and rockchip are  the three seperate thermals =
driver.
>=20
> Yes, and OMAP is already using the generic bindings, and the proposed
> patches for Tegra as well, and I think it would make sense for
> Rockchip to also use them (unless I'm missing something).

You are talking about drivers/thermal/of-thermal.c, right? Yes, I think
Rockchip should be using the same generic framework if possible.

Thanks.

--=20
Dmitry
