From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 19/25] iio: adc: axp20x_adc: map battery IIO channels
Date: Tue, 31 Jan 2017 13:06:23 +0800
Message-ID: <CAGb2v6662oikMk8uhD-mMx9d4Gf4Fw64ndOsj89EPcNxA9S6Cg@mail.gmail.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-20-quentin.schulz@free-electrons.com>
 <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 28, 2017 at 10:52 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/01/17 08:54, Quentin Schulz wrote:
>> This maps the IIO channels batt_v, batt_chrg_i and batt_dischrg_i
>> (respectively exposing the current charging and discharging currents and
>> current voltage measures of the battery power supply) to the battery
>> power supply driver.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
