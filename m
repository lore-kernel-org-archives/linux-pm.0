From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 17/25] mfd: axp20x: add CHRG_CTRL1/2/3 to writeable
 regs for AXP20X/AXP22X
Date: Tue, 31 Jan 2017 13:05:15 +0800
Message-ID: <CAGb2v65RqphAkWVqwmZr8tKhXxSrkYQSiwg6tTa8uKomuV0hmA@mail.gmail.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-18-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-18-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 27, 2017 at 4:54 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The CHRG_CTRL1 and CHRG_CTRL2 registers are made for controlling
> different battery charging settings such as the constant current charge
> value.
>
> The AXP22X also have a third register CHRG_CTRL3 which has settings for
> battery charging too.
>
> This adds the CHRG_CTRL1, CHRG_CTRL2 and CHRG_CTRL3 registers to the
> list of writeable registers for AXP20X and AXP22X PMICs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
