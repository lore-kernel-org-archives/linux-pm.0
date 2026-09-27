Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19433769E6;
	Sun, 27 Sep 2026 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548285; cv=none; b=WzTXA7zoVO9XzaZsZvM7VWBeqCMB3ziqc25rKSpv4LzLUWJ1RQ+/2OAnKvduqwO8p+ZWgeQzyZlfkuhY/v1FCyeZ64ntjDYOu29yHI6pBgx7GIa/iTV0ZmvKAavTtj6Z0uguDdXZWs/0Zql/5esIH1SDr1BtEcJbZkeseu/V1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548285; c=relaxed/simple;
	bh=YjOat1KNhJoX0bTUbgaWW9L/Da0JuUpTvmtwIo8TUXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvYM5bvEERYqxSinzNckzs1Mrf2Wglz6SfR3CkmYSq6X9flgUF5b18fFb089w9UOLM7w48IlflHgx7gTJzOl6/2CDQ7nIxpFcLUInediFiB9mMpkzeEi81J+RJuooUG++X4GzR7tV0pe3P9KpcoW6N+SMOBmQMemLyl0dj7+Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6PCiO7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6PCiO7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556931F00893;
	Sun, 27 Sep 2026 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790548283;
	bh=CJZCgZh09PSxCwFabs9JG5uAYFKnKAe4DjdoMHSl/Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m6PCiO7bmrnbhtfvpEpW7Za1fmz26E9bGYZwJBqKsLRrg5nckYOGp7W//cFl2IXu+
	 fqiPD90F0+G6zWaPL1bFGRtpfqmzlA/oFDl6EykzQWb6Fl+eLNZlWGjpniim6b71sG
	 AEud9cJ3Y4xnKSe7qjWVikTb6wdilUu3Er3KxI+Xk29xOmZ3AlgO54WWuye7A5CwJ9
	 XSXGQrI43Qd0PhRNMyP5oG1aCHHuxnNxtY+HkyBfclZxrIW5/Iap7+RFi+1fyea6nb
	 PULS7/L3UOWMXve2RDdgrNDxCgIC4HEqMwTdKYegmoRA9Fx/YAXqTS11Dyp9zdrp9i
	 qewCTp6a5Eozg==
Received: by pali.im (Postfix)
	id 8911DAB8; Mon, 28 Sep 2026 00:31:25 +0200 (CEST)
Date: Mon, 28 Sep 2026 00:31:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>,
	linux-pm@vger.kernel.org, sre@kernel.org, afd@ti.com,
	konrad.dybcio@oss.qualcomm.com, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] power: supply: bq27xxx: detect bq27541 behind bq27411
 compatible
Message-ID: <20260927223125.wd77mdgiyiii2nrd@pali>
References: <20260928-master-v4-1-052c73ec1767@gmail.com>
 <20260927220026.hxwnm6mbfs7s7swu@pali>
 <a926e8c8-2a05-4760-9c71-a713d991985a@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a926e8c8-2a05-4760-9c71-a713d991985a@ixit.cz>
User-Agent: NeoMutt/20180716

On Monday 28 September 2026 00:13:43 David Heidelberg wrote:
> On 28/09/2026 00:00, Pali Rohár wrote:
> > On Monday 28 September 2026 00:17:17 Rinat Muhamedgaliev via B4 Relay wrote:
> > > From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> > > 
> > > OnePlus 6 and 6T replacement battery packs may contain either a bq27411 or a bq27541 fuel gauge at I2C address 0x55. The device tree currently identifies the gauge as bq27411, but a bq27541 uses a different register map and then reports invalid battery values.
> > > 
> > > Read the DeviceType control subcommand when probing a bq27411. Keep the existing profile for DeviceType 0x0421, but select the bq27541 profile for DeviceType 0x0541. This retains the established DT ABI and supports replacement packs without introducing a generic compatible.
> > 
> > Hello! I have not read the previous versions of the patch or its
> > discussion. But I have two points which could useful for future.
> > 
> > In a past I was solving similar problem (there are more possible
> > endpoint types in DT and hardcoding any of them cause replugging
> > issues). And the solution was to "improve" bootloader to load the DTB
> > file (from the storage) and then on-the-fly in RAM modify it to contains
> > current configuration of endpoint device. This allowed to boot new
> > kernel, and also old kernel without any modification of kernel or DTB
> > file. So it retained the established DT ABI for kernel too.
> 
> I think the patch here has two aspects here.
> 
> 1st is verification on which chip it does run, which is something we don't
> need discuss. This should be there forever. If nothing else, if different
> chip than declared one is detected, the driver should report big warning.
> This was missing.

My suggestion (but only for new things / drivers to prevent any
compatibility issues) is to report / return fatal probe errors when
verification fails.

> 2nd part is more tricky - having generic device-tree compatibles is
> something opposite what DT trying to achieve. Here it's more like "a
> workaround". The driver already loaded, using right i2c addr, it can easily
> switch the device version and it saves us a lot of troubles people have
> today (mostly for existing deployments).

Here we are trying to mix two opposite things: static device-tree with
non-static hotpluggable / repluggable hardware. Similar problem has any
hotpluggable bus (PCIe, USB, SDIO, ...) which needs to be described in
device-tree (because bus itself static and burn into the chipset itself)
but endpoint nodes on the bus in DT are non-static.

> We'll try to do some proper autodetection at bootloader level later
> (together with camera focus coil detection, which is provided by two vendors
> on different i2c addresses).

This is what I saw more times... because it solved problem of "generic DT"
and "hacks in kernel drivers" by completely hiding the problem from
kernel and DT files point of view.

> > 
> > If there are more requests for these replugging support in bq27xxx, what
> > about improving the whole bq27xxx driver to do autodetection of any
> > plugged battery and take any explicit device tree identifier as a
> > generic? If I remember correctly, it is not possible detect the whole
> > type, but at least something is possible. This could solve this problem
> > too, but would require some larger rewrite of driver. And it would make
> > sense only if there are more requests for such functionality. I agree
> > that it would probably do not make sense for one device.
> 
> By DT principles we shouldn't introduce any generic compatibles.

Yes. That is balancing between principles, real HW and how it is already
used by kernel drivers. I do not have any opinion for this as it looks
like that every solution would have some gaps or issues.

Sometimes the easiest (in a way of writing the code) solution is better
even if it does not fully match the design or principles.

> David
> 
> > 
> > I'm not opposing the change, I'm just writing ideas for future, maybe
> > they could be useful for some future decisions...
> > 
> > > Tested on OnePlus 6T (fajita) with DeviceType 0x0541: voltage, state of charge, and temperature were reported correctly. Testing on hardware with DeviceType 0x0421 would be appreciated.
> > > 
> > > Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> > > ---
> > > OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
> > > bq27541 fuel gauge. The latter requires a different register map and produces
> > > invalid battery readings when interpreted as a bq27411.
> > > 
> > > v4 drops the proposed generic DT compatible and DTS changes. The I2C driver
> > > instead reads DeviceType while probing the existing bq27411 compatible, and
> > > selects the bq27541 profile if the device reports 0x0541.
> > > 
> > > The bq27541 path was tested on a OnePlus 6T. Testing on an OnePlus 6 or 6T
> > > whose fuel gauge reports DeviceType 0x0421 (bq27411) would be appreciated.
> > > 
> > > Changes in v4:
> > > - Drop the generic compatible and binding update.
> > > - Keep the established OnePlus DTS unchanged.
> > > - Detect bq27541 from DeviceType in the bq27411 probe path.
> > > - Send as a new thread.
> > > ---
> > >   drivers/power/supply/bq27xxx_battery_i2c.c | 37 ++++++++++++++++++++++++++++++
> > >   1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> > > index 94b00bb89c17..732164423423 100644
> > > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> > > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> > > @@ -16,6 +16,11 @@
> > >   static DEFINE_IDR(battery_id);
> > >   static DEFINE_MUTEX(battery_mutex);
> > > +#define BQ27XXX_REG_CTRL		0x00
> > > +#define BQ27XXX_DEVICE_TYPE		0x0001
> > > +#define BQ27411_DEVICE_TYPE		0x0421
> > > +#define BQ27541_DEVICE_TYPE		0x0541
> > > +
> > >   static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
> > >   {
> > >   	struct bq27xxx_device_info *di = data;
> > > @@ -136,6 +141,32 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
> > >   	return 0;
> > >   }
> > > +static int bq27xxx_battery_i2c_check_device_type(struct bq27xxx_device_info *di)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_DEVICE_TYPE,
> > > +			    false);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = di->bus.read(di, BQ27XXX_REG_CTRL, false);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	switch (ret) {
> > > +	case BQ27411_DEVICE_TYPE:
> > > +		return 0;
> > > +	case BQ27541_DEVICE_TYPE:
> > > +		dev_warn(di->dev, "detected bq27541 instead of bq27411\n");
> > > +		di->chip = BQ27541;
> > > +		return 0;
> > > +	default:
> > > +		dev_err(di->dev, "unsupported device type 0x%04x\n", ret);
> > > +		return -ENODEV;
> > > +	}
> > > +}
> > > +
> > >   static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
> > >   				     const struct i2c_device_id *id)
> > >   {
> > > @@ -169,6 +200,12 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
> > >   	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
> > >   	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
> > > +	if (di->chip == BQ27411) {
> > > +		ret = bq27xxx_battery_i2c_check_device_type(di);
> > > +		if (ret)
> > > +			goto err_failed;
> > > +	}
> > > +
> > >   	ret = bq27xxx_battery_setup(di);
> > >   	if (ret)
> > >   		goto err_failed;
> > > 
> > > ---
> > > base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> > > change-id: 20260927-master-bd0afd9696ef
> > > 
> > > Best regards,
> > > --
> > > Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> > > 
> > > 
> 
