Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88743F4C2;
	Wed, 16 Sep 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544783; cv=pass; b=DdyemczmvVNAm8lGEsW7dNnJ5hcwyG/cADvgq6pSxoVYNC6D2E9QRilnFONdOpxffeVzzayeE3MwIHzY51QBA7e0mOoF03BOKk4BQs24nJ6GKdbsUz5Ru1MtArDgFNXFzMJ79eV/g3Ik0LqG2+bTcYSyvKZEyFks4Grl+/Vu6FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544783; c=relaxed/simple;
	bh=YBUfus+XNCppC1fUC8PEwDS1vqF8JmXi2sPKK3SldmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lGprknqWYoMHxyL6O+odnXcppuvXDGqQHLBIaIeRswOkrfkx8Vi+562iki4z6uLvkzJur7iGSMmVC/ynDMxeQIazVu4vg5oN9lqnzzbuR3YfbU0DD8RxRJc9Wyq7+ZNX9JUT3M/MreulaLoNz+rkrJi+UWprLUVJDgEZWHRIBkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=kBv2eWf7; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="kBv2eWf7"
ARC-Seal: i=1; a=rsa-sha256; t=1789544759; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bicAwNcqlnYhYXwpmmZnSvNtL9GrpsGfwWsQ5kG5eeCzVZ7TQuP55fWR4DcEuUeCpxD5SLPV+nhB+rXCNsq9trnBGKXUksvP3t2srO5DLqFiIEAXr50TytOcLWSKyiyhlVJdlTWOgWk1k8B14NuHfR+qfyFKzzEVIY/OUuSuf7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789544759; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OakTk0VunKlXKZUFe9I9vXFcYMZ7O3z0+fbdPF+B9VQ=; 
	b=mrKyofg2aEYdlu7uH2oIndPUw01vUGh8daGX7c4P0su8ZHRpLN48BCAvIv+y7Rfy2OyJE9TPur7n1oMR39x1IDAkDXr2WvB9jXG2G/NQ0mjreYLqX97Tae3kuUGJQOaUU03zoE4dO3IaetAiZi4czKdFMwa9wro1PW5cIxL9WxA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789544759;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=OakTk0VunKlXKZUFe9I9vXFcYMZ7O3z0+fbdPF+B9VQ=;
	b=kBv2eWf7SwCw+aAS2S2WvXxJRyhNo4qncZNkEMii5SQUv0MQRNnzsa6803cRlSHy
	FCWxxBlzZ8QjQdNzQbi4Ww2ImYPgwtsGT/iYGF8mnaiucbJcKBnDHCEK26ddF+KniL5
	AxVLc4U08kkkknD5VIqgqOIUq1kYapLe6ds0CuJZ9yEm0R6n7gcelpYDeL8PcS2v2OH
	ROz5GDiIAni+LKssyc+lluTGm/Gsv1jeHnsM8F0zVEYWBhpcFcEHBlCa7iCbkH7YoDx
	bhWq5TxWcRv+PhBkGnD6hUlWsVIE3PQffXfCcceA90KAi7eC/QX6Ks9F6YAc1ZJKYjo
	uxqTnja21g==
Received: by mx.zohomail.com with SMTPS id 1789544757952594.717334385658;
	Wed, 16 Sep 2026 00:45:57 -0700 (PDT)
Message-ID: <d081ce3c9f0b319e8d8cc41480c0d2862618eed6.camel@icenowy.me>
Subject: Re: [PATCH] power: reset: th1520-aon: send RPCs from sleepable
 handlers
From: Icenowy Zheng <uwu@icenowy.me>
To: Han Gao <gaohan@iscas.ac.cn>, Drew Fustini <fustini@kernel.org>, Guo Ren
	 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Sebastian Reichel
 <sre@kernel.org>,  Ulf Hansson <ulfh@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Han Gao
	 <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 15:45:52 +0800
In-Reply-To: <20260916-fix-xuantieaon-v1-1-c6dc530a4884@iscas.ac.cn>
References: <20260916-fix-xuantieaon-v1-1-c6dc530a4884@iscas.ac.cn>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2026-09-16=E4=B8=89=E7=9A=84 14:55 +0800=EF=BC=8CHan Gao=E5=86=99=
=E9=81=93=EF=BC=9A
> The AON RPC takes a mutex and waits for mailbox interrupts. The final
> sys-off handlers run on atomic notifier chains, where this can sleep
> with interrupts disabled.
>=20
> Send the requests from the preparation handlers before syscore
> shutdown.
> Retain a final power-off handler to advertise capability and report
> failure without issuing another RPC. Let other providers handle
> fallback.
>=20
> Report RPC errors and allow one second after a successful return for
> the
> asynchronous operation to take effect. This is a software fallback
> timeout, not a hardware timing requirement.
>=20
> Fixes: 2d81a24a74e5 ("driver: reset: th1520-aon: add driver for
> poweroff/reboot via AON FW")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
> =C2=A0drivers/power/reset/th1520-aon-reboot.c | 49
> +++++++++++++++++++++++----------
> =C2=A01 file changed, 34 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/reset/th1520-aon-reboot.c
> b/drivers/power/reset/th1520-aon-reboot.c
> index
> ec249667a0ffd74829357d57b9e63c3524ea3759..ace70491834dc9a63ed543427e4
> 0e4cbc0a9388f 100644
> --- a/drivers/power/reset/th1520-aon-reboot.c
> +++ b/drivers/power/reset/th1520-aon-reboot.c
> @@ -6,6 +6,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/auxiliary_bus.h>
> +#include <linux/delay.h>
> =C2=A0#include <linux/firmware/thead/thead,th1520-aon.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/notifier.h>
> @@ -14,37 +15,46 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0
> =C2=A0#define TH1520_AON_REBOOT_PRIORITY 200
> +/* Allow an accepted asynchronous command to take effect before
> fallback. */
> +#define TH1520_AON_REBOOT_TIMEOUT_MS 1000
> =C2=A0
> =C2=A0struct th1520_aon_msg_empty_body {
> =C2=A0	struct th1520_aon_rpc_msg_hdr hdr;
> =C2=A0	u16 reserved[12];
> =C2=A0} __packed __aligned(1);
> =C2=A0
> -static int th1520_aon_pwroff_handler(struct sys_off_data *data)
> +static int th1520_aon_reboot_request(struct sys_off_data *data, u8
> func)
> =C2=A0{
> =C2=A0	struct th1520_aon_chan *aon_chan =3D data->cb_data;
> =C2=A0	struct th1520_aon_msg_empty_body msg =3D {};
> +	int ret;
> =C2=A0
> =C2=A0	msg.hdr.svc =3D TH1520_AON_RPC_SVC_WDG;
> -	msg.hdr.func =3D TH1520_AON_WDG_FUNC_POWER_OFF;
> +	msg.hdr.func =3D func;
> =C2=A0	msg.hdr.size =3D TH1520_AON_RPC_MSG_NUM;
> =C2=A0
> -	th1520_aon_call_rpc(aon_chan, &msg);
> +	ret =3D th1520_aon_call_rpc(aon_chan, &msg);
> +	if (ret)
> +		dev_err(data->dev, "AON WDG command %u failed:
> %d\n", func, ret);
> +	else
> +		msleep(TH1520_AON_REBOOT_TIMEOUT_MS);
> =C2=A0
> =C2=A0	return NOTIFY_DONE;
> =C2=A0}
> =C2=A0
> -static int th1520_aon_restart_handler(struct sys_off_data *data)
> +static int th1520_aon_pwroff_handler(struct sys_off_data *data)
> =C2=A0{
> -	struct th1520_aon_chan *aon_chan =3D data->cb_data;
> -	struct th1520_aon_msg_empty_body msg =3D {};
> -
> -	msg.hdr.svc =3D TH1520_AON_RPC_SVC_WDG;
> -	msg.hdr.func =3D TH1520_AON_WDG_FUNC_RESTART;
> -	msg.hdr.size =3D TH1520_AON_RPC_MSG_NUM;
> +	return th1520_aon_reboot_request(data,
> TH1520_AON_WDG_FUNC_POWER_OFF);
> +}
> =C2=A0
> -	th1520_aon_call_rpc(aon_chan, &msg);
> +static int th1520_aon_restart_handler(struct sys_off_data *data)
> +{
> +	return th1520_aon_reboot_request(data,
> TH1520_AON_WDG_FUNC_RESTART);
> +}
> =C2=A0
> +static int th1520_aon_pwroff_failed(struct sys_off_data *data)
> +{
> +	dev_err(data->dev, "AON did not power off the system\n");
> =C2=A0	return NOTIFY_DONE;
> =C2=A0}
> =C2=A0
> @@ -54,8 +64,11 @@ static int th1520_aon_reboot_probe(struct
> auxiliary_device *adev,
> =C2=A0	struct device *dev =3D &adev->dev;
> =C2=A0	int ret;
> =C2=A0
> -	/* Expect struct th1520_aon_chan to be passed via
> platform_data */
> -	ret =3D devm_register_sys_off_handler(dev,
> SYS_OFF_MODE_POWER_OFF,
> +	/*
> +	 * RPC takes a mutex and waits for mailbox interrupts. Send
> after device
> +	 * shutdown, but before syscore shutdown and the final
> atomic callbacks.
> +	 */
> +	ret =3D devm_register_sys_off_handler(dev,
> SYS_OFF_MODE_POWER_OFF_PREPARE,

Interestingly I tried to find usage of this key in the kernel, and
found that the macsmc-reboot driver has a "enter_atomic" operation.

I don't know whether it's a overdesign.

The imx_rproc driver even creates its own PREPARE handler that "setup
mailbox to non-blocking mode".

Maybe it's better to replicate the behavior of macsmc / imx_rproc in
the AON driver?

> =C2=A0					=C2=A0=C2=A0=C2=A0
> TH1520_AON_REBOOT_PRIORITY,
> =C2=A0					=C2=A0=C2=A0=C2=A0
> th1520_aon_pwroff_handler,
> =C2=A0					=C2=A0=C2=A0=C2=A0 adev-
> >dev.platform_data);
> @@ -65,7 +78,7 @@ static int th1520_aon_reboot_probe(struct
> auxiliary_device *adev,
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	ret =3D devm_register_sys_off_handler(dev,
> SYS_OFF_MODE_RESTART,
> +	ret =3D devm_register_sys_off_handler(dev,
> SYS_OFF_MODE_RESTART_PREPARE,
> =C2=A0					=C2=A0=C2=A0=C2=A0
> TH1520_AON_REBOOT_PRIORITY,
> =C2=A0					=C2=A0=C2=A0=C2=A0
> th1520_aon_restart_handler,
> =C2=A0					=C2=A0=C2=A0=C2=A0 adev-
> >dev.platform_data);
> @@ -75,7 +88,13 @@ static int th1520_aon_reboot_probe(struct
> auxiliary_device *adev,
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	return 0;
> +	/*
> +	 * Advertise power-off capability to kernel_can_power_off().
> This final
> +	 * callback must not send RPCs; let other providers try if
> AON failed.
> +	 */
> +	return devm_register_sys_off_handler(dev,
> SYS_OFF_MODE_POWER_OFF,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> TH1520_AON_REBOOT_PRIORITY,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> th1520_aon_pwroff_failed, dev_get_platdata(dev));

I don't know whether such a handler is necessary when the real power
operation is done in PREPARE handler. The odroid-go-ultra-poweroff
driver, which also (ab?)uses PREPARE handler for powering off, doesn't
register a non-PREPARE handler.

Thanks,
Icenowy

> =C2=A0}
> =C2=A0
> =C2=A0static const struct auxiliary_device_id th1520_aon_reboot_id_table[=
]
> =3D {
>=20
> ---
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> change-id: 20260916-fix-xuantieaon-1ea016a22526
>=20
> Best regards,
