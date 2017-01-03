From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 1/3] power: reset: add linkstation-reset driver
Date: Tue, 3 Jan 2017 14:09:16 +0100
Message-ID: <20170103130916.GA30197@lunn.ch>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-2-rogershimizu@gmail.com>
 <fff132e9-a178-6948-676e-6a4d24b6c4d6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <fff132e9-a178-6948-676e-6a4d24b6c4d6@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Roger Shimizu <rogershimizu@gmail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Martin Michlmayr <tbm@cyrius.com>, linux-arm-kernel@lists.infradead.org, Sylver Bruneau <sylver.bruneau@googlemail.com>
List-Id: linux-pm@vger.kernel.org

> > +
> > +	/* Check that nothing else has already setup a handler */
> > +	if (pm_power_off) {
> > +		lookup_symbol_name((ulong)pm_power_off, symname);
> > +		dev_err(&pdev->dev,
> > +			"pm_power_off already claimed %p %s",
> > +			pm_power_off, symname);
> > +		return -EBUSY;
> > +	}
> > +	pm_power_off = linkstation_reset;
> 
> That seems a bit complicated, why not just assume that there will be
> either this driver used, or not at all?

That is probably my fault. This is a copy from code i wrote many years
ago for the QNAP. I guess at the time i was battling with two
different pm_power_off handlers, so put in this code.

> Also, you are supposed to register a reboot notifier to which you can
> pass private context:

At the time i wrote the QNAP code, this did not exist. So maybe my
code is no longer a good example to copy.

	 Andrew
