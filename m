Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92EF3E1225
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563599; cv=none; b=QyszA7UQmeVLrxNmlwodflbYqjwJgZbVJICkDf/hQwQX27hMCJacHtcTyb9yD9AAa/upoIAgxhpGTCqc5lkzca7+yqWvG3JvQCkpbnvuMs/7UyY0PY14HKHNF2U0QcXG0VguiyuyH96QkfVqVnNQSKLvE1ZFQdpNB14NjV7e+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563599; c=relaxed/simple;
	bh=Rl4gtFq9U9GnBRV2RK17LMlMovBDRPjRJ9dKTTad/Pc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TdX9RHK9y83ODWPYxM9zIKwH25ekHiwxscr+Yf6vkpEmh2e3gUvpdcpZfu/liad7Y6XhMKF0b/FjWjunP8UBaCkdsCg8sSUgpBvSKvgU1tfjq9xhxIUZ9B+2V9g22kAKg5KFQoEpuVGy+HXMfSs4Czwra0TNBMoCN/DCK7d3Dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=NZg7uAbH; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="NZg7uAbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1784563595;
 bh=4V1kLYIy9VLaH4izcRngdk5f4+oVLN80Pe1S3oyCuaM=;
 b=NZg7uAbHnm7eupu7n5GAhHFJKB3ygOZJsdrBm98QQNwClE/VmM4lf8H0X88dt/JWN+QWnDhKc
 5HDR+fiCSW9olhz3dRb8KjhsW2+OWRQ55EYlz+UXT1puuJhtqdLfInGGh4DtCWmo2M2V5894Oyf
 de/iBzGaXS1INnHA8ErLzb3Dz7gi/lss9EwhONJQLko9bCc8NBTQgyP/xV62no0S82eehUG2rWp
 XEP9vl337hMHFLJtSjnqYP5vgZDG0QmcB0+MN3ogUOXssHVF3Pu4FAuNJMbT1ew9loe/7303Qwb
 g72QD7+bTfKVcUWFTLjeP7LN1K3NWReCupzcZo1T1yVQ==
X-Forward-Email-ID: 6a5e473e79814abe71f8e3c1
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.11.4
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
Date: Mon, 20 Jul 2026 12:05:17 -0400
Message-Id: <DK3IYY2FP62G.2ZOAUMLYJP77P@ubuntu.com>
Subject: Re: [PATCH v2] cpufreq: apple-soc: Calculate frequency as a 64-bit
 value
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Sven Peter" <sven@kernel.org>,
 "Janne Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>
Cc: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>
In-Reply-To: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>

On Mon Jul 20, 2026 at 3:25 AM EDT, Sasha Finkelstein wrote:
> The current frequency calculation is done in 32 bit, causing problems
> if run on a future SoC that can boost higher than 4.2GHz. Ideally, we
> should use a true u64 instead of unsigned long and "knowning" that this
> only runs on 64 bit machines, but the core code uses ulong everywhere,
> so this should be good enough.
>
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
> Changes in v2:
> - Minor style fixes
> - Link to v1: https://patch.msgid.link/20260703-cpufreq-64-v1-1-c406c7053=
19a@chaosmail.tech
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-=
soc-cpufreq.c
> index 638e5bf72185..5ad274a1e6ae 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_poli=
cy *policy)
> =20
>  	/* Get OPP levels (p-state indexes) and stash them in driver_data */
>  	for (i =3D 0; freq_table[i].frequency !=3D CPUFREQ_TABLE_END; i++) {
> -		unsigned long rate =3D freq_table[i].frequency * 1000 + 999;
> +		unsigned long rate =3D freq_table[i].frequency * 1000UL + 999;
>  		struct dev_pm_opp *opp =3D dev_pm_opp_find_freq_floor(cpu_dev, &rate);
> =20
>  		if (IS_ERR(opp)) {
>
> ---
> base-commit: 4a50a141f05a8d1737661b19ee22ff8455b94409
> change-id: 20260703-cpufreq-64-2a23d7261e09
>
> Best regards,
> -- =20
> Sasha Finkelstein <k@chaosmail.tech>

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
