From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 3/3] arm64: dts: marvell: armada-37xx: add the node
 allowing AVS support
Date: Fri, 29 Jun 2018 16:36:43 +0200
Message-ID: <87602164n8.fsf@bootlin.com>
References: <20180619124402.902-1-gregory.clement@bootlin.com>
 <20180619124402.902-4-gregory.clement@bootlin.com>
 <20180629095426.7aein2vmjtegyrfa@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180629095426.7aein2vmjtegyrfa@vireshk-i7> (Viresh Kumar's
 message of "Fri, 29 Jun 2018 15:24:26 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>, Victor Gu <xigu@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, Hua Jing <jinghua@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,
 
 On ven., juin 29 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 19-06-18, 14:44, Gregory CLEMENT wrote:
>> In order to be able to use Adaptive Voltage Scaling, we need to add a
>> reference to these registers.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks! Based on your acked-by, then I applied this patch on mvebu/dt

I let you apply the 2 other patches of the series

Gregory



>
> -- 
> viresh

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
