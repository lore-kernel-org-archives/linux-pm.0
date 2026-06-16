Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215A35B654
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579044; cv=none; b=Uq7ZzyEm1637Zqg+vBwca/br0wOMmGXTPmtmGAhQUc1Rb6Y8JWFF+9Aq9oe3/fz8iCpDSsl2/06KbVhnuP5KZ0AwDHqa7FxyTJH0XTyv0uHsEOqKBiGIAZDcU+KocclWgk4imJk8MxRjnG5YlvHdWoIbLlP7Rr7jEjukNU4Ermo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579044; c=relaxed/simple;
	bh=aY+9+MdKna9M5CJAz5t8sHyWsdgO1hXtr9iBaOmS6fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGumGAhfoN8qEPqC6EMUYNn1psGl0I1dMpH56qpWpy6QeBlkLdx8l1FTmYLlQAl1cSZeZ9KI+waRbSripb56LuRbO/nFZxIgPnQfEvGOG8Mq1V7xVi0b5Wr64EQGCPyZ5CyVSdvl/eTn8AximYZSzcasb4D9eptZXcTGGi2p/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9ig1rOA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AR0R6J1Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9ig1rOA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AR0R6J1Y"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xtam2148087
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 03:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8zG4ij+zNAg
	8aexT5VC3GGKsuDLynsOlxhclh16ESQM=; b=F9ig1rOARCjw9E4BR+5c9yfyysI
	lxrAFpSYJS5wom0+ojGT4qh02JoP/y/CI/G//RMQdNc54tlx+jxu8m8gChbVtjKa
	YT6T0piam3WwXCwuebSq2vVc3r7lDHE6Qw/3eUiI6tJwra7CjfdqN6EwVl03uCiI
	BRZyibEmowjki+dWb0fl3FUhM0srPOPOe5GAXFWJO8/XmYX19i8JYJVCEYERsgbL
	jbpLpCOlgRYJzlwmT4chtqR2dpZG4s/4sRlc32WmekEFOOlDZTyKGLllnpsARfiN
	7nfWbe4Trr2kuxw9R2Dzj9Whc6zAguUPFcYpvz5uh66wCBA1/qIM4pgHcVw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf4bp4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 03:04:01 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137daa666a6so388046c88.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781579041; x=1782183841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zG4ij+zNAg8aexT5VC3GGKsuDLynsOlxhclh16ESQM=;
        b=AR0R6J1Y7dndSLCoj3smWfIsuVuiK0P4/EJyCB0xlkCIysudldPwJmY/cqhjlojFrP
         JzjqmTSBuCPYNxeiQrMJyP+stqAfLr+HQB7G5GTKPz1lNdVVEsIO/7dTjQzbclLuIyTU
         4/dgk/2BT82fEUn+7GHwVXWiYG362lZ/+o0zs2ITRn+FZ5ShhJaZAUltWS0Bnt81/QRr
         AGR2/uOXV6YkuRafRsBQGKQJwfbeO3aBosW3iX2vA8ZInklYQA6SKeuSN99UsGW0r7fb
         8GEgz3kDzvgjl61tekDU9Ztnyapz2nx18FQEYKbAXSlmLL0bxNZxTHzeg/i4GeIdE29R
         pxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781579041; x=1782183841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zG4ij+zNAg8aexT5VC3GGKsuDLynsOlxhclh16ESQM=;
        b=qrzphMNBVVGvlgfYhMZt7G9Nf9xXY7mNW3y85976p/rgfQwaDImRfLZC/bNBSxupjn
         dvDWF9RNRmWCbXly9ep/N2GFtH68jAGVRvDpoMKlmnD130OjlrRSV8vGHR7zMT5kG2w1
         gvbl2JYuOUR/BMaJgWkJLHKhRGQWD52AJqGarxsmOoLjrUe7RqRW18udYS65vP7sSqVY
         Ug2rBJl/dvs111KEgcJiYRLqecFKh4SxjSoUJIprM/XrAPqycDmyPUCA4f0O27uWjJ/m
         hAkFUqpzYtZVfggDTcFM9jaqJ/EXjzxWgQCaQKSzVO5RPdKocCYNu10Khz2nw1d4M1FF
         WknA==
X-Forwarded-Encrypted: i=1; AFNElJ+RKy++NYcE8TK2s4rkihhkyi0K0naIz7mvF02oDRHJRoKh4zqzbD7NPH1it7gFz4PpFSVl7jU0DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlr1eXQkQRjNMlFgDZFExx0dzyncwkaAHLv8pCjLK4kILQnU/u
	D1mkTzFIVf9JUIT2t3bLGmB9lVD1vhsxECzqLg1I/N6Dy3gkhdYEbhhl7iQzTgyQAxg70rCLOMI
	dy4t4OzCTWw8tYABgCuWkozAwTrqE00TXhFMCkST++pgrSZlALAyDZMg90bwdzQ==
X-Gm-Gg: Acq92OFRvM/mlpHUlk0xB/aVZewFOuSJ0yo2BPLxPZRpVTrk7ysXECpd2lIL7lwPNvJ
	Rc4icRrbr+OaY9z0h4K6yP4nDT9Ftm7oiqOr47DSaXvblL50LxaGbATmuulp1FcI4kFa8HA9GbN
	5Cm6ztfvhVN7V5WcFjtSJj1rqp7q73l19et/wjiIfRhXVTVvXFlnF+T1XAotd0b7xEw8NAc+y1e
	S099GyBJ2GMrriRJnVraGXU65BCnZG5Lf5yzsCpSbTIpP00ByxWHc1jUAnG7H1Ml06GEXBzxY3F
	pk0AOe2dsiMqlIOR84dsdwHcf8uVWpG9frPD/KS6BeTtQwQ+klHonogyueg2G/pIEGKwrE4/Cwd
	Ax6J8ciRWIRA3Vo7EN1pHtVlY1H63SZ3gnBRgDJbNdOtByp5LEi1DZl1G19i0VZRuBa+MtAzY
X-Received: by 2002:a05:7300:4306:b0:304:3c33:7afd with SMTP id 5a478bee46e88-3081ff5d099mr4747145eec.1.1781579040744;
        Mon, 15 Jun 2026 20:04:00 -0700 (PDT)
X-Received: by 2002:a05:7300:4306:b0:304:3c33:7afd with SMTP id 5a478bee46e88-3081ff5d099mr4747139eec.1.1781579040209;
        Mon, 15 Jun 2026 20:04:00 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm18012843eec.0.2026.06.15.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 20:03:59 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
Date: Tue, 16 Jun 2026 08:33:53 +0530
Message-Id: <20260616030353.3701326-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
References: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a30bd21 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=qxZblbheq-ph8u31yYUA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: csWPCeTPTVVX1VlcbjblxBMjrZgStZP-
X-Proofpoint-ORIG-GUID: csWPCeTPTVVX1VlcbjblxBMjrZgStZP-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyNyBTYWx0ZWRfX6e9IRZm8Tugp
 nsSWI4egdqmFwez3Hq67lPXvaPbT7BkUGcCYcxDIrr4cpYysmrbeuGdJmq+kt9SchF+9zDpBS8T
 t27q1Ict1EYmky2yOwJvVPUV6yrWx68=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyNyBTYWx0ZWRfX6CpY91tDF2AZ
 Eccp/oAhnetCoWMivbp+B/PKLJC1xW7Vk758AgaX5/4cZfDOkBTEcdj+xy9rLj9Td6LJK+IC768
 fzUa1/ixkCXLCpKC90L/4cIr7M2j4FfQsDzLcF2Elbg68tdat0jHkajsRbeeFT7J5lVdsFRBs+a
 HvRhq4dH+p9iAup0agUH062s6i7lwEd4MHruE2b5/PpBfS7SCPj7w6JgiIqPjoaGrOOFnNKXMYs
 0MzmU8sdmkrJm7C9piR5ELiUk8Yh7KUWOxJqAqDYWHY7UFOEf+NOZ3AkY+7G2RSczJF7PH4X9mp
 ECMFli0GbHF2WJDbIyTUGWdUL9A0NYSAhi/HUmvO92uUS1wBmxkhe3NSV1/dq1sMnfqz+FUhPXy
 xGmPwGI++VZI+ZLQGIdPL9EpqA5ZkeCnHNSeh/tGBSKB2Dp0SQ6k2b9sE/YGbWOkw/3KPWURQtu
 TdEbdyt1YHBTuaOU0sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160027

Hi Dmitry,

On Tue, Jun 16, 2026 at 03:26:40AM +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 08, 2026 at 02:47:01PM +0530, Wei Deng wrote:
>> WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
>> 0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
>> (WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
>> serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> index efeb25ba9c79..b3af14464314 100644
>> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
>> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> @@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>>  static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
>> +	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>>  	{ } /* Sentinel */
>
> Please keep the list sorted. I saw that Bartosz has applied the patch.
> Would you please send a followup?

Thanks for the feedback. I have sent a followup patch to sort the list:

  <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>

>>  };
>>
>> --
>> 2.34.1
>>

--
Best Regards,
Wei Deng
