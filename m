From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 01/11] power: supply: axp20x_usb_power: use
 of_device_id data field instead of device_is_compatible
Date: Wed, 14 Dec 2016 23:38:06 +0800
Message-ID: <CAGb2v67GHZ6fq6PoSJt3O3170ej1Gjkc5PGgCRptSQjcOi=zXA@mail.gmail.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161209110419.28981-2-quentin.schulz@free-electrons.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This replaces calls to of_device_is_compatible to check data field of
> of_device_id matched when probing the driver.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
