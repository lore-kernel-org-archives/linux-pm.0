From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3 2/2] power: Adds support for Smart Battery System
 Manager
Date: Mon, 25 Jul 2016 12:44:49 +0200
Message-ID: <e252c587-560e-ee85-5016-a0b92124e422@axentia.se>
References: <1bIiDr-0004G1-0P>
 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
 <1468349295-4935-3-git-send-email-karl-heinz@schneider-inet.de>
 <20160719041729.GC1640@katana> <1468954265.3053.3.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1468954265.3053.3.camel@amnesix>
Sender: linux-i2c-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

On 2016-07-19 20:51, Karl-Heinz Schneider wrote:
> Hi Wolfram,
> 
> Am Dienstag, den 19.07.2016, 06:17 +0200 schrieb Wolfram Sang:
>>> +	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
>>> +				   I2C_MUX_LOCKED, &sbsm_select, NULL);
>>> +	if (!data->muxc) {
>>> +		dev_err(dev, "failed to alloc i2c mux\n");
>>
>> Don't print errors on ENOMEM.
> 
> Will be fixed on next revision.
> 
>>
>> Other than that, looks good to me, yet Peter has more insight to
>> i2c-muxes these days.
>>
> Tanks for review. 
> 
> Will wait another few days before sending a new revision, hence changes
> are rather small.

Looks good to me from a muxing perspective, with very a minor nit that the
devicetree bindings do not point to i2c-mux.txt for where "standard i2c-mux
nodes" are described.

Cheers,
Peter
