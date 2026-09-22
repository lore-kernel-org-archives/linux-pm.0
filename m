Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A885541E76
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079481; cv=none; b=Or5doPJbMQ/0LKtIuNjs3MQY9ap8MktlXVsQikpxmd9/SmTUakBOKV95QSi2PCBrK3tD3Z/dy2ppY3XR0linKXT151A6EglMB+xLzZlbiUdIKPJN9QK8Fv+rVYtdjkwNdwUbkEXn0/wJSmT2GaOtX+La9N01Ak6v9m/2BvkT/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079481; c=relaxed/simple;
	bh=Z8vK1PMOHpIAza5Cd6gxs7LpTHqfr/WP2xIKptv00YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMQCK1HaNSORBaqM8J7izA6poADuxbX38Mf+0hZYElwy4p6RD5D/EKA7x7osgdW2aXvl2YjVBtoPSdLhFkVciBrIoETNf20F82v33V2Zgge67gRQg1WfchswMvJH4hy3CEXBI2D9hpLSAfXS8ad2UqOI1aZHkWpKnpf3mt9hTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1N5OLOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSGL/QUi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1N5OLOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSGL/QUi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBOvTZ1145889
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NAnUkmHLKR+BK/jRH+E29tTv6Y1MKqKnDV7lmxWpVx8=; b=F1N5OLODQ7a6MzPQ
	w8FA6pfTc8OtFkobuzc0lUkSRDbRWSrallSYFHLCQnFWQJAYYpbFjVJsgqmHs2KB
	p0g5u9dgOlkp9Z6A/jphYI/s7bVrrnf379ghYqK0lOBaUppFadnIOlxMNhlaKt8u
	LylTyXyJBgIFHRMyhKVyBD8bElwWLftDLMIDRXCjAahB48k7Rg7aCmeBCxDwWExK
	+rff+1Vmy24zq1JI36DeXlUWI/yOQCI+l8MVVQZ2xN4feTCZjiAsM2AMktWPQpqS
	MuCyiNjpLN/+4pLJYzcA0qVby7ioWfAzkfal1kTG4VKRb+TF7ieL6HEcaYGLTtDD
	ZwQ2pA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guqycrccu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:17:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so5500121a12.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790079478; x=1790684278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NAnUkmHLKR+BK/jRH+E29tTv6Y1MKqKnDV7lmxWpVx8=;
        b=kSGL/QUi2a5LmQzdB2c0+4RNoOkvO7ihWNqb0jEsXeCuP+6k6ln2r4ry3qWjO6DmEW
         Zam4YOxio3VfAXCxk/C++mQKapsG5b4Z6v0y2aHfgRxN2DoBuRFBc3WqVz0obCmD8qsK
         oxowse/Yqib5nIm6QPQZ0+iogIwhMF3JRR3PIp8OeUhmdrFyNMsQtOEi7R74vY/wM+DH
         BcdAPEMl4LO2AkPmGPiP7dNyH1EN13/a7TRfpwJY/DHjGpT80c6lwO1jEWRqA/cCR2dv
         WQwfevFC11/f9aVVn7Kj8rxwU8AwY7odixt1NPr/o94njzEB35nlcYhJsE95nIp7/m23
         M/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079478; x=1790684278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NAnUkmHLKR+BK/jRH+E29tTv6Y1MKqKnDV7lmxWpVx8=;
        b=QdcDBvfdwwGcKSbZ/3EBhNspHBiRy5lcncZO2nQJfxC5OTscbOOK4Ae57/x2r8jTLj
         b+Ja1ABwhNYfW8OG2yL4ZVsQjSSXOGPoIP7c3GuuDXbl1pa0YBLxyeTtHefRulCiorUR
         TW9DVufg1jnaQpdsiL/z9KracYw7v+cqrCkkc2hGxi6colRwEbbpOKnvqBgQyi76F7ue
         QYjT0/vBEeqVqZq3/8BFC9gQdQrOqDZwexKOe2FMizQQO/l+g+OCYD3PSulR0wb8oK9v
         w2361Ouk0CBjbOLPHVfw2Vg1lAymmnoAvv8n3fo6EEmTDn3o/Ulxr3gQpYgcY3Qke02W
         Mocw==
X-Forwarded-Encrypted: i=1; AKwUvBzCxzeI/da93wf5lu9F/8KKc3QiNVHUVQnqLqH5oiaMaWMef2mYsN3mNsOwV79Oc/AU3I4RZB8DyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mAQf+lf2jPCpF0YgS6n2sb6xAWfKtm2ypEvxsi4FSHHfY2ntWQ
	V8O/eH5x/xmMyQJHP5YjGe6sjG1GWjVs975xp1RZZ0qH1VoQjoaVhoKiQ2+IX1TohWKaHfFIOt+
	D69DSrI9Rs4u/PQT4m4ezn6VCwX9kO8WWqFseWX7Yzya8Odo7219em3VZzBtRSA==
X-Gm-Gg: AYBFou3lNBGc5H+oFuhEz2t50Grk+6YeXkVDccIEA+gvAvYSM0QxbSuZtUX4Dl4jQ13
	4RMTl9W3dKqQ8eBfCcOdZ7DQuOZpyc8SLi7isK5pW+cOxH9KvNRbI7jB7b+Bxd9VBPYhU/d4Nq4
	J25VxKeJdo9UZEO7rs9aE90tTpnwy6SiFuH1SXJYL+KBEbz7Q6NGSToshlSnanpjryUjCCWG50w
	c0nL8ZlekQwWtGvifFCjPfudWQp+P1abZ+nifm0WUGSWoLBeOzu4Yx1VE5XhbeKlQ3pgR44Qsu/
	QDIv2vHJVv9ptuaf3nJCeiIHiT2tKHynU3P58rQ3jShlWVMWE6JscewRfJA33v/rflEERpxffiY
	m+U4NProeslypVbof+NRQUJXOv5sPwUHHpzy+YKuEsw==
X-Received: by 2002:a05:6a21:3a94:b0:3dd:a006:7b37 with SMTP id adf61e73a8af0-3ddec8023b5mr1308454637.54.1790079473135;
        Tue, 22 Sep 2026 05:17:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a94:b0:3dd:a006:7b37 with SMTP id adf61e73a8af0-3ddec8023b5mr1308406637.54.1790079472530;
        Tue, 22 Sep 2026 05:17:52 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6127001dsm5963161eec.5.2026.09.22.05.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:17:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:17:46 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        bartosz.golaszewski@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: add nord
 cpu-bwmon compatible
Message-ID: <arJx6nAvt-gtDd6V@QCOM-aGQu4IUr3Y>
References: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
 <CAFkd8hth1ds5j9jbe3vjjpCYkbTVSeTiVsQvzy30YCyFUH83ZQ@mail.gmail.com>
 <21aff47e-07cf-48b5-9752-b1a9dc7e6095@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21aff47e-07cf-48b5-9752-b1a9dc7e6095@kernel.org>
X-Proofpoint-GUID: WRdBlHJ2nhrT4LcqfHJdSEvXTEOdDChb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE3NyBTYWx0ZWRfXyv3yAW1xCLBC
 25KbqmlK7CyV0esa5JAdKuoFKdz8z64XxBQvn0b+2D5ubQ/iG4hZuUtGeCC5Cvx3tgYEEZRpTJO
 Jpmt3m07INfnh1NNn5hiDvjOkFU+Ki6S/sHhp9sRMn9v6rn3xkSVxM6GEcZQH6qbmyu8BQL0G1c
 LZz/bCHp0uyWX8uLPXLf9CPEFlKB3IPoTtwnGh7UTlcIi4ZJaVEChaC9EOWXJUhaQdp628MJfK3
 llzhKXNreJL1TNzIpgdL/4h4e+L1lidxG0dlV1TqaP8PXLaXdbpj6i5Eb3dsHAw9RqrNjezAM35
 nnlTY1jU0XGs0uEZxfAA5gCxH+isCmwPrKq95+ra6+OrMATnV8fTJXHraXc51Yff/ODSxbWw9SN
 Kosv9fWWWbN44bFRC9e/VNhy5+5HyoRCNvk07hxioN8k2Iz27V+8X4RKeEMwoMgGNccp05jMJnu
 EWzNj8tvXRANmSIK50g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE3NyBTYWx0ZWRfX1usLkjmBJWly
 QiYUrPClK5WCF+ZyCrc2sYnnutCjZT+FD/v8+w5+sE4lMXyR5nhOzkzZ2Yay/hWeTeQhw+dcOG6
 LoNSsmIZBpd0AeIJI4fZ8ikjUPbYbdc=
X-Authority-Analysis: v=2.4 cv=c8I+0h9l c=1 sm=1 tr=0 ts=6ab271f6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tDlUhY5aTNnqvAx6hSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: WRdBlHJ2nhrT4LcqfHJdSEvXTEOdDChb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220177

On Tue, Sep 22, 2026 at 01:38:35PM +0200, Krzysztof Kozlowski wrote:
> On 22/09/2026 13:21, Zhangfei Gao wrote:
> > On Mon, Aug 31, 2026 at 5:01 PM Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> > wrote:
> > 
> >> Document the qcom,nord-cpu-bwmon fallback compatible used by the
> >> CPU bandwidth monitors on Nord.
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> >> ---
> >>
> >> This compatible will be consumed by the Nord bwmon device tree nodes,
> >> sent separately by Shawn Guo.
> >>
> >>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> index 21b4e04727de..8c82103fb86b 100644
> >> ---
> >> a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> +++
> >> b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> @@ -30,6 +30,7 @@ properties:
> >>                - qcom,hawi-cpu-bwmon
> >>                - qcom,kaanapali-cpu-bwmon
> >>                - qcom,maili-cpu-bwmon
> >> +              - qcom,nord-cpu-bwmon
> >>                - qcom,qcm2290-cpu-bwmon
> >>                - qcom,qcs615-cpu-bwmon
> >>                - qcom,qcs8300-cpu-bwmon
> >>
> > 
> > Hi,
> > 
> > Gentle ping on this patch.
> > 
> > Shawn has posted the corresponding Nord DTS change [1],
> > which depends on adding the qcom,nord-cpu-bwmon compatible in this patch:
> > 
> 
> Based on acks here, this should go via qcom soc, so part of DTS patchset.

Ah, OK! I will resend the binding and DTS as one series. Thanks for the
hint, Krzysztof!

Shawn
