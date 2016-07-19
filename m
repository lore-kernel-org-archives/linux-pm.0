From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH v3 2/2] power: Adds support for Smart Battery System
 Manager
Date: Tue, 19 Jul 2016 20:51:05 +0200
Message-ID: <1468954265.3053.3.camel@amnesix>
References: <1bIiDr-0004G1-0P>
	 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
	 <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
	 <20160719041729.GC1640@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160719041729.GC1640@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

Am Dienstag, den 19.07.2016, 06:17 +0200 schrieb Wolfram Sang:
> > +	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
> > +				   I2C_MUX_LOCKED, &sbsm_select, NULL);
> > +	if (!data->muxc) {
> > +		dev_err(dev, "failed to alloc i2c mux\n");
> 
> Don't print errors on ENOMEM.

Will be fixed on next revision.

> 
> Other than that, looks good to me, yet Peter has more insight to
> i2c-muxes these days.
> 
Tanks for review. 

Will wait another few days before sending a new revision, hence changes
are rather small.
-- 
Karl-Heinz
