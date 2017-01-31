From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 11/25] mfd: axp20x: add AC power supply cells for
 AXP22X PMICs
Date: Tue, 31 Jan 2017 12:11:06 +0800
Message-ID: <CAGb2v67P8fnDtAa15BprbDqBH62zb6LEpvwLj1O=UoGMnO2p5Q@mail.gmail.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-12-quentin.schulz@free-electrons.com>
 <20170129163513.m7y4vbjgthh2esg4@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170129163513.m7y4vbjgthh2esg4@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 30, 2017 at 12:35 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Fri, Jan 27, 2017 at 09:54:44AM +0100, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
>> supply.
>>
>> This adds the AC power supply driver to the MFD cells of the AXP22X
>> PMICs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
> Acked-By: Sebastian Reichel <sre@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
