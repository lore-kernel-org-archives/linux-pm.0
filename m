Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561838;
	b=BUIZWGoRYc2TaKmB5pPJU7z5pGW7MWSpS+OqH1CAwpCjUbk9D1NvOnb/7NzIUzumCAO1
	 b2BAZa8UiFmfVshUnR6BdOMZfJi/eq/wvhk2FSTq6BTVJ53oqWTu1tDo2HrZH33DoTQFW
	 xmPRjlnG/c0a2JRuu5MrZ3mKKbKQOdPncRHKXD3ZLyCS9oEyRWRiD84Ams+O1RwVe2SsW
	 G+QO1DYfg6Pm8smLwLroUiJfaCjwyJnXRefw6cqbOZ+Xo/olV2NcFgBJ0LXv8zM0R5MIG
	 /T7qj5eiKGX2yYCatKSnBf2vg3x/zKTzl6uL41CnPTCUPAlpmJpNu50l2QhZvusXbqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561838;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=o/NQUToHHAS7QHkNUaSYHDSQzMhgN9dZj/LQE1+2g38=;
	b=3Agp6puggqw6PPFnOkEVR1tHCiv3dsL4voiSnSmBH460WdmsJGDXhIdjg42hqlNgg3le
	 3EJaflDhavZ4k8D3ev6HKBH4jwnT9XsbYgeENesSFMJP5p0Tc0lpIT+IpEiI7k4d/WlKJ
	 b2kjm2E5NOhVjfLG3IQ3uPse+CHxsRvGAc2x2ps6zWgMiePqf4Wlu94KOWAdR//4yANva
	 gz6sG7pdEfe2IajDqt0sjTp5QPZEtGfLbO3Yr4o8ZMqwGjC8m7oJaHuOi9JxowtQrYx23
	 FTO+6E8xZ7LdxmOU4veJlhKMvc1Nb2OnDz11ly75YKhI3xkIapVmxFALy01+3VjncJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZPkhEpS1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ht56nYnA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1D606A9BD
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C1D606A9BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZPkhEpS1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ht56nYnA
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V1Wc3826887
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o/NQUToHHAS7QHkNUaSYHDSQzMhgN9dZj/LQE1+2g38=; b=ZPkhEpS1uetK6yjQ
	lvttE82layk9/4/5Qd1qwGY/KYHhBmNtM8Tbk00kFrJweTJtK+1kKB7y8Nr+m+dI
	dvn1szx8s498bqmiHNsrGdmGTmmogUCGuy7a+inMz6o+ucyg4oFmZ4FIc2iFqJ40
	pxqAaI2/JK3kg3bmDHUUL+sL5EXeUezkDYBQN1T5286PwmVTP8k8m5uOWZApe4Es
	f7/3sSfE/Xk77UFbf/B+rxXGcpqixYsYXC6uBQxfiN30zrf34mAdlO1h1/jswVU/
	kr+OgNaRm47l3NQUToL/vqJTfaADd1eqO1HswywJ5KyjhUEDDIHlOLX+r3Y3Ssdl
	uF34ow==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37gw8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:23:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92eebb130dcso22420085a.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794561836; x=1795166636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/NQUToHHAS7QHkNUaSYHDSQzMhgN9dZj/LQE1+2g38=;
        b=Ht56nYnAcnjmQZ1hOYUXp6s4SqqDw7Imr8GC1e6GiysEa/Oxlmog9l5Kc/lQpUvTSc
         sQbQB2Rbf0WSlLsYY4aZPCKVg19Kc9ikwSQHLowgp8Mj6UkgiOxDUq4ElMgDAsvxnI3l
         O3kRIjvOtI9YK8bLIRPDJrjaDL97RIxVhYB6q7CA99whcuuzd74C3wMP5gXlUqHuFMym
         eUCwxhBqRMwjF6EVQjGcdtdC34eQbDnlk5L1qEbzGGHouGEUDKg99hjVrs3G+iJlMWF5
         Y6EXQcaGqovzu19t7Cp/R1SHfLb1yH7n9k2w3JmfG/eGAexdCPjQ1TJ22h7AD2Iu+PXj
         X7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794561836; x=1795166636;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/NQUToHHAS7QHkNUaSYHDSQzMhgN9dZj/LQE1+2g38=;
        b=E0tRIblTvB3klyEGvd4iHnC6wWU9RgrNKnHDhlKoAODi727/PLH85dQf7BemOcQI/0
         dFb0qSZllmFNOB8HU+rBLSOmYQzVTJXxDZntzMKk46ff62t8MDMwMsPGs9eJQ0+OzpEO
         iklmDP0m/YYsPDDYqqdyMMUOMQL83EhtUHFRPtFbaA1F68f6UuHgW1t8ts4X7ITvgnbJ
         s6c96WybqZKIeiTxL9sYaQPU8kHX7wCnMbTJwurPeRFjJm1INL86GIsgbEGwqNP64H7D
         TPrRia2vZck+rpL9Lk/pU2AtYj27hINM8EUEGMCxsJN1tk6xba762r90P06GT0UkXy4F
         jKJQ==
X-Forwarded-Encrypted: i=1; AL+hErHBPu8J9ym5IU0oOpmOTA5kmOwsso45r1Nl9PEGBguaKUCtolSASoLm5lrziwf9GdrPvMUfq1Ez5A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bO5bMhcGWZyDN77Zgx3iGE+L9HL6VYnhDKdZHhjGlTg7kOX5d
	F2kv8Sx7FD5zADS+k2weM8sGVg9SRVwAR7LgSEmifrqy7DEeacNG/I0edi+fGhAtepDTGX0gy4R
	FIADijV/HQzFXr7RVJY9YufPaSNDVvU62gDEEtMDwkrOJ3ES8oXsPy43CXL5IiA==
X-Gm-Gg: AYBFou2Wn6Bk8DO7PGtzZhdCh/8MPkzDc/Pm+977iDmU9mjIKQ5bl8fOXt/kH+04Ypg
	k3MmVtUQv72VGcHf/0HIQm86pIX7gv3XGoHc3+rqfNw2A9XTy4F8QeFf5zokZ+0Hb7xhDQjuS/H
	aHyo712E5kCEfguTtbEv3PsMND3fO3k9/3qj5vKfw6RrSx80WLFMvOZTWv2i0vnPVR2Y0c3tMgw
	gHPnsdrg0XdhAn2oHLKoFURMg/5AqHXRlJxYkWSbqcy1Vf9zJRarOgmqPB4YfAr3J89cTzk5Ee3
	0/Wyxxssv/o/G7zHYmPVUXz4e4Gage3B0KSVC7dnu5l1PCk02gngco9xryTAnoBJoTReIUD2Lr8
	ErO64jnMWNJH1F6TgQgboAvvqHlwvifm/g+5/Qq+wiCqXh6YkzqwcxAoUzmVn5WPBgaAZzfQ=
X-Received: by 2002:a05:620a:230c:20b0:945:c174:3d3 with SMTP id af79cd13be357-9494bc92906mr299601885a.5.1794561836508;
        Fri, 13 Nov 2026 01:23:56 -0800 (PST)
X-Received: by 2002:a05:620a:230c:20b0:945:c174:3d3 with SMTP id af79cd13be357-9494bc92906mr299599185a.5.1794561836026;
        Fri, 13 Nov 2026 01:23:56 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b427ddsm70563166b.43.2026.11.13.01.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:23:55 -0800 (PST)
Message-ID: <36d49272-f164-4bce-8203-622038d35e8c@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:23:52 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] interconnect: qcom: sdm845: Drop the bootloader
 vote on ALC
To: Michael Auer <mick@yoxcu.de>, Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261013202611.3070778-1-mick@yoxcu.de>
 <d58c1d15-49c3-4740-b24c-17b850b3ddf3@oss.qualcomm.com>
 <2f78c7a6-5955-4d21-8f61-b3199b493840@yoxcu.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2f78c7a6-5955-4d21-8f61-b3199b493840@yoxcu.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNyBTYWx0ZWRfX6ytkxchTns7x
 /HRltG9Dmbn5h3+7ljC4m4krlvTa7FKtQnDwgbq2BI/yJRGklVkR7xxYkI1jL/yT5nAx9ZUvHYj
 bt0w7GfC9AXBicphvxBb8R81IOWSNg4=
X-Proofpoint-ORIG-GUID: tFNFloL4yTQ-kelyiqp7Ec8EuQrkcCSS
X-Proofpoint-GUID: tFNFloL4yTQ-kelyiqp7Ec8EuQrkcCSS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNyBTYWx0ZWRfX/mG5L+tBgEsm
 k7GCL2vl1xEuCcaZ4wVRTIcB9pdqxlbfRzOyuxpvN8BQZpinFj133Gtxo753YG+MkcEsuIJlZ/F
 6vAfXpyZyDClkNFZwO1r7y9n2e0Gu7qDh7N1RinHUZHcULS0ENrHoWsD1liGMz0Uda6HzklY2yS
 iYjcaSqpYUn4X5SwWi24hkAjNT0BVQ0Xws7NNnKvtClfOCB5VaHf8tatyLZqcBoOQIr7XiTOwjL
 I57FrIlkaqZnfin/tuiMozyUn5Duc90P4LAm+ndzLPjJq5bB4MYEc5srhTy7FxrpfG4Hd344REl
 yLI1b2etjb8pNlXeBnBC+GCfJSFgA8iaOETmlNEvrcmHgYFEkSHnVBHPg0NU8Dit8FNrjmSkKYM
 ihpAEJcFLOZhEHGhvencprx53XYS+3anDxnRZP3yAtslI/yePcNVG6JqQTspwiUJXL+NsludUth
 8JNXvWy/ItFQTvMl3+g==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af6d72d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=DHITo_NZqFMnFYMPA4wA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130037

On 10/23/26 10:02 PM, Michael Auer wrote:
> On 10/19/26 2:22 PM, Konrad Dybcio wrote:
>> ALC essentially translates into "prevent DDR from sleeping to reduce
>> latency", I don't know what a good framework for that func would be,
>> but interconnect (even though it has the plumbing for BCMs) doesn't
>> seem like it.
> 
> Thanks, that explains why the vote is so expensive in suspend.
> 
> I don't really want to add a consumer API for that.
> I only want to get rid of the vote the bootloader leaves behind.

For a start, let's do something like:

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 0880a287b0c0..f9d51f3d586d 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -390,6 +390,46 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_commit);
 
+/*
+ * ALC is not modeled by any icc node, but the bootloader may leave it voted,
+ * which prevents the SoC from reaching CX collapse and AOSS shutdown.
+ */
+static void bcm_voter_clear_alc(struct bcm_voter *voter)
+{
+       struct tcs_cmd cmd;
+       u32 addr;
+       int ret;
+
+       addr = cmd_db_read_addr("ALC");
+       if (!addr)
+               return;
+
+       tcs_cmd_gen(&cmd, 12, 0, addr, true,
+                   voter->tcs_wait & BIT(QCOM_ICC_BUCKET_AMC));
+
+       ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
+       if (ret) {
+               dev_err(voter->dev, "Error sending ALC AMC RPMH request (%d)\n", ret);
+               return;
+       }
+
+       tcs_cmd_gen(&cmd, 0, 0, addr, true,
+                   voter->tcs_wait & BIT(QCOM_ICC_BUCKET_WAKE));
+
+       ret = rpmh_write(voter->dev, RPMH_WAKE_ONLY_STATE, &cmd, 1);
+       if (ret) {
+               dev_err(voter->dev, "Error sending ALC WAKE RPMH request (%d)\n", ret);
+               return;
+       }
+
+       tcs_cmd_gen(&cmd, 0, 0, addr, true,
+                   voter->tcs_wait & BIT(QCOM_ICC_BUCKET_SLEEP));
+
+       ret = rpmh_write(voter->dev, RPMH_SLEEP_STATE, &cmd, 1);
+       if (ret)
+               dev_err(voter->dev, "Error sending ALC SLEEP RPMH request (%d)\n", ret);
+}
+
 static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 {
        struct device_node *np = pdev->dev.of_node;
@@ -409,6 +449,8 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
        INIT_LIST_HEAD(&voter->commit_list);
        INIT_LIST_HEAD(&voter->ws_list);
 
+       bcm_voter_clear_alc(voter);
+
        mutex_lock(&bcm_voter_lock);
        list_add_tail(&voter->voter_node, &bcm_voters);
        mutex_unlock(&bcm_voter_lock);

Konrad
