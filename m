From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Wed, 19 Dec 2018 10:10:34 +0530
Message-ID: <20181219044034.s2zikr22xs73pmcv@vireshk-i7>
References: <20181211164249.26985-1-gregory.clement@bootlin.com>
 <20181211164249.26985-3-gregory.clement@bootlin.com>
 <20181217111026.7b3tds2yz4g7opdt@vireshk-i7>
 <87mup2hpmr.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87mup2hpmr.fsf@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18-12-18, 15:32, Gregory CLEMENT wrote:
>  On lun., d=E9c. 17 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 11-12-18, 17:42, Gregory CLEMENT wrote:
> >> +++ b/drivers/cpufreq/armada-8k-cpufreq.c

> >> +		for (i =3D 0; i < nb_cpus; i++) {
> >> +			if (clk_is_match(clk, freq_tables[i].clk)) {
> >> +				skip =3D 1;
> >
> > Why not do devm_clk_put() from right here and "continue" after that. Th=
at way
> > you can avoid "skip" variable as well.
> =

> We need to keep a reference to the clk when it used later in the loop.

Maybe I wasn't able to clarify what I was suggesting. This code can be writ=
ten
as:

		for (i =3D 0; i < nb_cpus; i++) {
			if (clk_is_match(clk, freq_tables[i].clk)) {
                                devm_clk_put(cpu_dev, clk);
                                continue;
                        }
                }

I don't see how the current code is different than this.

> I think you missed the fact that no variable are passed to the exit
> function but we still need to have a reference on the OPP to free, so we
> cant do without this global variable. However I could reduce the amount
> by hiding them in a platform data associated to the platform_device.

Maybe, lets see how the simplified form of the driver looks like. And then =
see
if something is still left to be done.

-- =

viresh
