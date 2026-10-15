Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5FD3FFAD7
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037190; cv=none; b=hXVrMNSf/Tirvp8kAq4g3FYObcDlEiMh4HU05hDNSTUJmpoGo+XwUk2JHXzoyHjOoR8F6j2Do6fXt/cjcBW6wdnZxS1VzaPBTT5I2Nb6jipMDts31u9Lj0X3dChPNH5b+SLyEGrjFM6u+tVvUqWq6NtG0F1zjvIMPvPLuQLHvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037190; c=relaxed/simple;
	bh=nguePDkbSX8CdLrI5jeCiApYYmALGzarrJu+OM9Fqm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDdd8Zn5FQewukveX6uWwVO/2+hPISRxCYeN3p2eNKehKXXnBFs5tOYfD2q/avjMe6MHM3ml6pShLeRC1W39ITJkmqsCuy39fVI4GInHoDW0uaVOnKhHBngp4PJBRxA60lvGHwJohxZRnYR0ahBaQRmzYvekS7I/UEnOh4H7+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7kG2EMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Huljvzjq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7kG2EMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Huljvzjq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F00P2s2121415
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=; b=a7kG2EMKtNc3ppFV
	ogttzL9XW4vzOAZkDYPt2ffRra6tQRSjZqEc5ss7PKoRXS3+CC1neU11bs5H+wJJ
	hv0t6JzmuVAVNBJMNpYtXtmAHgvs0ZLgHPfCtsrwNzyRUiFaFgblwJe1V3XC0PN6
	5e+BVu6dTNcrxA0F6uGaN2XuN3U1OMcoMCDwscp9ZABI6fTaQcSDKunlFPDiWZXz
	U7uPDBBOcvNuwLLzE9W3WPH5sc8IN6Vq+iPqdYETcyY7IVg5T/j0sSvSx/BEH4d5
	1QpW/a0vbZDFtNGyLXbtAzN3PEPir4XiS13YiIp+WaDrZsNUxAmRnoE9UN1eiaua
	Q34uFg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn0qrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:06:27 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8227ad6ddfaso8369298a34.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 21:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792037187; x=1792641987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=Huljvzjq76hKDCquZ6Y4VY5cauom742I2aN08fKAaEqNd5PTyVBQi6g00TMGH6UVYD
         xPG0wE8NpxydAlr7SZrISIIV5myDMmyJAHASK5d3+XUKEznS8HlqKi1SG/EQkOGxK24T
         L0XD9GQsYKOTbnfj4nZFqasp0Gzhk9NnwoyX4NXUGvY1q4pR43W7AHsG3hRJ6nAplEf5
         cPXK0TaOHo1ko3bf5OeiT1HaoTxw3MEoKj4VYKwmEe5TeEf6Z9ehqWthEGWEBSr+J2YJ
         fQY2cj/xctfiSUoMUtDP1S5r9XMZmQESheGoMcPlfuBj3Z9Y2D6vZJ1jLzualXxUt9MQ
         3SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792037187; x=1792641987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=YFQdDgSRVHqY3C2/0u+smxHhvK0gLaPgkJokP+RIEC3mrVlhd5es5nVsORXKbr2qk/
         OwYCvIQ9MWQ/FEa6cmp0V7DQn9yq4H/m4TxUao4ri4PXyMqcl8ibDKQAf5ukGTaD5vn7
         yqsfefalqERUclsgntyxdQVX+ueT2eiJytVD9LIrgpR7JUUTR3N6bB0Jm4jhEVPfJm5d
         0shOLaDPBgm3WGhQv3i1TMQzmXwVouKl8oCSuAfN6ysQWJjuob7J2iHuk36gZnTaFPDR
         WtGRDRp8ZoQjuhkGLxs+4Tigx5knDTZlJGLZyXnx7EWjkUR1dgKOM42DRhmPD8CSKCTH
         gDbA==
X-Forwarded-Encrypted: i=1; AKwUvBxdom+Sywv67Y2FOL7LavLYS6TQBl08n7KTMEfkZ7PSpDwBdo4gaeDqYuBGULRu4gOtLrfxSbmuxQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJsWY5aqTr8H/zvltdZTFmMoBmJsPKJFBeiz8lI8BaJ+ErlMvrx
	Kz86p2d0ObGvexCMlG87GLnYYSZpkTnUBJxG0rCqCqTDMoyjYeqIaWb9T3x+RqmVFwapxkaMzMt
	97YX7NhcFO1pm+NgJN/0RrRLdbagG2KswjPWdldokrwYupM3ET+LQwfUMtff9Tw==
X-Gm-Gg: AYBFou35n9/mrBnmXlbKuYtMefDPEVJvJDLwJK32okAg/CZkfBKCQUsKau7a7/Q/sDK
	/uKW8JaTJ+Us1LI+WVGuhlGmrWRGhLxaU1ObJDz88OCtpfMEdTgvep3shw61yDS9o2vfRA9IDHd
	aKyBa5SyiF3vvIMdDuhvpyrVc6ThdnCUalg4eEQ/QRMP91XCpDe2VSys0lZOdYSuFKM6eKG9WER
	imdg4aqyK6/DEZLraHUzjYgH9E30R35CUZpFcZYy/2i8ZAnph87Zv2BDKTkFPDawYYgzp6h8Kq9
	8JNG8S+RaaU6c3FutQ5365zgphScQHCOIOKn5wsnzW4abAwIl/Ym/dNCyFpS8RRwUUa31kbWCm2
	+fKNvjLVdRqkjiUqk3YyIH8m9VHezvQ==
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12450024c88.37.1792036710757;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12449972c88.37.1792036710046;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm41853429eec.11.2026.10.14.20.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 20:58:29 -0700 (PDT)
Message-ID: <666e2768-28a8-4bb7-8c15-457ad20970a8@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 09:28:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
 <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxNiBTYWx0ZWRfXy/P6Ev8rN+Xv
 rx+3KQJXHCBveDMX0HflyFjehcD2dL+DbBRLAs0DB2BTSsWkl5YazNqXVaqW6cn6CuXdZKu2p+U
 WoekXMsFaTE0u3E5nLVtx2YH/lSVOBQlGMMBqMs8cTnt9dFr2Hed+GaQkUdiR5mk6lJEwkqZ6QA
 +BrXua/P7qOnsn4oWCZPzXaWejY/fbNE65FASDzE4ok5sRancbqevRDXeW5965VQIVeOCCnRcjk
 Np3auK5b3wKU96o3VTadZlekD95o2bGXA1D+0rq1le+Xc6pzdvWsV3FAfggQIfKn7KCLZ6fZgn/
 pvpwvXaSfCp8fO5mBrTfgi1i8WwP4Df1fUHfj+cpimfEaFtwj4LnXuqBdBah4JQx0TPr4SLRXpo
 W6Vno5LTJ82bHsCXqHUbf5rX/xIg5NW4ws/8UL6Oi7yIUOX0p6FjG0qNYupzTFYZnYMdMPo23aX
 cSwPb3vtpXswPManjYg==
X-Proofpoint-GUID: 02R90q-4O-l2XU7BfTqiH4fLYxdizKMn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxNiBTYWx0ZWRfX5qxWp0y58CdY
 Yo5UPMe+YKN9oYpy56ZI36iJLCl/0rkk4iF4dALTjznF8yS4vQ60BJqNjGxMQaWPpzqZOowjvjE
 OmBLTIeorm2YkIXoP94vg3N7EEDvVJg=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad05143 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ip-HRx4nHBnhdLLshUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: 02R90q-4O-l2XU7BfTqiH4fLYxdizKMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150016

Hi Mukesh

On 08-10-2026 13:05, Mukesh Savaliya wrote:
>
>
> On 8/27/2026 11:29 PM, Praveen Talari wrote:
>
> [...]> @@ -2039,15 +2041,19 @@ static void 
> qcom_geni_serial_remove(struct platform_device *pdev)
>>   static int __maybe_unused qcom_geni_serial_runtime_suspend(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> +    int ret;
>>   -    return port->dev_data->power_off ?
>> -           port->dev_data->power_off(&port->se) : 0;
>> +    ret = port->dev_data->power_off ?
>> +          port->dev_data->power_off(&port->se) : 0;
>> +    if (ret)
>> +        return ret;
>> +
>> +    return geni_se_set_rate(&port->se, 0);
> Is there any register access happening as part of this 
> geni_se_set_rate() ? i was searching but could not see after seeing 
> set_rate() callback removed.>   }

No, there is no SE register access as part of geni_se_set_rate(), nor is 
there SE register access immediately after it.

Thanks,

Praveen Talari

>>     static int __maybe_unused qcom_geni_serial_runtime_resume(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> -    struct uart_port *uport = &port->uport;
>>       int ret;
>>         if (port->dev_data->power_on) {
>> @@ -2056,8 +2062,8 @@ static int __maybe_unused 
>> qcom_geni_serial_runtime_resume(struct device *dev)
>>               return ret;
>>       }
>>   -    if (port->se.has_opp && port->clk_rate)
>> -        return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
>> +    if (port->clk_rate)
>> +        return geni_se_set_rate(&port->se, port->clk_rate);
>>         return 0;
>>   }
> [...]
