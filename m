Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2F17A300;
	Tue, 14 Jul 2026 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025439; cv=none; b=e872dGqIhuGc/qRm089Vr/x8fsNngkGemJmqzbDFSfYpLUqnNyrw5KKkkLJJh3Ec9Y/19/uMNKCnFvsBzbFQKmRqijRVBumsViSiKO+hOdSv/JLWDLKDftlWtX/hrLyKT+BvuddEMOzHcY3f3v6b9oHwg1GJZSm6FYT0+Y1TUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025439; c=relaxed/simple;
	bh=ddjug4FRAhzqNcIheOQuVpJhXkcdJhc8oo8KHgQqags=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=LsuBx+nq01jz5EitlSuLBkNokHvh6HiOUAlZgmwtyLyXjSnHk1IgwjSGZhx/64JCOxrdMIFJopVw9Cwax0zhmzwzukSFdbZFR/in+1TaqEhTRHsRtb5D6MAZAVC629DEDYXXlZLgENCufN4eKr1awIBNPbAnkZ11cyn43Vkgqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yjCk071X; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=V5T5SpTd; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yjCk071X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V5T5SpTd"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gzwjR2vkfzKngL;
	Tue, 14 Jul 2026 12:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784025435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fJftTlqcE8eGqPtuk9WNWMOkdgjG7MBJckMaW+Ctd4=;
	b=yjCk071X+S4HfzaHmqtjhvuSeEbGlGnYTbaY9AzfBzULBfWei2jZwsSwtScHtZ3WtJuVKz
	DkIK3HyDU6JOLOhI+zu/38QN3BeaEX4gHoE7JFTJWPShdJf2WfTm7tiLUtGfmK+cIykg/E
	+e1qlSXSs6GRBYVotVNAa+rO8bq6p4brai7k4VaQsBZW/v2qN7IoMS2bu1hDSXb1AQ3+2C
	13e60lwZYNqxvsr2CY1yxcOpeGQY8KIE+LHGFL0H1mgpaNmTX2jz6sALoSI7j9gSrf+8Ai
	O0G4hwMGpPJy/my2bbXjA8pxRey7qNCUR7Npro88+gpDXPBvIe6r23YgBX2UPQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784025433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fJftTlqcE8eGqPtuk9WNWMOkdgjG7MBJckMaW+Ctd4=;
	b=V5T5SpTduNeivrpuenzg45SjjTyc8GkSKnn3uTMiGldsqUP9gNRJl0cyId5d+yelfTi6XT
	rPVPXo6uc+6yxydWEMrHqmFOt+4Bx05i+amAk+2zQ6YllKqiWAt3qM05J8thgofCGFxN8x
	Y+BHe4jy2Nurb6fFVRK/JHL8kw+sXEuRtaxTL94eS8ukPBxJ4JtjPsBWE4nftpG6JbgfDU
	7EnIfrppq1zILJ81GDS9DPuvQkidImOdidp6OONjdFJ65eXuHA0RM3Lf8oNTmqYjKJaWfQ
	wBDVophvGdyV1fv1B8Qv8ocj/hJG7lS6twlj7eHIXzZdWnR6COg4o3vygmEjkw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 18:36:59 +0800
Message-Id: <DJY88BBD7RCM.20K3BATZ6JIM7@mailbox.org>
Subject: Re: [PATCH] thermal: spacemit: k1: disable hardware on driver
 remove
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, <dlan@kernel.org>,
 <rafael@kernel.org>, <troy.mitchell@linux.spacemit.com>,
 <shuwei.wu@mailbox.org>, <linux-pm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
References: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn>
In-Reply-To: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn>
X-MBO-RS-META: dawor4uopnap8bhihc8hfk6snj5jbmo4
X-MBO-RS-ID: 9c12ea2705f8e50f429

Hi Pei,

On Mon Jul 13, 2026 at 4:32 PM CST, Pei Xiao wrote:
> The driver uses devm_request_threaded_irq() but never disables the
> hardware interrupt enable, sensor enable, or sensor power bits when
> the driver is unbound.
>
> Add a devm action that clears K1_TSENSOR_INT_EN_REG,
> K1_TSENSOR_EN_ALL, and K1_TSENSOR_PCTRL_ENABLE on remove, mirroring
> what k1_tsensor_init() sets up.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/thermal/spacemit/k1_tsensor.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spac=
emit/k1_tsensor.c
> index 79222d233129..cf79dc7d403f 100644
> --- a/drivers/thermal/spacemit/k1_tsensor.c
> +++ b/drivers/thermal/spacemit/k1_tsensor.c
> @@ -199,6 +199,29 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, vo=
id *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void k1_tsensor_shutdown(struct k1_tsensor *ts)
> +{
> +	u32 val;
> +
> +	/* Disable all interrupts */
> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
> +
> +	/* Disable all sensor */
> +	val =3D readl(ts->base + K1_TSENSOR_EN_REG);
> +	val &=3D ~K1_TSENSOR_EN_ALL;
> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
> +
> +	/* Power down the sensor module */
> +	val =3D readl(ts->base + K1_TSENSOR_PCTRL_REG);
> +	val &=3D ~K1_TSENSOR_PCTRL_ENABLE;
> +	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
> +}
> +
> +static void devm_k1_tsensor_shutdown(void *data)
> +{
> +	k1_tsensor_shutdown(data);
> +}
> +
>  static int k1_tsensor_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -229,6 +252,10 @@ static int k1_tsensor_probe(struct platform_device *=
pdev)
> =20
>  	k1_tsensor_init(ts);
> =20
> +	ret =3D devm_add_action_or_reset(dev, devm_k1_tsensor_shutdown, ts);
> +	if (ret)
> +		return ret;
> +
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;

Sorry, I missed the hardware cleanup in the original driver.
Thanks for fixing it.

I also found that registering the shutdown action immediately after
k1_tsensor_init() would cause the thermal zones to be released before
the IRQ during devres cleanup. The IRQ thread may then access an
unregistered thermal zone.

I changed the order so that the thermal zones are registered first,
followed by the IRQ and the shutdown action.
On removal, the hardware interrupt is disabled first, then the IRQ
is released, and finally the thermal zones are released.

-> % git --no-pager diff drivers/thermal/spacemit/k1_tsensor.c
diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacem=
it/k1_tsensor.c
index 79222d233129..57dbc652a405 100644
--- a/drivers/thermal/spacemit/k1_tsensor.c
+++ b/drivers/thermal/spacemit/k1_tsensor.c
@@ -199,6 +199,32 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, void=
 *data)
 	return IRQ_HANDLED;
 }

+static void k1_tsensor_shutdown(struct k1_tsensor *ts)
+{
+	u32 val;
+
+	/* Disable all interrupts */
+	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
+
+	/* Disable all sensors */
+	val =3D readl(ts->base + K1_TSENSOR_EN_REG);
+	val &=3D ~K1_TSENSOR_EN_ALL;
+	writel(val, ts->base + K1_TSENSOR_EN_REG);
+
+	/* Clear the sampling configuration set by k1_tsensor_init(). */
+	val =3D readl(ts->base + K1_TSENSOR_TIME_REG);
+	val &=3D ~(K1_TSENSOR_TIME_FILTER_PERIOD |
+		 K1_TSENSOR_TIME_ADC_CNT_RST |
+		 K1_TSENSOR_TIME_WAIT_REF_CNT);
+	writel(val, ts->base + K1_TSENSOR_TIME_REG);
+
+	/* Clear the control bits configured by k1_tsensor_init(). */
+	val =3D readl(ts->base + K1_TSENSOR_PCTRL_REG);
+	val &=3D ~(K1_TSENSOR_PCTRL_RAW_SEL |
+		 K1_TSENSOR_PCTRL_TEMP_MODE |
+		 K1_TSENSOR_PCTRL_HW_AUTO_MODE |
+		 K1_TSENSOR_PCTRL_ENABLE);
+	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
+}
+
+static void devm_k1_tsensor_shutdown(void *data)
+{
+	k1_tsensor_shutdown(data);
+}
+
 static int k1_tsensor_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -229,34 +255,48 @@ static int k1_tsensor_probe(struct platform_device *p=
dev)

 	k1_tsensor_init(ts);

-	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret =3D devm_request_threaded_irq(dev, irq, NULL,
-					k1_tsensor_irq_thread,
-					IRQF_ONESHOT, "k1_tsensor", ts);
-	if (ret < 0)
-		return ret;
-
 	for (i =3D 0; i < MAX_SENSOR_NUMBER; ++i) {
 		ts->ch[i].id =3D i;
 		ts->ch[i].ts =3D ts;
 		ts->ch[i].tzd =3D devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_=
tsensor_ops);
-		if (IS_ERR(ts->ch[i].tzd))
-			return PTR_ERR(ts->ch[i].tzd);
+		if (IS_ERR(ts->ch[i].tzd)) {
+			ret =3D PTR_ERR(ts->ch[i].tzd);
+			goto err_shutdown;
+		}

 		/* Attach sysfs hwmon attributes for userspace monitoring */
 		ret =3D devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
 		if (ret)
 			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+	}

-		k1_tsensor_enable_irq(ts->ch + i);
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		goto err_shutdown;
 	}

+	ret =3D devm_request_threaded_irq(dev, irq, NULL,
+					k1_tsensor_irq_thread,
+					IRQF_ONESHOT, "k1_tsensor", ts);
+	if (ret < 0)
+		goto err_shutdown;
+
+	ret =3D devm_add_action_or_reset(dev, devm_k1_tsensor_shutdown, ts);
+	if (ret)
+		return ret;
+
+	/* Enable interrupts only after all zones and the handler are ready. */
+	for (i =3D 0; i < MAX_SENSOR_NUMBER; ++i)
+		k1_tsensor_enable_irq(ts->ch + i);
+
 	platform_set_drvdata(pdev, ts);

 	return 0;
+
+err_shutdown:
+	k1_tsensor_shutdown(ts);
+	return ret;
 }

 static const struct of_device_id k1_tsensor_dt_ids[] =3D {

--=20
Best regards,
Shuwei Wu
