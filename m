Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D913B0583
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337854; cv=none; b=eItn1uuE4fMEoIV186EKQcPCPbxTUZrxcyf9qCOlgm1Wlaufx03FGPKm3KlXXoMc/m12Fr/RboD6f3jv4H/x+KjwSrHaPdPz/HUj+U91VMbbaOrCWoQJEn3t/ChKQfauWGq2xtZChuyV2Eq3LXGnSdGhjqbHZzCqBSyQ/S6tJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337854; c=relaxed/simple;
	bh=T28LwLud2iEzbbgwesgevDXa8dhLYQcfSwjwDOvg/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC2TViXragOrpeXMVvtdWSFNr+c2yDJ5WodSg6Y5jmKC8JcZw2/rTyov0VAaNX+gl89K1HzBmZdUX2Xdo02GFRQU7AXj5tq6AkH7/sNEcVkBkI0rHDM6QEIxi0SR7ed2qnyvJ9GDeeqWprY2OeL5bxnzZPOenN38Fh5t+3BfaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXntxlLP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ex25djoF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXntxlLP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ex25djoF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2vHf1700070
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 15:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3kDVR16cPwPN/H4xAF5SCh3q
	n7cgx706CeAbqHCaGCY=; b=nXntxlLPp3xOVSis7uv47cgc/ZazyDy4yvqndDrg
	kWFCf8BtIYRZ1xRYbqKytEul0UF+4zJDmfVJwS34s0s3iA0u/sLQmbCMlhZMWn3e
	R9wQ29CVB6Cu36a4nY4mHNnaubrVb7jBwA5iVuLxkDpw/9qHOl/zixNLTu0/S4H4
	kHmmDV5gp5a7AhM6/9+vEjjE72avo05qxg2meYQnGcnMDJcRbywyZHfv1rLoe1qr
	4V+234SvpZZx1HenpYDqOCOAJ5/Apl8tDiS0zqhLkyDa6NY92CbGRf7Hj9mJ1Ms2
	fHrICKT4ov0Hqiv4opOC7yBnHV1+AXqP0ZuUT/jCdxFl3w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj10ku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 15:10:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so12628871cf.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337852; x=1785942652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3kDVR16cPwPN/H4xAF5SCh3qn7cgx706CeAbqHCaGCY=;
        b=ex25djoFtiGJY5xkx8cNNPsXs/jz4KLU8EJUNwZobjJ62l/XNotpJ4WOacs9fLmNNG
         e9j8pS2NjUqxBtUwndHR3EEgOh52KCJ+hFWToJP5UJ8pQat6lSzfICSOTylXuW3gqMMK
         iPIhmpDXt0Ntlg212oAK0ERvfM0cF24JPTDOThgfQtYIPodkbUVDehxIxIv0T8H1JZn1
         TknNkDjjajcgcnX460P7tiEmd6ittLhmjUNajhP/g2RYi3CeEikrQXvQdfw8QzrgbKXG
         nj/aMmsyCdR4G/XRqVV0mixp7G9DsKTkGasdsGAvycJeJQZjhDM7DbhOFaa+pxoFheMP
         b/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337852; x=1785942652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3kDVR16cPwPN/H4xAF5SCh3qn7cgx706CeAbqHCaGCY=;
        b=rS9tZCXWs0W6KcPIPe2+0qu+90CwWHmyxYLhJfzCR7Mr3uSmzSHMfNM/q0Q0awmA89
         krTjKnmAV+KtWOkbol6YLgCMgWWyEnuOSzaR1Cl1LpdC3sRm1sEF3wN3MweTn99RLf/K
         1tKNz1FW/UaeD4PR6TpgKctf7+l4Qu74okhKex0eOAKK75oLTRBpwSWwG3fbaJoCEj7V
         z+8WvC9wdLrZqNMxK5mhmj3DSn9AXRhlpRK61zOWSC2j4DpDBIL8PgUVHaES3d4R50WC
         t5wSOfotZP16I0JITQwzwzhB23iEytENVxhnx9oLIoYrjnnmRFbUPf0Z7/oyUADDRxtc
         hj2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4mjdTfA+gIhPfAkuQipJiuGK+VC5jEeT0W+pjS2yhqD21m9KVFewcmQ2SnT6BvL+3O59q/fM8PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ImuXjpQh0SY7QXLkw9rTK6ZxZF0wi3KfHjhy1Kam1SX+B/Xy
	eSxAyQ9sUX0uAWWIFueNoXN27WCBuZcmebn8BGW+HIBT0tI1eHx+oqRhxZmrIU0ok9kM5lwSi85
	90SF3QJdw924mF20RaR9amFhkigZm4e9Y4I8Hn8r69jsPwNuq8JMyrCaye4TxFGS71D7cBw==
X-Gm-Gg: AR+sD11Y7vYo7vpRRfwmEQE91NdUBuhvT5+bBLiJl7pRNefBtndE+vyE/Qtl4IXEWHN
	fCu5EpcjS9RZlonH67zcQHl8WOFJQQEw1zUemICm8/EDA1sTuoczcToIH+cu68JPST8/Dy8cTRC
	UTEpBMHc0DrOW8RROOHRxW2yV1Xphev+l8brJKBJcxmjroYquVrvsJzDUDnSL3wOqGegw8WiVrA
	R3epXsAeti+RL8zRTgW+VFfeMOepSAyHUg+DzXTQBgPyBZCwdn32B1zoZ6e8l4N/Qqvg95kUUN2
	eU/1pEVOgCdrj7DfMXFMuDLoP0R/zijTD6kMj4DESzCo9SrZIXN7HtVNKWJo+lczqjie+UtgPsS
	Pa/eEKwSyLLvrUuE=
X-Received: by 2002:ac8:5acd:0:b0:528:3c2c:5c72 with SMTP id d75a77b69052e-529d7115a62mr61467711cf.32.1785337850890;
        Wed, 29 Jul 2026 08:10:50 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:528:3c2c:5c72 with SMTP id d75a77b69052e-529d7115a62mr61467081cf.32.1785337850054;
        Wed, 29 Jul 2026 08:10:50 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bff4784sm362740695e9.4.2026.07.29.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:10:49 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:10:46 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Message-ID: <bfqbdommlswjz3hji65hg54g6eiqtufpljpa3jdvqxkhsu5uso@dfc35pmlcngg>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a17fc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=adJbRHicXYsKkr84VsUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 0CJ3kikQgCqp8u-PC6AovuG3DrTsrPkk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX5zvqi+tHtaTS
 TwCGC2TMw5GmRm9nAOqHvGZWOcxwjJfSoLWP7az5WP0a4kWuvmJZ1p/5aMXzaDGYgdYoNdMUTaV
 FG+Sg5RUyHoUcHs8kUdE5y4LZJn/0JIzR75M08JrYX7kG1bgt1EvNW2AXK8RxOrqCQpthiSLDxj
 uBcg7+LCUnZyJ3GcrHhcLh/PALuvW8hx1lGj3h/xlFUz33Jftuhxrop9odFWNBVU40L4y5yUFFa
 rmf5IyJQcGC0iuo+X/yEEsQcNK+dGkOkVmauUWHVAXcFAUz0ILp6cZHUP0Z0iZoIHfQCz0MRw48
 wi+afTbgy8OkzCrnNNPpRrk58C8AfMX+lky0VrJNXj9hWNXo3O0KbJaaGl8eFyMKaBV1xvVupnm
 DlpBrT2p0EDD/57OKCG10YGC0mZhT/FYt8oOyEUfl85GJECWanU4Dclu77moLdhs+bO/8gqwyvp
 csmdvgceIwUVfTnomMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX5e2f6ofcLuiV
 x0aTwrpHxFsj446lGrnk8dimMhuQHlLDCnxHcIX6yYDuJz1fbYYPHqlqes3MCKT2I+XKqr3V5lh
 mp+kxorQvA99lhecrc3OLQNBEnOk29k=
X-Proofpoint-GUID: 0CJ3kikQgCqp8u-PC6AovuG3DrTsrPkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290121

On 26-07-29 20:18:36, Krishna Chaitanya Chundru wrote:
> Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
> (PCIe1). Add PCIe controller and PHY nodes for both instances, and update
> the GCC clock references to use the newly added PHY nodes instead of
> placeholder zeros.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
