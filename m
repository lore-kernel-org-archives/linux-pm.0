Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570DD43C045
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510600; cv=none; b=kWyCbkJp01U8zxDYoTN5IvO/GCu9AzgYPqX4ulnoqM95kAh+m9am3eN7GquFSPj+tjKMIXrqHVG3mMCciRty1x4kkOn4iGH5byPqKc+Ekm1zwGMgGlyNoYEsDhnq/pUb9CC94F1b4MXO+jpDIL3xLNGGyI7b7+muWPzmE7YCLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510600; c=relaxed/simple;
	bh=aBkAMEuD0CyjqsofJwSfHwdYjumo06cFse0KE9joFUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+M4UzBVPgiVLbrSVco44lQCpeCsmq8XHidhNHvvJA2rMVVSU6MFndni1PCUtB4rDG9N9DNLGQ7E2JqH4YwwgB2tKoGa7G4BTLhYXYlDGF+01RM476J8J2wwjJtaKQ3g7h11ddHOlbg72utj/3cTqGIozMwUEEbliNYT5SexE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GWIjkuPc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DWnYddLs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWIjkuPc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DWnYddLs"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBeWI6188840
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 15:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IiQPodttcbFUkoVJE8WK76BI
	TqUVK05z2CI2Nc6iMmM=; b=GWIjkuPc9ryHGMcKihnmbMIlToe7+2sy/AxVKD7d
	X+uXeDIP6MDJ9/rTOf0I8+lBNZr4WapwO/2e+Y8tGHDJPcvWqvJvt69m5EjjVSxY
	Ni6u/2d+fUVb8yVKm4fpH9bdVLtDXS64jl+ucTJApZ1Q7Ap5rGfzAHnPTRMC/TOs
	FIPNwlbvy+IU8qqtcC875mpKryVLJrwpVfNHgm18gWjXSZeCvd/gn7zlGVO+YLgR
	CZ7rK5TF7e9KXysgVaM6QZZgqzOyAlBJUDX3LPLXNdKBXYqF6IQ7zGM6cL0P4Y14
	P9WAfKFZ+wnemIJJiCFxiEWDlNS3YHpxNGktzO/qnMI4pQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u0wfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 15:09:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-529ae8e96e8so10731321cf.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785510591; x=1786115391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IiQPodttcbFUkoVJE8WK76BITqUVK05z2CI2Nc6iMmM=;
        b=DWnYddLsHYLfWWLcLIaP5yJmiVhAfDekQHUuW4fVxqp3r1WRtMAymN6jTL22Vc5s0X
         C9LpEuc/y/YSEfpH8feO6eOzgSXMYtqXf7jQ9xqWNJoLJygmApYtBD6ehrGHA5mysAcc
         mtxryeiCk/obTDPM8STkwIaqYapWPpZppJ2nXRf5eYMCya+HGWCQAtmAL5qWTDALlum+
         SsAvk0/7oy1lkY9RYfU3568Ajtn7JhiP+DmYSEhZpqgGocTCQPliFwIP9q6WI3+Nf6Zo
         AOJ/fXxj7Vhl9aoc31tmZ5thoNvHVEpgvIMIuVSyIb3rpK5181AT/kw2tho+KKnrtfXe
         Vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510591; x=1786115391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IiQPodttcbFUkoVJE8WK76BITqUVK05z2CI2Nc6iMmM=;
        b=fmJVrBmOpQGhwoLFcK6i4AVtVq6pFQ3dTaBewVgKfeotFb6M9/vzHppC9bRKpy9iNH
         CdvKSKjtq+tvligkGE8S0l9qHHheXKWAk0o3WX9rMR/ssGbGHIVqdAaZMJGuZvSojN74
         dgPSM5gs0V0xVzY1GBqMm/c0twjdOfRRcliLuMDEMCXVr0bJJlPKC7VCDqZo+lRwllSH
         XmQwyy5DW83sWDeEbRCaBQ3WfwRFKIhzDnsjxfLWmkor+O0FrQSIp/lfctgjGk0GGgFX
         0/xUOdX8AvnOuQ8pBbOeZ8POoXZdu7eIxpAbSuJzOOQ87IqU+140biBmVePCJ+73I1G8
         JgKg==
X-Forwarded-Encrypted: i=1; AHgh+RpxttIY1v1ijwcsUPblsmaHTN7cwOImplXmocD/nyVOS5TQUQN/oOzoVt88xE2shvOAbo2yHu704g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTYcuCp+Mea3t+OhqxWXinDBnsLkyUMqzbSv96T+EWuGdad33
	ggQzQqMCODCc0bNJXLpI9IZXSxUj4SdpBCizzwEUrm4r2vbiuQH4d9DjyKBuOUMMvCe1Cw9nG8m
	6Iahw0D5eWh88VszyGGDP3/A/Cz2JvKTkAEPBXC8ZaR2QAbWnn5Gx9LlbGOqu4g==
X-Gm-Gg: AR+sD10NMw7macWcTb5hZ5F7uQWkIbftOF/rVMqJiTYrHWAasDN7Ggtq2LKvic1wnI4
	v5yifFuZme1af7wvjnqBDzL6Sxbq4xVzsLXO1ITP08ja9ND2nlXQfpNh/Ps84HR6O6cUNiyFafc
	5uuiIRbwMTmjsF6uKUhzJRllyST7SAdhnoznz8ZP9O1EoyaUnSjUjwIIXHuCFX/Iw1SvCEqOj1o
	imCA3g9969qxo4sJ+dJH9PpdIkbLuImPH66TkYLH5I+fknokKgByKVfAC4l27p0zuxBYnv/7A6Y
	qv57ELSFAuqGRSSu6rsQsG+QstxBvGMyPJxj/0JDCoZJZv2uLhmKuG/agDaIt/+NC8kNk6OR0Js
	682Qmc/pxHfAmGpeCL4X3DxUjIuySiwlHdMeml0iHmSvfXQzp4SWj2aKSzqGg9BLGCB11HEkr3F
	1YL9jlxf+9f1lNPg==
X-Received: by 2002:ac8:5705:0:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52b5673773fmr8897181cf.14.1785510590703;
        Fri, 31 Jul 2026 08:09:50 -0700 (PDT)
X-Received: by 2002:ac8:5705:0:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52b5673773fmr8896421cf.14.1785510590180;
        Fri, 31 Jul 2026 08:09:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e244d6c7sm380630e87.60.2026.07.31.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:09:48 -0700 (PDT)
Date: Fri, 31 Jul 2026 18:09:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support
Message-ID: <53mokww7o5hky34fhwyje7utpqu42md5uknqn2b5km22ccsfzi@fsbf2pth6ztj>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6cbabf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=m5CvEaKEMk9pMsaP-SMA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNSBTYWx0ZWRfX7EUKcEBHsezO
 z0rPHBxM3sThBRJuwiKwkAmKqSNaiCAl2qIXosBGnRgehRvB+4rm2wW+8w+fJIbB7xS/SFoXV2h
 N1nSRKkZJ5cIHH7vsYhOJmPkIrMRJPQHkzJuyfd02707OaX+6mMFr5AvP9Hq7V9tPFuocGbFA4s
 lWVW8Dx3TcMUPKM+W1JgneRwI9FIblJ9ibesrCVoUskRDyQoUE0swj8zWznvLcxXoPRHoa3rTib
 +/OyiBWHi1epkfVOwV94NdFV7QKLQkeZ6av0n0brS1J0xrw8IaVCh0xyyBfIT9aRrHdqj+eJt0C
 g4A7dFTxJm+Pkg7w5N7Dp6gDUig0VNWa37QdtJl8MChhxH9wI8xfohKnAUfRorJpImP3jtYRG4d
 y2f+AmKCFnVN4OqSLRSK74JPdMNSatwqSpOn6nMum2e9R7c5NwgKlP3zjQsAofDrYsaX1IVglLd
 LVyfsyySKEM16IoGLAA==
X-Proofpoint-GUID: BiNm4OsPS0CFFBo2E4prOWD7G94jKpBs
X-Proofpoint-ORIG-GUID: BiNm4OsPS0CFFBo2E4prOWD7G94jKpBs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNSBTYWx0ZWRfX/4JygKKNbG7h
 apdgAfGGjDeAy1k1QeQZ8anxzc+GVZ0hf3LhDIYtbk0ohnfNDaCNWSFPLBOJmAQ6iZ+OzYbAB/J
 7AH3E9a5Vrpwt0vkczChwslSGcmkINs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310115

On Mon, Jul 27, 2026 at 09:15:02PM +0530, Rahul Samana wrote:
> From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> 
> QCC2072 uses the ORN firmware and NVM naming scheme. The tested RB3 Gen 2
> Industrial BT-over-UART setup also needs the BCS calibration TLV to be
> combined with the selected NVM before download.
> 
> Keep the BCS/NVM combination in a helper so missing calibration data or
> allocation failures can fall back to downloading the NVM alone without a
> local skip label.
> 
> Select the NVM file and BCS calibration file using the controller board ID
> when available, with fallback to the default files. Initialize the BCS
> calibration filename independently of the NVM filename source so custom NVM
> firmware-name paths do not leave it unset.
> 
> Register the QCC2072 compatible with hci_qca and route it through the same
> UART setup, speed switching and power-control paths as recent Qualcomm
> Bluetooth controllers.
> 
> This continues the QCC2072 enablement work previously posted by Vivek Sahu
> and later extended by Yepuri Siddu for the RB3 Gen 2 Industrial
> BT-over-UART use case.
> 
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h   |  2 ++
>  drivers/bluetooth/hci_qca.c | 24 +++++++++++++++
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 10c496eaea2c..34bc0684cf1b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -569,6 +569,54 @@ static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>  	return hci_recv_frame(hdev, skb);
>  }
>  
> +static void qca_combine_nvm_calib(struct hci_dev *hdev, u8 **data,
> +				  int *size, char *calib_name,
> +				  size_t max_size)
> +{
> +	const struct firmware *calib_fw;
> +	struct tlv_type_hdr *outer_hdr;
> +	size_t inner_len, combined_size;
> +	u8 *combined_data;
> +	int err;
> +
> +	err = request_firmware(&calib_fw, calib_name, &hdev->dev);
> +	if (err) {
> +		if (qca_get_alt_nvm_file(calib_name, max_size))
> +			err = request_firmware(&calib_fw, calib_name, &hdev->dev);
> +
> +		if (err) {
> +			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> +				   calib_name, err);
> +			return;
> +		}
> +	}
> +
> +	bt_dev_info(hdev, "QCA Downloading %s", calib_name);
> +
> +	inner_len = *size + calib_fw->size;
> +	combined_size = sizeof(*outer_hdr) + inner_len;
> +	combined_data = vmalloc(combined_size);
> +	if (!combined_data) {
> +		bt_dev_warn(hdev,
> +			    "QCA Failed to allocate memory for file: %s",
> +			    calib_name);
> +		release_firmware(calib_fw);
> +		return;
> +	}
> +
> +	outer_hdr = (struct tlv_type_hdr *)combined_data;
> +	/* high 24 bits = payload length, low 8 bits = type */
> +	outer_hdr->type_len = cpu_to_le32((inner_len << 8) | 4);
> +	memcpy(combined_data + sizeof(*outer_hdr), *data, *size);
> +	memcpy(combined_data + sizeof(*outer_hdr) + *size,
> +	       calib_fw->data, calib_fw->size);
> +	release_firmware(calib_fw);
> +
> +	vfree(*data);
> +	*data = combined_data;
> +	*size = combined_size;
> +}
> +
>  static int qca_download_firmware(struct hci_dev *hdev,
>  				 struct qca_fw_config *config,
>  				 enum qca_btsoc_type soc_type,
> @@ -614,6 +662,11 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  	memcpy(data, fw->data, size);
>  	release_firmware(fw);
>  
> +	if (soc_type == QCA_QCC2072 && config->type == TLV_TYPE_NVM)
> +		qca_combine_nvm_calib(hdev, &data, &size,
> +				      config->calib_name,
> +				      sizeof(config->calib_name));
> +
>  	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
>  	if (ret)
>  		goto out;
> @@ -845,6 +898,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/hmtbtfw%02x.tlv", rom_ver);
>  			break;
> +		case QCA_QCC2072:
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/ornbtfw%02x.tlv", rom_ver);
> +			break;

Please try to keep these sorted.

>  		default:
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/rampatch_%08x.bin", soc_ver);
> @@ -878,7 +935,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	/* Give the controller some time to get ready to receive the NVM */
>  	msleep(10);
>  
> -	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
> +	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850 ||
> +	    soc_type == QCA_QCC2072)
>  		qca_read_fw_board_id(hdev, &boardid);
>  
>  	/* Download NVM configuration */
> @@ -939,12 +997,23 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>  				 "hmtnv", soc_type, ver, rom_ver, boardid);
>  			break;
> +		case QCA_QCC2072:
> +			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +						  "ornnv", soc_type, ver,
> +						  rom_ver, boardid);
> +			break;

Sorted

>  		default:
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/nvm_%08x.bin", soc_ver);
>  		}
>  	}
>  
> +	if (soc_type == QCA_QCC2072)
> +		qca_get_nvm_name_by_board(config.calib_name,
> +					  sizeof(config.calib_name),
> +					  "ornbcscal", soc_type, ver,
> +					  rom_ver, boardid);
> +
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>  	if (err < 0 && !firmware_name && soc_type == QCA_WCN6855) {
>  		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> @@ -1001,6 +1070,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCC2072:

Sorted

>  		/* get fw build info */
>  		err = qca_read_fw_build_info(hdev);
>  		if (err < 0)
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 8f3c1b1c77b3..425133096eda 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -94,6 +94,7 @@ enum qca_tlv_type {
>  struct qca_fw_config {
>  	u8 type;
>  	char fwname[64];
> +	char calib_name[64];
>  	uint8_t user_baud_rate;
>  	enum qca_tlv_dnld_mode dnld_mode;
>  	enum qca_tlv_dnld_mode dnld_type;
> @@ -158,6 +159,7 @@ enum qca_btsoc_type {
>  	QCA_WCN6750,
>  	QCA_WCN6855,
>  	QCA_WCN7850,
> +	QCA_QCC2072,

Sorted

>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1222f97800f4..449f0896bdac 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1375,6 +1375,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  
>  	/* Give the controller time to process the request */
>  	switch (qca_soc_type(hu)) {
> +	case QCA_QCC2072:

Ok, here you've discovered sorting order.

>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
> @@ -1462,6 +1463,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
>  static int qca_check_speeds(struct hci_uart *hu)
>  {
>  	switch (qca_soc_type(hu)) {
> +	case QCA_QCC2072:
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
> @@ -1513,6 +1515,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		case QCA_WCN6750:
>  		case QCA_WCN6855:
>  		case QCA_WCN7850:
> +		case QCA_QCC2072:

And then lost it again.

>  			hci_uart_set_flow_control(hu, true);
>  			break;
>  
> @@ -1548,6 +1551,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		case QCA_WCN6750:
>  		case QCA_WCN6855:
>  		case QCA_WCN7850:
> +		case QCA_QCC2072:
>  			hci_uart_set_flow_control(hu, false);
>  			break;
>  
> @@ -1864,6 +1868,7 @@ static int qca_power_on(struct hci_dev *hdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCC2072:
>  		ret = qca_regulator_init(hu);
>  		break;
>  
> @@ -1963,6 +1968,10 @@ static int qca_setup(struct hci_uart *hu)
>  		soc_name = "wcn7850";
>  		break;
>  
> +	case QCA_QCC2072:
> +		soc_name = "qcc2072";
> +		break;
> +
>  	default:
>  		soc_name = "ROME/QCA6390";
>  	}
> @@ -1986,6 +1995,7 @@ static int qca_setup(struct hci_uart *hu)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCC2072:
>  		if (qcadev && qcadev->bdaddr_property_broken)
>  			hci_set_quirk(hdev, HCI_QUIRK_BDADDR_PROPERTY_BROKEN);
>  
> @@ -2019,6 +2029,7 @@ static int qca_setup(struct hci_uart *hu)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCC2072:
>  		break;
>  
>  	default:
> @@ -2172,6 +2183,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
>  	.num_vregs = 4,
>  };
>  
> +static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
> +	.soc_type = QCA_QCC2072,
> +	.num_vregs = 0,
> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
> +};
> +
>  static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>  	.soc_type = QCA_WCN6750,
>  	.vregs = (struct qca_vreg []) {
> @@ -2274,6 +2291,7 @@ static void qca_power_off(struct hci_uart *hu)
>  
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
> +	case QCA_QCC2072:
>  		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>  		msleep(100);
>  		qca_regulator_disable(qcadev);
> @@ -2429,6 +2447,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCC2072:
>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>  						sizeof(struct qca_power),
>  						GFP_KERNEL);
> @@ -2448,6 +2467,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCC2072:
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>  			 * Backward compatibility with old DT sources. If the
> @@ -2490,6 +2510,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		if (!qcadev->bt_en &&
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855 ||
> +		     data->soc_type == QCA_QCC2072 ||

Randomly in the middle. No

>  		     data->soc_type == QCA_WCN7850))
>  			power_ctrl_enabled = false;
>  
> @@ -2498,6 +2519,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		if (IS_ERR(qcadev->sw_ctrl) &&
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855 ||
> +		     data->soc_type == QCA_QCC2072 ||
>  		     data->soc_type == QCA_WCN7850)) {
>  			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>  			return PTR_ERR(qcadev->sw_ctrl);
> @@ -2576,6 +2598,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  	struct qca_power *power = qcadev->bt_power;
>  
>  	switch (qcadev->btsoc_type) {
> +	case QCA_QCC2072:
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
>  	case QCA_WCN3991:
> @@ -2785,6 +2808,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>  	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
>  	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
> +	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072 },

And here too. Keep those sorted.

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
