Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972737BE7E
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939929; cv=none; b=ktEkdG4CbwQD7BpcUL+ClSTWcScRK7v75oNqb5Xeq8ra8YZz+pQq+TkBW3J5ETwRHyh+ubBi9DcT968cV775yS0awTxp3y89SL+fjyF2uvouXL44S+tt4rwnnGAwRKF/aZBahF2AQEbAGcld10FTaCde/2OaTAbOubM76hYN0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939929; c=relaxed/simple;
	bh=NB1fX2ByhiVxBtJxs7VNw9fCaNDcICIXuoTIGbSJ+U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJW33SkjOky5NDI2IwhzPOPywMckMxVANDjvS+ocQBJSA1TGdbSecPKfveRvhSoYpygrSTOJwj9XpPBXKE2Lz8c2u9fAz+EEwE1k/qd5zSeJ9wN7/x4pJGbGNz6rKQKZkdSrN3o4Qz2/YQcdz8WaiLr3Gwv0AloNZW1r6oswkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Za4tqvfp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RwNrb9/c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Za4tqvfp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RwNrb9/c"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8uC5M3295002
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WvCi/CVpH88WMffYYZwdgbtLju43Phq8Lyjrsa4uQn4=; b=Za4tqvfp6iYSc9Ls
	dTFiNSNp8QXlS9irMhg5nJ1t28Hbhk/E+NWH3KDKMjYJ6+iPwHccjZchewLuHs4z
	dGNMqEBdJpeGbuQy7TS5Z2ruavAoQxj7EqnNBUsgtHcseN8gAO0zBNlyYhiqp84c
	QI2v1bRKq2OF2FMkmk27G8dD9ft/Nd8s1hMiRaQl+2sbckGJFn5w7bGDV2RywIqr
	X2VooS4JCHmcGLs6XXAfhhaj2+TN7FamSjya73gqtSZCBKyac2e9Km0+xap6robE
	YWIQvCsz/egCD41xC13lGDJPzHxOLGQ1RNLDst6kncbw29Cf4BL4sY6glKr/qDDi
	wHqaNw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282u9wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:25:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fbc70cfbdso61137131cf.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776939927; x=1777544727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvCi/CVpH88WMffYYZwdgbtLju43Phq8Lyjrsa4uQn4=;
        b=RwNrb9/c3jegjSHkxetnQ6dV7Rohhb6H4ecnsbj9XBF7SjqOFl1k2fnZUHkD+xzVIu
         EsyOhRndPJz7EAMUr2R6oXx8geHx/kPDy3efB/TGvHuU5v0pPmUHe16Gu+G4GWAyJHTW
         e2wkOk+GqRlSAPTDTY+7CfL0Obu148TVyrtggG1Zx/Qi6SXCTo4g49ffT7mXiJUDJi1O
         K8YcgQ6gSo0OibOLcM5ckuw89qH0XfciD5B2mpjf/UXh58lerJuyMN5SB9aM0MEcY1rz
         0WqGu5lfx9b2D54LUT9cTJWMir+mhm/vhHsbhdb4Utg0HXRoJafX7jwDcFfR/QI33kME
         oOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939927; x=1777544727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvCi/CVpH88WMffYYZwdgbtLju43Phq8Lyjrsa4uQn4=;
        b=UVPfP3ntZXxrOZ0hXU6/RFN0IZmHLaZLRiJufDPkwFPfl9ocxztRjikSLm1+8vLVKY
         otoCtrm0/IIEPdifIF9n+9/CG6eOCbvEHljN0Yjeew344/WhZahCRzK9w9085oLQx+ph
         ATiXpl/WTXBBmQtTccGJ8O81R4zSfnrx4WEmsCE6b1IKS7DYloSeZWRm5Fmqbaa9P6P8
         0C8+7ARAny3lmIYI/wwWzb4uht+N1vkXPRDU0ob6QhwYeo0RNECXpUr4qMDzXMXLKMzU
         F+109aDkSB3A8LKJSGQAvSVsByMqkBoMTr9i8Yf2WTOCvSIoskc7S8drFnnqzxrJQ/wn
         xOAQ==
X-Gm-Message-State: AOJu0Yy3ijgDM6X3xElHVafofFribGSESI8h9vf7iCRbAY6nxarTYJ08
	3ulRMZVJYindiIA4j6SHk4yV2irc7PEtmrqugZkzCXvu5S3TMejuBJwqeWOjw8Tjms8HJ5+mk0c
	y47M8HxsEoLZYN/5+gnfAGYJjDaBtFoR4DBl2THUTaLjf0T1lp8dEpzheuvs66A==
X-Gm-Gg: AeBDieu0DihKlmIMFApSANXKGiL6hljKV/nkGm2HQ7ugbCs9E0xkeCb1bKEwf/s3pvo
	0piEdq9UhfW9jtWzY7YT20nCys+DowyMRG6AKwGrNUvqVDceDbIG6Eq9v5teEQJAtCPULF78mN9
	4OBDdYfHMPgL/DK5hLYTKNadJGO8naiCFz97xFmhu/9lJEArMNq5cWFjBlPkNUDq1MS1fbZ0mID
	wfA/4aJ3J1LMdxjScSgJQE4bA3hpLDb96o1uiCkrmH4gedPY15M742APvqoLcE1SwjZkFpJ8Iw7
	ChB4xhCcnnghJ4w0HRJn8L31MxRdvf1cruBLJA322pBV6WGKt0GeP7pEWuudKITwGjbrKlVpbK/
	gtHMUERIaNR2P5Pr+XL1TwRUtsHhAOtg2pLogOl4Li9mO7JAocean6wq+kxdQxvWBC+eJtu6opy
	Mj7nYaBTpACCpKrbdpRoQ=
X-Received: by 2002:a05:622a:4d4c:b0:50b:4a84:aa8b with SMTP id d75a77b69052e-50e36b87666mr402905921cf.12.1776939926696;
        Thu, 23 Apr 2026 03:25:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4c:b0:50b:4a84:aa8b with SMTP id d75a77b69052e-50e36b87666mr402905491cf.12.1776939926181;
        Thu, 23 Apr 2026 03:25:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm3890201f8f.26.2026.04.23.03.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:25:25 -0700 (PDT)
Message-ID: <7aaa7873-9274-48d8-a6fe-cff4239b03b4@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] thermal: amlogic: Add support for secure monitor
 calibration readout
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260421-add-thermal-t7-vim4-v3-0-a2e7215ed003@aliel.fr>
 <20260421-add-thermal-t7-vim4-v3-4-a2e7215ed003@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260421-add-thermal-t7-vim4-v3-4-a2e7215ed003@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwMiBTYWx0ZWRfX32sMjbXKSndY
 yJnLY+EfVwaD9LrYCGwvnj42rYnC2SW8zhLKR9tFnrdvgYkWjKkCdgiNWBkKOLNqsuEZT06biI3
 zAdemnjbsW640WASkXzsO6qPJ8sSn2aQDWGpdf6YzcWBJef1d5K9EMzDpDIB+nLdVvt1gORJpgL
 rrwqU9YnsbjpuQ/HUyZoBbpai80x4Sjl9+o5NYu6fsyTHD81npoafZKU3ld88iIdm4UcAYYAX4S
 rGZtzziNiXtH9QGNQnucxw2a23h6sGSvU26SwXQ/ypUHfeTKDcb7be7wAE9fQJzW1LQfaWKVKOp
 q8tuZakMkbtrENHfA1M9D+t0tko2CMWMOL2LlIhXhJ4qw3mZG8UzkIjaykfb/PPwDEoPnfQ+njX
 +ElhtrD+k77y/KWjb0GvLwVNHsBWaGG+WniudYzguwjMCvSPAXmiib7HTupa7XiwyFRo2zFpnVi
 5byCuLsxq9QeATfd/TA==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e9f397 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=SxES-kZrre8EIFdHpqEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: i45a1qn62RQByeXZuFZpJRFcFAm5RfHv
X-Proofpoint-ORIG-GUID: i45a1qn62RQByeXZuFZpJRFcFAm5RfHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230102


Hi Ronald,

On 4/21/26 09:19, Ronald Claveau wrote:
> Some SoCs (e.g. T7) expose thermal calibration data through the secure
> monitor rather than a directly accessible eFuse register. Add a use_sm
> flag to amlogic_thermal_data to select this path, and retrieve the
> firmware handle and tsensor_id from the "amlogic,secure-monitor" DT
> phandle with one fixed argument.
> 
> Also introduce the amlogic,t7-thermal compatible using this new path.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/thermal/amlogic_thermal.c | 58 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 5448d772db12a..11e3948cc0669 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -25,6 +25,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/thermal.h>
> +#include <linux/firmware/meson/meson_sm.h>
>   
>   #include "thermal_hwmon.h"
>   
> @@ -84,12 +85,14 @@ struct amlogic_thermal_soc_calib_data {
>    * @u_efuse_off: register offset to read fused calibration value
>    * @calibration_parameters: calibration parameters structure pointer
>    * @regmap_config: regmap config for the device
> + * @use_sm: read data from secure monitor instead of efuse
>    * This structure is required for configuration of amlogic thermal driver.
>    */
>   struct amlogic_thermal_data {
>   	int u_efuse_off;
>   	const struct amlogic_thermal_soc_calib_data *calibration_parameters;
>   	const struct regmap_config *regmap_config;
> +	bool use_sm;
>   };
>   
>   struct amlogic_thermal {
> @@ -100,6 +103,8 @@ struct amlogic_thermal {
>   	struct clk *clk;
>   	struct thermal_zone_device *tzd;
>   	u32 trim_info;
> +	struct meson_sm_firmware *sm_fw;
> +	u32 tsensor_id;
>   };
>   
>   /*
> @@ -138,6 +143,12 @@ static int amlogic_thermal_initialize(struct amlogic_thermal *pdata)
>   	int ret = 0;
>   	int ver;
>   
> +	if (pdata->data->use_sm) {
> +		return meson_sm_get_thermal_calib(pdata->sm_fw,
> +						  &pdata->trim_info,
> +						  pdata->tsensor_id);
> +	}
> +
>   	regmap_read(pdata->sec_ao_map, pdata->data->u_efuse_off,
>   		    &pdata->trim_info);
>   
> @@ -226,6 +237,12 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
>   	.regmap_config = &amlogic_thermal_regmap_config_g12a,
>   };
>   
> +static const struct amlogic_thermal_data amlogic_thermal_t7_param = {
> +	.use_sm			= true,
> +	.calibration_parameters	= &amlogic_thermal_g12a,
> +	.regmap_config		= &amlogic_thermal_regmap_config_g12a,
> +};
> +
>   static const struct of_device_id of_amlogic_thermal_match[] = {
>   	{
>   		.compatible = "amlogic,g12a-ddr-thermal",
> @@ -239,6 +256,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
>   		.compatible = "amlogic,a1-cpu-thermal",
>   		.data = &amlogic_thermal_a1_cpu_param,
>   	},
> +	{
> +		.compatible = "amlogic,t7-thermal",
> +		.data = &amlogic_thermal_t7_param,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);
> @@ -271,11 +292,38 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
>   	if (IS_ERR(pdata->clk))
>   		return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get clock\n");
>   
> -	pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
> -		(pdev->dev.of_node, "amlogic,ao-secure");
> -	if (IS_ERR(pdata->sec_ao_map)) {
> -		dev_err(dev, "syscon regmap lookup failed.\n");
> -		return PTR_ERR(pdata->sec_ao_map);
> +	if (pdata->data->use_sm) {
> +		struct device_node *sm_np;
> +		struct of_phandle_args ph_args;
> +
> +		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +						       "amlogic,secure-monitor",
> +						       1, 0, &ph_args);
> +		if (ret)
> +			return ret;
> +
> +		sm_np = ph_args.np;
> +		if (!sm_np) {
> +			dev_err(dev,
> +				"Failed to parse secure monitor phandle\n");
> +			return -ENODEV;
> +		}
> +
> +		pdata->sm_fw = meson_sm_get(sm_np);
> +		of_node_put(sm_np);
> +		if (!pdata->sm_fw) {
> +			dev_err(dev, "Failed to get secure monitor firmware\n");
> +			return -EPROBE_DEFER;
> +		}
> +
> +		pdata->tsensor_id = ph_args.args[0];
> +	} else {
> +		pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
> +			(pdev->dev.of_node, "amlogic,ao-secure");
> +		if (IS_ERR(pdata->sec_ao_map)) {
> +			dev_err(dev, "syscon regmap lookup failed.\n");
> +			return PTR_ERR(pdata->sec_ao_map);
> +		}
>   	}

I suggest to separate these two routines into functions. That will help 
the readability.

>   	pdata->tzd = devm_thermal_of_zone_register(&pdev->dev

The thermal zone is registered before calling 
amlogic_thermal_initialize(), thus pdata->trim_info is not initialized. 
When a thermal zone is registered the thermal framework reads the 
temperature, so it reads an invalid value because:

devm_thermal_of_zone_register()
  -> thermal_of_zone_register()
    -> thermal_zone_device_register_with_trips()
    -> thermal_zone_device_enable()
       -> __thermal_zone_device_update()
         -> __thermal_zone_get_temp()
           -> amlogic_thermal_get_temp()
              -> amlogic_thermal_code_to_millicelsius()
                  [ Use of uninitialized pdata->trim_info ]

Right ?

IIUC, amlogic_thermal_initialize() can be also split and moved the 
corresponding blocks to the functions to be created in the comment above.


> 

