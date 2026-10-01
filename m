Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542337BE99
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860814; cv=none; b=kAWy6JPFYsvVBEDJtB9UhTQTtNsb3uv3uI0aizf7tROStD4YiGF3H/dVFbap7KU65f+WI7lwxk9hdEKLlbYrKeb3laGhIZlUeSo/lhWcbCJRdTR086vlfB5UYN5grAXpDGorNm4xJ+RUQrKmiKMOHcM9jU/CeOEPlxTc9m0sDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860814; c=relaxed/simple;
	bh=vr2coJh/M8MT+GMS6CaPfDga3N+ruYJlVCeTean26X4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZLpczWA4HQPLvhur2ry3s5vUxHYORGkk9mcxX51m7GKjUur+fw6AB36/xIxxfvkI+phnF94WizuFDXAtk3D6sPz3Nt0DFjUph4ToLqA4oZD8tog5CnI9zsAl9mTusKT5vEJfLoWdbN0syUY64KYa1YzztAiQgVGeKDQN+0gCNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ke90G8wP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqE1Bo8n; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ke90G8wP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqE1Bo8n"
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailflow.stl.internal (Postfix) with ESMTP id DE27A130091F
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 09:20:09 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 09:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1790860809;
	 x=1790868009; bh=mQ4zP97+FG2hf78OhHy44hJ/AnSiGnG7IrO0Y+DQ1aQ=; b=
	ke90G8wP+mJ2HgxjlfXMa4W/EEbPCjalxCUXUK3lieyJHP2Jv/ZW/Cv8H64CEEs9
	LDys2HIU4nflgplxm9kZ2B596/2asrlRdfNDdNyveusFcVWqAXqu0CQbuaJvU94W
	udJqXWTMlKKceUSi5L0rPjiDN1HX4Wx7ndGjaOOcUn4SwyncOppZ8Uwmn8AvOG3j
	MctZ6WZASmn7wAGmiknWJUiNJpDAHg83wFyisisVQBAiO41hTMc7Xebs8f33aW81
	+9LAO3t+L1efifKXxthshsBPbJat9dNLtIxclTBeWHItWa01cdnAOSDeOgXiy812
	kYm3YM9udUEACIATETU22g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790860809; x=
	1790868009; bh=mQ4zP97+FG2hf78OhHy44hJ/AnSiGnG7IrO0Y+DQ1aQ=; b=f
	qE1Bo8nM30lmesFf1OceOFTKzF9VhnLJwCxdoqM5gwfPVc7rPU2EhLgxZyd363i6
	4QuAzVq5ie/VBq7yAqRaoqVPZpA7+uFfUzi6RyqiTTBhHy5RViPZ/vyYlkQx9sam
	X8ocpN71/qF/Wj+CIQky6cyZYNB0tdZvYEnT1kkWCuKRGK8iUSMVPwGPBpElBB3b
	liQe9aJ7YNliLuB7YX/HacPmhH6eX0NDspW+J81fWfveSUXXN+RnQ5gSdCiExgXY
	+Fz0JMIo09roNqpt7/orLSUUAB2S2ULc0GhkI9e1OXYpCpPhr3wpNuLw4t6AyIvL
	MpH7ciatAbkrv4bezYCdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790860809; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:KWCVBDbKj36swSBM6qN0nQtX/ulIJvOsf2OY1R+EALaL75Z
	EJuH29u70cdu76CkjGwy2QedDwoF4AIS3NVsmoZq3IZoGxIy6tiEhzHEPe6HBka9
	n+CAhHj9ndk3mwxK+nPvUprGiZrIn+av5zrAjGi3Fv5EyIwL2v3ad4NqwBOaVt8b
	YILFUhLtftjm1NYHWKhKZ2Iq+hGWewcu9kfUlryU+NtLblV3j3eNTYjA39Vs4SG4
	/8S1BqeUDzcU1DIGZSQubcHCiEeY2CPgQsypWrsp4/ltfMdDkf3pU7eW/Yh924Cv
	rwULnQYINYj/uQLBYYYHXNTTPDOfs32FWF2rPcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ks+nsg7Ky+yOjSasAUy0OGmoglPdJ9vuAFVXPiHhVYg=:vr2coJh/M8MT+GMS6CaPfDga3N+ruYJlVCeTean26X4=;
X-ME-Sender: <xms:B16-ari5hep4qPjaDmS-zf6VwaskW0-_c5I9FjQ7Xfwgn1vWOTmRKw>
    <xme:B16-ai03-qC611ERzxG6rC7op5S-ydNXzAizhqR_FamfTA_e1dpUCembpNLmRq056
    C_fLkVjmaZn2FHz7ODJFsvYlmE2Ln11Tyorc0scvB_tsUKHqdcqizx_>
X-ME-Proxy-Cause: dmFkZTF9izM7GY1Qo4WuU1dcSvl5OqDPX5oHmM8SnaYu9+EnVmnQBq9lubBhTzM3MSY3uH
    nRBG5m2C66sYPtk7Op+odyiKAPdi3LeHYNTv9iG2/uAKJ+jwOxNRs9JHZ/HN/da0zSYGDr
    VtqFahnHF4xS8AJgXdTY7v0siIQN18aePRSjCeIhObadkgfwxJvjrWE3yohEUf+GawkhYS
    MZ4T7uSlZY+jawSLkZuU4Nme9NYS/RxKkQlXakvhWGETNOolfePEzMMrfChRXn3Xtu310X
    yavTBrRok9SXYDvYEeuVFnRccTIoiGz7LPY6FKJNt5bsm1zRIGurEPF54FtXGD5zAJtmL5
    FtkXddzRKeSw758yZMLu7cXdq7RIifqNpUlDZvxt2r26kmcVqK3nvoJK7VNKbTvfF9SA2A
    8n3gnW70jEdo6fbMaaWkSI6nJKLgbI/Z9Tqb75uWZ6/k2g/jpfk5Jo6tRf/AYsgDZhkSeZ
    htLJmn+ZkKlltLvMJi+Q4uQ/ulvegb+ZWlhAJdsMmtsAShYFmK6yUsEJSRRujnJxRi2K9U
    AASP0CYEjw8fUzLRd3r8+hTNAUHM7xU58KnLPC9HQ1MGPjgAHUlfkugY2+nX6nlxT4/O4s
    mXtw3ppOWS6iL4trJMEP7k6vZiyTcs1tXVkGD4hddBJQGiDH9mRVVczrBaxQ
X-ME-Proxy: <xmx:B16-atOsg1ubDYspOXGC9ykNcDwJNcXnyNnXlURRdxUIDFmYhTMJVQ>
    <xmx:B16-agJEL05_rDPIq3dgeKwJPRrgP5PIwKQniZJgQKVGsYsqfeyWxw>
    <xmx:B16-au4l9YIs38GaeueqGzypGSIz7vps2Hu9P1S5ATrWRDconrKAyQ>
    <xmx:B16-alTxXLRfPGuhWORYJEQ15KAFwvUBLXnyhC8pWJdaU6gPcm7Vyw>
    <xmx:CV6-ahbQNTaxxTClyQcXiwZ7BXLvjXoOB8Ievp79nFyHnzbwn4zeoC9v>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 3B8AE2C0006F; Thu,  1 Oct 2026 09:20:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR3dAkJBooek
Date: Thu, 01 Oct 2026 09:19:47 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Jordan Brough" <jordan@brough.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>,
 "Denis Benato" <denis.benato@linux.dev>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Antheas Kapenekakis" <lkml@antheas.dev>,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Armin Wolf" <W_Armin@gmx.de>, "Jonathan Woithe" <jwoithe@just42.net>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Ike Panhc" <ikepanhc@gmail.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Matan Ziv-Av" <matan@svgalib.org>, "Nikita Kravets" <teackot@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 "Joshua Grisham" <josh@joshuagrisham.com>,
 "Jeremy Soller" <jeremy@system76.com>,
 "System76 Product Development" <productdev@system76.com>,
 "Azael Avalos" <coproscefalo@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Benson Leung" <bleung@chromium.org>,
 "Guenter Roeck" <groeck@chromium.org>,
 "Sebastian Reichel" <sre@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 ibm-acpi-devel@lists.sourceforge.net, chrome-platform@lists.linux.dev,
 linux-pm@vger.kernel.org
Message-Id: <fe57f538-5663-4fd9-aa3b-2fb77942f4b6@app.fastmail.com>
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
References: <20260930222650.1883805-1-jordan@brough.org>
 <20260930222650.1883805-2-jordan@brough.org>
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery hook API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2026, at 6:26 PM, Jordan Brough wrote:
> Rename battery_hook_register(), battery_hook_unregister() and
> devm_battery_hook_register() to acpi_battery_hook_register(),
> acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
> that the exported ACPI battery hook API has a consistent namespace, and
> update all in-tree callers.
>
> No functional change.
>
> Signed-off-by: Jordan Brough <jordan@brough.org>
> ---
>  drivers/acpi/battery.c                       | 30 ++++++++++----------
>  drivers/platform/x86/asus-wmi.c              |  4 +--
>  drivers/platform/x86/ayaneo-ec.c             |  2 +-
>  drivers/platform/x86/dell/dell-laptop.c      |  4 +--
>  drivers/platform/x86/dell/dell-wmi-ddv.c     |  2 +-
>  drivers/platform/x86/fujitsu-laptop.c        |  4 +--
>  drivers/platform/x86/huawei-wmi.c            |  4 +--
>  drivers/platform/x86/lenovo/ideapad-laptop.c |  4 +--
>  drivers/platform/x86/lenovo/thinkpad_acpi.c  |  4 +--
>  drivers/platform/x86/lenovo/wmi-other.c      |  4 +--
>  drivers/platform/x86/lg-laptop.c             |  4 +--
>  drivers/platform/x86/msi-ec.c                |  4 +--
>  drivers/platform/x86/oxpec.c                 |  2 +-
>  drivers/platform/x86/samsung-galaxybook.c    |  3 +-
>  drivers/platform/x86/samsung-laptop.c        |  4 +--
>  drivers/platform/x86/system76_acpi.c         |  4 +--
>  drivers/platform/x86/toshiba_acpi.c          |  4 +--
>  drivers/platform/x86/uniwill/uniwill-acpi.c  |  2 +-
>  drivers/power/supply/cros_charge-control.c   |  2 +-
>  include/acpi/battery.h                       |  7 +++--
>  20 files changed, 50 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 8599949f8786..306bb2088ca6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -821,7 +821,7 @@ static LIST_HEAD(acpi_battery_list);
>  static LIST_HEAD(battery_hook_list);
>  static DEFINE_MUTEX(hook_mutex);
> 
> -static void battery_hook_unregister_unlocked(struct acpi_battery_hook 
> *hook)
> +static void acpi_battery_hook_unregister_unlocked(struct 
> acpi_battery_hook *hook)
>  {
>  	struct acpi_battery *battery;
> 
> @@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct 
> acpi_battery_hook *hook)
>  	pr_info("hook unregistered: %s\n", hook->name);
>  }
> 
> -void battery_hook_unregister(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
>  	mutex_lock(&hook_mutex);
>  	/*
> @@ -847,13 +847,13 @@ void battery_hook_unregister(struct 
> acpi_battery_hook *hook)
>  	 * adding a new battery.
>  	 */
>  	if (!list_empty(&hook->list))
> -		battery_hook_unregister_unlocked(hook);
> +		acpi_battery_hook_unregister_unlocked(hook);
> 
>  	mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_unregister);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
> 
> -void battery_hook_register(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
>  {
>  	struct acpi_battery *battery;
> 
> @@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  			 * hooks.
>  			 */
>  			pr_err("hook failed to load: %s", hook->name);
> -			battery_hook_unregister_unlocked(hook);
> +			acpi_battery_hook_unregister_unlocked(hook);
>  			goto end;
>  		}
> 
> @@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  end:
>  	mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_register);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
> 
> -static void devm_battery_hook_unregister(void *data)
> +static void devm_acpi_battery_hook_unregister(void *data)
>  {
>  	struct acpi_battery_hook *hook = data;
> 
> -	battery_hook_unregister(hook);
> +	acpi_battery_hook_unregister(hook);
>  }
> 
> -int devm_battery_hook_register(struct device *dev, struct 
> acpi_battery_hook *hook)
> +int devm_acpi_battery_hook_register(struct device *dev, struct 
> acpi_battery_hook *hook)
>  {
> -	battery_hook_register(hook);
> +	acpi_battery_hook_register(hook);
> 
> -	return devm_add_action_or_reset(dev, devm_battery_hook_unregister, hook);
> +	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister, hook);
>  }
> -EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
> 
>  /*
>   * This function gets called right after the battery sysfs
> @@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct 
> acpi_battery *battery)
>  			 */
>  			pr_err("error in hook, unloading: %s",
>  					hook_node->name);
> -			battery_hook_unregister_unlocked(hook_node);
> +			acpi_battery_hook_unregister_unlocked(hook_node);
>  		}
>  	}
>  	mutex_unlock(&hook_mutex);
> @@ -961,7 +961,7 @@ static void __exit battery_hook_exit(void)
>  	 * need to remove the hooks.
>  	 */
>  	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -		battery_hook_unregister(hook);
> +		acpi_battery_hook_unregister(hook);
>  	}
>  	mutex_destroy(&hook_mutex);
>  }
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index a65090429ca7..c274f456863c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct 
> asus_wmi *asus)
>  	asus->battery_rsoc_available = false;
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
>  		asus->battery_rsoc_available = true;
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
>  	}
>  }
> 
>  static void asus_wmi_battery_exit(struct asus_wmi *asus)
>  {
>  	if (asus->battery_rsoc_available)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  }
> 
>  /* LEDs 
> ***********************************************************************/
> diff --git a/drivers/platform/x86/ayaneo-ec.c 
> b/drivers/platform/x86/ayaneo-ec.c
> index 41a24e091248..3ba87bd16c9a 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -493,7 +493,7 @@ static int ayaneo_ec_probe(struct platform_device 
> *pdev)
>  		data->battery_hook.add_battery = ayaneo_add_battery;
>  		data->battery_hook.remove_battery = ayaneo_remove_battery;
>  		data->battery_hook.name = "Ayaneo Battery";
> -		ret = devm_battery_hook_register(&pdev->dev, &data->battery_hook);
> +		ret = devm_acpi_battery_hook_register(&pdev->dev, 
> &data->battery_hook);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/platform/x86/dell/dell-laptop.c 
> b/drivers/platform/x86/dell/dell-laptop.c
> index 89e85c7f7132..cad2bd06f28a 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct 
> device *dev)
>  	battery_supported_modes = battery_get_supported_modes();
> 
>  	if (battery_supported_modes != 0)
> -		battery_hook_register(&dell_battery_hook);
> +		acpi_battery_hook_register(&dell_battery_hook);
>  }
> 
>  static void dell_battery_exit(void)
>  {
>  	if (battery_supported_modes != 0)
> -		battery_hook_unregister(&dell_battery_hook);
> +		acpi_battery_hook_unregister(&dell_battery_hook);
>  }
> 
>  static int __init dell_init(void)
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c 
> b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index f8903ced461b..6f0504d7519e 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -972,7 +972,7 @@ static int dell_wmi_ddv_battery_add(struct 
> dell_wmi_ddv_data *data)
>  	data->eppid_attr.attr.mode = 0444;
>  	data->eppid_attr.show = eppid_show;
> 
> -	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(&data->wdev->dev, &data->hook);
>  }
> 
>  static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum 
> dell_ddv_method method)
> diff --git a/drivers/platform/x86/fujitsu-laptop.c 
> b/drivers/platform/x86/fujitsu-laptop.c
> index ea543deef68f..96e74c4fdb29 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -267,7 +267,7 @@ static int 
> fujitsu_battery_charge_control_add(struct device *dev)
>  		return -ENODEV;
> 
>  	priv->charge_control_supported = true;
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
> 
>  	return 0;
>  }
> @@ -277,7 +277,7 @@ static void 
> fujitsu_battery_charge_control_remove(struct device *dev)
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
> 
>  	if (priv->charge_control_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  }
> 
>  /* Hardware access for LCD brightness control */
> diff --git a/drivers/platform/x86/huawei-wmi.c 
> b/drivers/platform/x86/huawei-wmi.c
> index d6aaf14d66a5..8cc0e900e984 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -512,7 +512,7 @@ static void huawei_wmi_battery_setup(struct device 
> *dev)
>  		return;
>  	}
> 
> -	battery_hook_register(&huawei_wmi_battery_hook);
> +	acpi_battery_hook_register(&huawei_wmi_battery_hook);
>  	device_create_file(dev, &dev_attr_charge_control_thresholds);
>  }
> 
> @@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *dev)
>  	struct huawei_wmi *huawei = dev_get_drvdata(dev);
> 
>  	if (huawei->battery_available) {
> -		battery_hook_unregister(&huawei_wmi_battery_hook);
> +		acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
>  		device_remove_file(dev, &dev_attr_charge_control_thresholds);
>  	}
>  }
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c 
> b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 8213524504ee..1d90d4591641 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct 
> ideapad_private *priv)
>  			priv->battery_hook.remove_battery = ideapad_battery_remove;
>  			priv->battery_hook.name = "Ideapad Battery Extension";
> 
> -			err = devm_battery_hook_register(&priv->platform_device->dev,
> -							 &priv->battery_hook);
> +			err = devm_acpi_battery_hook_register(&priv->platform_device->dev,
> +							      &priv->battery_hook);
>  			if (err)
>  				return err;
>  		}
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c 
> b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> index 1661f070c571..eb5ad18855db 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct 
> ibm_init_struct *ibm)
>  					battery_quirk_table,
>  					ARRAY_SIZE(battery_quirk_table));
> 
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  	return 0;
>  }
> 
>  static void tpacpi_battery_exit(void)
>  {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  }
> 
>  static struct ibm_struct battery_driver_data = {
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c 
> b/drivers/platform/x86/lenovo/wmi-other.c
> index fbb32bf404f2..0450634ac1dd 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -946,7 +946,7 @@ static void lwmi_om_psy_ext_init(struct 
> lwmi_om_priv *priv)
>  	priv->battery_hook.name = "Lenovo WMI Other Battery Extension";
>  	priv->bh_registered = true;
> 
> -	battery_hook_register(&priv->battery_hook);
> +	acpi_battery_hook_register(&priv->battery_hook);
>  }
> 
>  /**
> @@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv *priv)
>  	if (!priv->bh_registered)
>  		return;
> 
> -	battery_hook_unregister(&priv->battery_hook);
> +	acpi_battery_hook_unregister(&priv->battery_hook);
>  	priv->bh_registered = false;
>  }
> 
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 36ad1e269443..e788671307c4 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_platform_device;
> 
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
> 
>  	return 0;
> 
> @@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *pdev)
>  {
>  	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
> 
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  	platform_device_unregister(pf_device);
>  	pf_device = NULL;
>  	platform_driver_unregister(&pf_driver);
> diff --git a/drivers/platform/x86/msi-ec.c b/drivers/platform/x86/msi-ec.c
> index 566dfc73cb67..cb30a1d5b546 100644
> --- a/drivers/platform/x86/msi-ec.c
> +++ b/drivers/platform/x86/msi-ec.c
> @@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
>  	if (result < 0)
>  		return result;
> 
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  	return 0;
>  }
> 
>  static void __exit msi_ec_exit(void)
>  {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  }
> 
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 34bb17fca148..318f194e72b5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  		return PTR_ERR(hwdev);
> 
>  	if (oxp_psy_ext_supported()) {
> -		ret = devm_battery_hook_register(dev, &battery_hook);
> +		ret = devm_acpi_battery_hook_register(dev, &battery_hook);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/platform/x86/samsung-galaxybook.c 
> b/drivers/platform/x86/samsung-galaxybook.c
> index 99f72b204a51..a4f7dbb76214 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct 
> samsung_galaxybook *galaxybo
>  	galaxybook->battery_hook.remove_battery = galaxybook_battery_remove;
>  	galaxybook->battery_hook.name = "Samsung Galaxy Book Battery 
> Extension";
> 
> -	return devm_battery_hook_register(&galaxybook->platform->dev, 
> &galaxybook->battery_hook);
> +	return devm_acpi_battery_hook_register(&galaxybook->platform->dev,
> +					       &galaxybook->battery_hook);
>  }
> 
>  /*
> diff --git a/drivers/platform/x86/samsung-laptop.c 
> b/drivers/platform/x86/samsung-laptop.c
> index 710f3d5bf84c..43fa1dc2773c 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1142,8 +1142,8 @@ static int __init 
> samsung_battery_hook_init(struct samsung_laptop *samsung)
>  		samsung->battery_hook.add_battery = samsung_battery_add;
>  		samsung->battery_hook.remove_battery = samsung_battery_remove;
>  		samsung->battery_hook.name = "Samsung Battery Extension";
> -		retval = devm_battery_hook_register(&samsung->platform_device->dev,
> -						    &samsung->battery_hook);
> +		retval = 
> devm_acpi_battery_hook_register(&samsung->platform_device->dev,
> +							 &samsung->battery_hook);
>  	}
> 
>  	return retval;
> diff --git a/drivers/platform/x86/system76_acpi.c 
> b/drivers/platform/x86/system76_acpi.c
> index dd7b1b07c316..33968b61f0b2 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -288,12 +288,12 @@ static struct acpi_battery_hook 
> system76_battery_hook = {
> 
>  static void system76_battery_init(void)
>  {
> -	battery_hook_register(&system76_battery_hook);
> +	acpi_battery_hook_register(&system76_battery_hook);
>  }
> 
>  static void system76_battery_exit(void)
>  {
> -	battery_hook_unregister(&system76_battery_hook);
> +	acpi_battery_hook_unregister(&system76_battery_hook);
>  }
> 
>  // Get the airplane mode LED brightness
> diff --git a/drivers/platform/x86/toshiba_acpi.c 
> b/drivers/platform/x86/toshiba_acpi.c
> index a0b8060836d0..4cc879bc267a 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3301,7 +3301,7 @@ static void toshiba_acpi_remove(struct 
> platform_device *pdev)
>  	}
> 
>  	if (dev->battery_charge_mode_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
> 
>  	if (toshiba_acpi)
>  		toshiba_acpi = NULL;
> @@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct 
> platform_device *pdev)
>  	 * set, this must be done after toshiba_acpi is assigned.
>  	 */
>  	if (dev->battery_charge_mode_supported)
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
> 
>  	return 0;
> 
> diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c 
> b/drivers/platform/x86/uniwill/uniwill-acpi.c
> index 7a2eeaec4c96..d76695c2c765 100644
> --- a/drivers/platform/x86/uniwill/uniwill-acpi.c
> +++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
> @@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct 
> uniwill_data *data)
>  	data->hook.add_battery = uniwill_add_battery;
>  	data->hook.remove_battery = uniwill_remove_battery;
> 
> -	return devm_battery_hook_register(data->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(data->dev, &data->hook);
>  }
> 
>  static int uniwill_notifier_call(struct notifier_block *nb, unsigned 
> long action, void *dummy)
> diff --git a/drivers/power/supply/cros_charge-control.c 
> b/drivers/power/supply/cros_charge-control.c
> index e0f168624807..1901bbcffd73 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -315,7 +315,7 @@ static int cros_chctl_probe(struct platform_device 
> *pdev)
>  	if (ret < 0)
>  		return ret;
> 
> -	return devm_battery_hook_register(dev, &priv->battery_hook);
> +	return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
>  }
> 
>  static const struct platform_device_id cros_chctl_id[] = {
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index c93f16dfb944..08c7e37996bf 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -18,8 +18,9 @@ struct acpi_battery_hook {
>  	struct list_head list;
>  };
> 
> -void battery_hook_register(struct acpi_battery_hook *hook);
> -void battery_hook_unregister(struct acpi_battery_hook *hook);
> -int devm_battery_hook_register(struct device *dev, struct 
> acpi_battery_hook *hook);
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook);
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_acpi_battery_hook_register(struct device *dev,
> +				    struct acpi_battery_hook *hook);
> 
>  #endif
> -- 
> 2.56.0

For the lenovo/* changes:

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
