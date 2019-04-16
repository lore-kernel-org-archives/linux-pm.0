Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF7C10F14
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 07:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43C82073F
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 07:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qCSofiEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfDPHQg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:16:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34260 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfDPHQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 03:16:35 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190416071631epoutp0172fef52f94864a5882623c19b29f80b8~V4yRARgTv2847328473epoutp01S
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2019 07:16:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190416071631epoutp0172fef52f94864a5882623c19b29f80b8~V4yRARgTv2847328473epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555398991;
        bh=dde/p7yO/I/1JqQ5W6bj3i3di08LAJB9gbKNIwdjoCE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qCSofiExKNpOdQrASlM+GcaFZ35Y42JO3s2I7THF1UurnL3AVXaMYHARlVtFZ0GId
         o2FtozNBQ9LTJ+3jDoOgMEqt4/slMZUOD8uHkQXHSzgtz6urK4X6+efgM9r+nnoofc
         yRirZ4BszJXD4ToZuo+vqNkhFpnydFDv5KA1ivOg=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416071628epcas1p2fd18aa4a1d3e1bc440a2f0a4d53f85a5~V4yOcdOF-1680716807epcas1p2i;
        Tue, 16 Apr 2019 07:16:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.BF.04257.A4185BC5; Tue, 16 Apr 2019 16:16:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190416071625epcas1p25204b912c8484ea796bf15cc7eddb0c7~V4yL_ZKWY1974619746epcas1p2r;
        Tue, 16 Apr 2019 07:16:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416071625epsmtrp2b9518bda8b8a9b5ac3c7b352085cea5d~V4yL9krm40857808578epsmtrp2p;
        Tue, 16 Apr 2019 07:16:25 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-87-5cb5814a0736
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.51.03692.94185BC5; Tue, 16 Apr 2019 16:16:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416071625epsmtip18757936431a34ea6b973368ac9509111~V4yLutz7i2091420914epsmtip1H;
        Tue, 16 Apr 2019 07:16:25 +0000 (GMT)
Subject: Re: [PATCH v2 13/19] PM / devfreq: tegra: Mark ACTMON's governor as
 immutable
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6df81b00-8d6a-8aca-d191-8a214a50232c@samsung.com>
Date:   Tue, 16 Apr 2019 16:17:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-14-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO7vb9Sotb8vs1/5IvRGRYO3qVtdwYiiySkp60WO0bu6i4l7t
        bpI9oLIyh1ohlU4zaxpqlBWzdGmiRS/sQZFlNrIH0QsrzSijbNtd5H+f8zvf7+93vuccApOd
        w+VErsnGWU2sgcLDxJeuzYmLW7K7Rat43yhhznx9jZi9zlNi5u6eTyHMI081zgyXXkdM8Tcn
        zvTvbsCZn54aMVN29iGeEqpp9dYhTZvTG6IpLRzENWXuJqQZvjgjU7I+LymHY/WcNZozZZn1
        uaZsNbV0pS5Vp5qvoOPoRGYBFW1ijZyaSsvIjEvPNfgOREXnswa7r5TJ8jw1LznJarbbuOgc
        M29TU5xFb7AkWubyrJG3m7LnZpmNC2mFIl7lE27Kyymp78Is7RO3HvFm7EK1YQ4USgCphN9/
        GpEDhREyshVB3Y0BTFgMIah0XA7ufEcwNvoU/bNU1fyS+FlGdiBouBMuiD4jaPP04Q5EEFPI
        teDq2OKvR5B/EAx5KgIGjFwHI131mJ9xMhY63z3F/RxOxsDjH68DA6RkMvS6x0R+FpOz4EqJ
        J+Cd6uv54sZ5iaCZDLcr34j9HEougP6rZ4P9p8GzNydEAkdBYUtVIA6Qv3AYfd8rERKkgfP0
        vmCaKfDhpjtEYDkMD3bgAm+HxtvXccF8AIG780HQnACd9eUif0qMnAPNnnnCsEkwOFIi8ZeB
        lMKB/TJBPRMeDXhFAk8HV1FxsL0Gjvf1o0MoxjkujnNcBOe4CM7/w2qRuAlFchbemM3xtEU5
        /rEvosBfjWVaUfu9jG5EEoiaKN1U5tbKJGw+X2DsRkBgVIR0kd5XkurZgm2c1ayz2g0c341U
        vts+jMmnZpl9P99k09Gq+ISEBEZJz1fRNDVN2pySqpWR2ayNy+M4C2f95xMRofJdaCfVMcmx
        894O69iaVYrFpa/qJ/R9zLdf/tle1PM8vmdRKrbhYFSXuuqtoq3O28SP3GoaUX6LTS//cuzC
        nTMVxecerF7MnbzvipQPFc6OKWggWkQrTo5ufxZSuUqJNidpN1bijuNLtHXq5dqXWyyJPUeb
        Xcu1LvNA4xPdwmURmdVYOCXmc1g6FrPy7F93NQGYwQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK5n49YYg46zaharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZPUsPMhfs4amYetengXEBVxcjJ4eEgInE7Hm/
        WUFsIYHdjBIL9yZBxCUlpl08ytzFyAFkC0scPlzcxcgFVPKWUeL9/lvsIHFhgQiJxXsLQeIi
        Ak1MEp8ftjCB9DILREr0P+pmhWjYxigx8/ZEdpAEm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS
        17b8B2tmEVCV2N2zC+wgUaAFZ96vYIGoEZQ4OfMJmM0pYC5xe99aVohl6hJ/5l1ihrDFJW49
        mQ91hLxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvX
        S87P3cQIji8tzR2Ml5fEH2IU4GBU4uFN6NsSI8SaWFZcmXuIUYKDWUmE1zEFKMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVAOjces5X6mMTSt+PuSMSrIW
        +LxPqOKfV9ysCO7i9luv7VMtLMzCO5vLbWK+e688VX7uP1dNgMjXNaLaFwI+mmSL7ApUvWg/
        c9v9zA9fv7pOmNbeOuvze4b6jOrSxrvHs4MvmSQE/Pm5ojEvILr/uqHAy3VmbyN9mOLqi6V0
        3jFo5AXlpBer/lNiKc5INNRiLipOBAAPaSPRqwIAAA==
X-CMS-MailID: 20190416071625epcas1p25204b912c8484ea796bf15cc7eddb0c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="UTF-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145721epcas1p2f14027ba26bed3e3361d6a261d851c68
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145721epcas1p2f14027ba26bed3e3361d6a261d851c68@epcas1p2.samsung.com>
        <20190415145505.18397-14-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190416071720.N31Rf1cikgHWZpuddvAWuaqwXlR25JccmfMzbYaCeQI@z>

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The ACTMON's governor supports only the Tegra's devfreq device and there
> is no need to use any other governor, hence let's mark Tegra governor as
> immutable to permanently stick it with Tegra's devfreq device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 1 -
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d338f6d..a78dffe603c1 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -94,7 +94,6 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  config ARM_TEGRA_DEVFREQ
>  	tristate "Tegra DEVFREQ Driver"
>  	depends on ARCH_TEGRA_124_SOC
> -	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index f1a6f951813a..832e4f5aa11b 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -593,6 +593,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>  	.name = "tegra_actmon",
>  	.get_target_freq = tegra_governor_get_target,
>  	.event_handler = tegra_governor_event_handler,
> +	.immutable = true,
>  };
>  
>  static int tegra_devfreq_probe(struct platform_device *pdev)
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
