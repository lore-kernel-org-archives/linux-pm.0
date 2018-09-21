From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Fri, 21 Sep 2018 08:40:43 -0700
Message-ID: <CACRpkda70HAnnQ6a06E-VZwPUveb-OPDYrKYzm+XFAC1LP+rqw@mail.gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com> <20180920165847.6xqzeoqzqkyotshx@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.reichel@collabora.com
Cc: Craig Tatlor <ctatlor97@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 20, 2018 at 9:58 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> I prefer the second binding (with mV -> uV), but I think it becomes
> messy when temperature is added. What do you think about the
> following proposal (derived from pinctrl style):
>
> Proposal C:
>
> ocv-capacity-table-temperatures = <(-10) 0 10>;
> ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;

I think this looks very elegant. It's going to be very
easy and intuitive for people who need to maintain these
device trees and it will be easy to handle in centralized code
for all platforms. Even with the microvolt notation.

If possible could we go with this?

Yours,
Linus Walleij
