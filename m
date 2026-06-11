Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB82DA74C
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205057; cv=none; b=NJpNfJxOsnICFE6XN+Vosk9bucMSqy/S4Jg8AWxBbM2rCSdtn7DYQ2WF7G6F3891J+CE5oitgLVDrrF6VHTAYrhsXqBT449J50osxirbQtXyGdbKVJjLjbzyn9DAbDm58rPuHH7abwuT68aMrBW1q9uMZuorn9ECBx9zN78Zwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205057; c=relaxed/simple;
	bh=0TCn90LGl4aorULAmlbgfL/XCcWB2bkKndfvp6wcr80=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g21aTYoholy9pnQXxsWOvb/0FSWV1Ni9TPdYx3+4yE0NC454s+t//X6JbEgTkhXdkavPGY90h5d6g5aEICP0JNKfHVKQrQRr4XVohRSDqF5HmCd2H6L8Cjc6els5vwEQbzWzLCnYUDWlDNksTAWteiLZfiHOpVOAGPl8sW78z+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=f+DNgbbY; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="f+DNgbbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1781205049;
 bh=xY2cNNY93Hd/aQF2aaDrGjqQhuUcLY6qtCu0ziUky+g=;
 b=f+DNgbbYWp5lWf+xjRqnDPOCUQbcNhQ/TqDVM6nFg6ja7rirAL8fq0dqNZEnQXuES5PdcH3iW
 5U5LVseDVXgFHLWV4PR5RlmD3weU8+BkcaoN+M8Xv9rznytY8wvkNDHzXnoELHu6di8Q7HCKSnv
 1YX00c3lrYKJH+dfoNIXZi/c/p9Sy/Mg8bOL5K0iYxa8W7mtLAenrSyw5Nmtx063Fely9nFAUGr
 zcEO7zLrB0jUfMuUWe+VQgeYAjf4Q9ctyLWm5IGPyTt+Q7BELbWExOBz3bD5Ni38VtkEmYvHzM3
 0umJrjKgjoMAtohkSd3Qxq/wtLj4xJY+D09sWAaJjH8g==
X-Forward-Email-ID: 6a2b0837e66afcd719ced683
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Thu, 11 Jun 2026 15:10:44 -0400
Message-Id: <DJ6GHP5KU65S.32864AWLH5DGT@ubuntu.com>
Cc: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: macsmc: Support macOS 27 SMC firmware
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Sven Peter" <sven@kernel.org>,
 "Janne Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Sebastian
 Reichel" <sre@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech>
In-Reply-To: <20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech>

On Thu Jun 11, 2026 at 12:49 PM EDT, Sasha Finkelstein wrote:
> The SMC firmware included in macOS 27 changed the size of BCF0 key from
> 4 to 1 bytes. This key is used for indicating that battery state is
> critically low.
>
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
>  drivers/power/supply/macsmc-power.c | 34 +++++++++++++++++++++++++++++++=
---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/m=
acsmc-power.c
> index 33ca07460f3a..650dc8740f71 100644
> --- a/drivers/power/supply/macsmc-power.c
> +++ b/drivers/power/supply/macsmc-power.c
> @@ -86,6 +86,7 @@ struct macsmc_power {
>  	bool has_ch0i; /* Force discharge (Older firmware) */
>  	bool has_ch0c; /* Inhibit charge (Older firmware) */
>  	bool has_chte; /* Inhibit charge (Modern firmware) */
> +	bool bcf0_1byte; /* Battery critical */
> =20
>  	u8 num_cells;
>  	int nominal_voltage_mv;
> @@ -273,6 +274,18 @@ static int macsmc_battery_get_date(const char *s, in=
t *out)
>  	return 0;
>  }
> =20
> +static int macsmc_battery_read_bcf0(struct macsmc_power *power, u32 *val=
)
> +{
> +	u8 tval;
> +	int ret;
> +
> +	if (!power->bcf0_1byte)
> +		return apple_smc_read_u32(power->smc, SMC_KEY(BCF0), val);
> +	ret =3D apple_smc_read_u8(power->smc, SMC_KEY(BCF0), &tval);

Would I be ridiculous to suggest adding a newline after the return
statement?

> +	*val =3D tval;
> +	return ret;
> +}
> +
>  static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
>  {
>  	bool flag;
> @@ -280,7 +293,7 @@ static int macsmc_battery_get_capacity_level(struct m=
acsmc_power *power)
>  	int ret;
> =20
>  	/* Check for emergency shutdown condition */
> -	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val) >=3D 0 && val)
> +	if (macsmc_battery_read_bcf0(power, &val) >=3D 0 && val)
>  		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> =20
>  	/* Check AC status for whether we could boot in this state */
> @@ -577,7 +590,7 @@ static void macsmc_power_critical_work(struct work_st=
ruct *wrk)
>  	 * Check if SMC flagged the battery as empty.
>  	 * We trigger a graceful shutdown to let the OS save data.
>  	 */
> -	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) =3D=3D 0 && bc=
f0 !=3D 0) {
> +	if (macsmc_battery_read_bcf0(power, &bcf0) =3D=3D 0 && bcf0 !=3D 0) {
>  		power->orderly_shutdown_triggered =3D true;
>  		dev_crit(power->dev, "Battery critical (empty flag set). Triggering or=
derly shutdown.\n");
>  		orderly_poweroff(true);
> @@ -616,6 +629,7 @@ static int macsmc_power_probe(struct platform_device =
*pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct apple_smc *smc =3D dev_get_drvdata(pdev->dev.parent);
>  	struct power_supply_config psy_cfg =3D {};
> +	struct apple_smc_key_info info;
>  	struct macsmc_power *power;
>  	bool has_battery =3D false;
>  	bool has_ac_adapter =3D false;
