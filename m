Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490144;
	b=FyGVHhB2p4I24OzA+RwFNLsSy3iEVnVvV7UMoi4uD9UQCbrZcu8ywYWOF9c+9G8gJrzp
	 yXQqra+6XNeFCQ0RYEaGgkjETeW4kX4qWoB1ofAc+XSbQhzgdst/povzx8VhhsULuBn1Z
	 uIPuVnik+7IK8+7g9QRp8eeYHMr/1M/ftA96dUqX0vSw1Ca2zSAoqyrng+roodAKLCqIr
	 uo2DsX/fqvx0eeK6vBQvXwqgorBQO+O6NX7trrhgVpPc7KoRAsQvag4iS+HWgsr3mtyP5
	 KRTD9Cq8LZewWTTx8qgT0/HLg8stWIuE5pgJ+Bt6fnpSrzROkN8V4c2TX+/FnNQyLFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490144;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=;
	b=ybukkvdarRqEwhIq5RsyFTjNwtvv2hDSFgAeeBD9MCZ3y+HZJDRQf7rgE1DXRQPhHG8n
	 Gb9V9XsjB9/mW7GNZuDv9yO1+g7/clsp8e/xEhMgIXkQLPVDGTJLGpUoBNs47zyKZavuW
	 Rn6Hbcm9s4lLUb+9h2JONPQUJVoQOyJQE0evau+P0Ge+jwdvvpAZzZLUZkp//jLVM7fBd
	 5iUaIVUTpezukW2zpkV01T6m2QzsLGk+1xwyhN9tMK5NI5SjGH9ieUxhffDgA8mUP5/sm
	 WiURq9RuQXWUScJ5qg/fuMcAc6SiW8NxSVSh2BES+YI07XGhaL9loIvOKlCCB3b91tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oGhfbJRQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4lcd52M;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4222606A33E
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4222606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oGhfbJRQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4lcd52M
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8PRL33305949
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=; b=oGhfbJRQfvbeZtL+
	gRLH62ZIf4MA+U25I+PDRuPyk3QHkdugT4eAvKiayCW5npyYzyJWZSh38nfuwHxS
	2S5fnql5P/tTSZEPLqTI9Atpv5fD9QiTjXtbjFNAWs8FXqf2a7q3VOGzY1FI2GGm
	Y0o0YsmNa5osTkvuJJukEkRj2BL68WkOCY6PCvpKEalI+R+VLusX+p4W3qNsdNvQ
	rvBTV1OvyBPwEFpmx7qKaZYXTYPgRQMzkkIYl7trIUQyA/GGxGb1QahgMrtAkgI0
	F+z/DuP5f2clI8F6zUK8Gwk2tFAB4qYbpJ05CTUP9qdJ736sc90bqRTXcUYv+x7k
	B+DKNg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5sswcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:55:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ea6b66e53so63045385a.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792490137; x=1793094937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=;
        b=Q4lcd52Mf5jpeLmHrgE+XmCKc0GGcR0v0jygipGqHcUb6bX/bYeD3AYW/+TZWcldkg
         fz0vabmj99SdBxmC9pF3VZFNvvzTauJpdA5pJSdy2ierXBpfDdWAYXGVT45nls/bxLy+
         j6s5U44ZhdDFhUoFdche3CZdN9HzOFX1A1oi5smpQLRtxZsHWqD84uq+W5o3qR/CoNwn
         KGwXX1opecTpe3vndPe3TBtYJOeGSPdpUnll8wxdQ8tqmhu+C3dlbm1Rc7V5psQb0Je5
         gHyD9+Zh+XBKKY2BVZ7c4qTPNgMxvxPH8gyoSwGTOdOyjA3qpP6/z+GDX00mF1IjX/Vp
         7oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792490137; x=1793094937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsdVoIWtanFkfPd5/aWmmlsNnKRMvO6g1c/00z/cnbs=;
        b=uZSjfQTPLuksFPcYpLY6lZs/LePQ4jYmx091R6e5AkDj/EteKlHX4Z5z04DLvXJXSL
         PZDg9fDYNkFyZna4gQNsXMSTW95MIySMk74svKY4aHVK/esSNj0dESQt/nlyfYsr9LIy
         p+c3Xj04rqSo1ySW07GCevfXdRr6IAN5Ak4RbZpvb5jMxWKoxZNEZOp8i3EW8rwDNPOG
         EgpYZ8AHbRgGOvx6GwwvleH/HcAvJ0P7+tFyMel5VhdkElwJPB49ALS/wRkr4va+W3Bj
         R7h60QKJDI75g2gkjsYeVZiZV3lf5Gerp0haVMRqWURvVk6elFVXsq0167lAyrWLZGK2
         +dFw==
X-Forwarded-Encrypted: i=1; AKwUvBzaoPKiQ8Yu8YnsulWHhRhljWHLlxuTwDgow2sfskbV2321cKJMjm6MN9pt/g8eEYzo93iKHji2ag==@vger.kernel.org
X-Gm-Message-State: AFq9FYKwEw5pTbeHtDd0ISyWrCnvavcludWH5wQNUuezJ3KdJwQj4gQG
	Z/DrD/8Hi9LfbascH6sxxx7vhnh7M8ggNZUGUVujfzCCpzxmwZ5furdGQ7ad8qHXrXXAQAsXHPL
	J1AqBE59Aax4VQVzl4sAlOArqR5jcWJAgWFezd6D7NGhrlC/RLIjr5/5AGU8cEA==
X-Gm-Gg: AYBFou0kAreiRpu+uMsrg9ApRaChkRN5v9Xxq6ciNMYlKmlSGAp9WxLAhOAX6YC2lUV
	R6jNyKcAtHjzLJd98QX1CfeIUV21Zegcdy59hKW0sredjb2qiEwpiMh/OjSpFaNeZYk0i6H6zJt
	SgIsaTYxaxhJZM6HaIcFrk4T2rsmkfSO1x+wFe/9ivGPJ5GhJTJ46rJDmQ+tAnXZmzuPQkXG9RV
	UHusBaWN+E0rJt3NskZbie/wbCRzIOEDiqlgOV5k1V/P1aU86yj3uZ08tqkvRFasGniMrU0bu0m
	wFI6dBnclG85IYsh/I74lP4K3Q18FxuPcYazoaIu5rHGvi983fDhhgxqXunRrnUlMlaFnJMqtgE
	5xRkUUhNJuoxPEBbhEMpUCw==
X-Received: by 2002:a05:620a:3904:b0:93f:977:5d9 with SMTP id af79cd13be357-93f29a13be3mr1820738685a.0.1792490137128;
        Tue, 20 Oct 2026 02:55:37 -0700 (PDT)
X-Received: by 2002:a05:620a:3904:b0:93f:977:5d9 with SMTP id af79cd13be357-93f29a13be3mr1820736585a.0.1792490136680;
        Tue, 20 Oct 2026 02:55:36 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb4ba6sm461409766b.75.2026.10.20.02.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:55:35 -0700 (PDT)
Message-ID: <4ec618a6-052b-47de-8418-e0e319af10ce@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:55:34 +0200
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
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: expose the charge
 current limit
To: Joonhoe Kim <26rote@gmail.com>, sre@kernel.org
Cc: kamal.wadhwa@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        dhruvin.rajpura@oss.qualcomm.com, andersson@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261016124806.1789-1-26rote@gmail.com>
 <20261016124806.1789-2-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016124806.1789-2-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzOSBTYWx0ZWRfXx/LeyB0PY/TS
 w0kHpAbeFYFbFYg0Wbc5o5Mqr2Wqdu6O/ZUCVAV34ozXQsb1HXgJlzI+xbZFxCPhNBSg5zDvbPa
 eMbxaehiH8pRExquzy4cSO7bDcqVO6KQRqlQJ7TsNLSzIBgZae3TTPKnaxDN/YiB2pBOqh+S3Z5
 5jkzk7jmMn8mJ/Ohym3KBNAwNgVGqO5Kwl6qQycD7GG/RZ/nFlVXPXFwx3SkhPm7OWW1Gd/zsUq
 X3nrOgJKkzefDuXUS85PrhNapSzCyniQ78f/dGZ7vkZSB2H7wG73IWm7DAVfrjI0zoF1wC16/vS
 MpjFK2wBxoIX7gA92D2vSCsjZ+GGz8iKPgF4M0Ym+Bc/cyJ9xGlFcMfQBrYJljsnupep9Un9CG1
 Mj9DN8DvRK+gJWEC55cUUQb8IGGX0R6Ol0rXifCrIor4sLHat8qgOOKh2pyBu7n6hRM4BhUcrtL
 jtEDy6inbsNlhSB7TAw==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad73a99 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=CtmeqFu_9xN5vWxN5BkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: xRjv7tDrSZhS2Fn2GHupaDjjKQ8MZ4Ee
X-Proofpoint-ORIG-GUID: xRjv7tDrSZhS2Fn2GHupaDjjKQ8MZ4Ee
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzOSBTYWx0ZWRfXynKTvxpEMoIf
 y1M6n9X4LDR03tAe8J0eSX9Yg076zPTzi6Q3JLK+TRsI22M7I9QXIRG/m0GK6PO7sWOj2CV4MgU
 lyPFDDPrB/zjp8pcf0ndhA3Bu8gOePE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200039

On 10/16/26 2:48 PM, Joonhoe Kim wrote:
> The battery manager firmware takes a charge current limit in uA
> (BATT_CHG_CTRL_LIM) and reports the highest value it accepts
> (BATT_CHG_CTRL_LIM_MAX). Expose them on SM8550 class batteries as
> charge_control_limit and charge_control_limit_max, clamping writes to
> the maximum.

[...]


> +static int qcom_battmgr_set_charge_control_limit(struct qcom_battmgr *battmgr, int limit)
> +{
> +	int ret;
> +
> +	if (limit < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&battmgr->lock);

guard(mutex)(&battmgr->lock)

> +	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET,
> +					    BATT_CHG_CTRL_LIM_MAX, 0);
> +	if (!ret) {

LLM suggests to add:

-	if (!ret) {
+	if (!ret && !battmgr->info.charge_ctrl_limit_max)
+		ret = -ENODATA;
+	if (!ret) {

to prevent a possible zero-maximum value coming from the FW
from messing with us here

Konrad
