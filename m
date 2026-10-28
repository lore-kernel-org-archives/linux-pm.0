Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179513;
	b=IMVzLdewCoukwZTG2XLNNkxsjdiD1CQ0v0Ck0T1ZkcJ91mtiwQymo46aYeuEq3pDEJtu
	 zvye/sspdUcqYws/S+Zp01EQ5g3gX2HJZpHSXSbdvCUgIgzhmd7Fz8HJ1SIhG7W1RwZx7
	 8Pp0IwLr66rZdllqXaJLni+gHmv5O9vWNVhC4w/Fkp0lsLsRPOPy+I6ZAu5o35g7X33gH
	 ZGyJKOAcGqznfHev2/d9g94u7dDp4oAw6TnP1VBVoT1DSsS3BjkX3w4C8KaQ/VpjIfcJ3
	 GeNPrdiFQznam74vE2sMTLHwMYGC4bo4GkIUvWP1+JrRd7dzdrK+jzzzbD/QNQ/TzYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179513;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=62VMoYXkfPS5QzKDj53WWofwoLriBF1+o0OrOqpo+0o=;
	b=5AoHfHJRaAAvzMzEnJ3OdHwVDA/ttnXY6mTW50PrzWo03r8Ori7DxzQLHjCNGPkEnlOl
	 8EksePTH1qzwGb9C0R+bYg1gB9CWEjef4V9udZ1TFIx/kA3WOX5lCj1FnxpaMrQO4kqfw
	 BWh2AoWbiHdfHM02ofH6RylWfB09DHhEAm4M2zcUdE1jR1FUQAnyxgpBSXzPE8kS/2CS+
	 clbC8RqOm3yyiGy0BMxHfwt+TUmsqn3Qes29+VnaaVjKPcEPk251iKlw8RlB760LlIUNA
	 LUKBvde0i5k/ObD9MbSrJ60xNdlGXN4ndGQj63OCKy86FmHjHVwR3pNaoGESUszT9bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="HtxcpXB/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MxJOY0J3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B1606A31C
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 994B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HtxcpXB/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MxJOY0J3
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K4Gt1667555
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	62VMoYXkfPS5QzKDj53WWofwoLriBF1+o0OrOqpo+0o=; b=HtxcpXB/qEuNxXAh
	t6AtZymXEhq/oIxoneT4AnQhSEjqzJ22A46Dc+e9bAS8iuhbhR56XKtHLh9+VPGm
	KFux3upeU116k7rIZtCWnp5L4m4T5RXkJsGFm4T9uGsfcRFNJjmZLOMCv8huhVmo
	xTtOzDNYxIf93WHiM1xF+L6xJTa2GI040EVhW2yddZZJ2+/6tAEgxfnTJscgbHXe
	LiKX2KZqIAll0HDii9ZwnelYD3Sst8kN3YdH2IGFNIpye6OHS4P8jZuuotj9vAuh
	SNkC4oup6NJWLpYPhx4iNVi1ppFXOxaT1VhXD7Wf0dtF1zMZuoB5fxHmZYkiWjH2
	fIz2nw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk12ptvac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:25:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ecdc701a2so79365085a.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793179511; x=1793784311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=62VMoYXkfPS5QzKDj53WWofwoLriBF1+o0OrOqpo+0o=;
        b=MxJOY0J3OqMNkLC1KxCj5oRaN4hl9/6Av1RsmlKapqdTrAW8Nzn+oQuMyCIRE2JMto
         AFD3Mjm+pC37vXpMwVwlTQks9IjP47IbQCFWrt8Kln/7iypyeZhJbnNy8lOoDeTWT4OS
         V37ophdbDcbfovqPVnfx1nrucsR6unHJClbq30CPgsQyjpMw2q2N8F0VfbdjumOIdwW6
         KQwpk8JS8vW1xj69NqjwRT32J3ulvQ8Q3BvKDVV7+WRllJM1jqGBSPkDo0XXD9U6gzaf
         Q9ARHHkvLsudUOWmc73UbQnzwwa16nygMZJvlgT7fkl8EXgeO2AM0ZWGfjK9ZRTb5ieS
         XqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179511; x=1793784311;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62VMoYXkfPS5QzKDj53WWofwoLriBF1+o0OrOqpo+0o=;
        b=D80GDq8Q59o5KxBq2Te12lVidd9V99TBzHeOXIA0eMcgD+Grz0IISra9iFk/4mEsOg
         kzwd/z2vJcpMdTxZzLY7+5rGh4LnWg42MO4Z6cai1m79/TcHsmeatENEP3/kpxWZZ9l8
         YHRT6q7G/iRqmNzZrjHoLYhT6e+abIRnpntXatoYuwHywdpCn+MPWJPLotkO12l4bgKd
         w8uWiqRU6LgmGFUFhNuAMLe4nzVwk2Rmdo3k7kgO54eXnJZtcWbJoREyTQ7arOg9vBR1
         FLyETJ33qsWy+RiyphskD24aJLv5hHcnjiQ7ZmgrjrQw21C+FnGr2UIVx+awmJxk9O5B
         7qsA==
X-Forwarded-Encrypted: i=1; AKwUvBxXvJ+JjcYJ+ZtJHT6uCeBSt0q+NlnMOlneydfbrmTeyPppADGisw2d+n5mdPgLUtJoNeHf5J4LqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIbMj2ODjTSUkEVtKgqIlQQspFjkCSE27RdgTQFtR48Yf3q/jLC
	icKN8RJyEGauXdYLv22uTaMlpf85jHGS7hVS5e1pu6GCugs3m/7mRd/CB5Gqy4faVXtJV/BF0mg
	K8G4ZVpPN2NZFqgjZEQ+qqcYCPLwTspJNs0LFUqtHtfxR3EpnhUMli2ls1OcWgA==
X-Gm-Gg: AYBFou3fRRnVcbJQwazmDtIs8+tONPq/DhQfUF9PMydgA2rBT76QXEoyoYe6KTIdQ08
	6ZsHBhmkc2td6EOk1rAyiASyBjJD/koMpTCJHEJJvEMV5CKiIGmytJuFJK/VyDBaXMrO9Hl9Z+c
	BQXLgr2IsMQjvOPslJdCSaFikTva7+r1O6M6XnUxgC5YYIHiZXQZU3hMBhWxuSdzGxQCsiEjuSy
	roi1xjbZEcA0jnyTxF7nERGddME2756a8zbkHpZrKAaqqYE8736EYfx+NFp/LraWn0qye/70yFm
	DkVqerCFONvshiFNdj5A9XR+ihvIGKwAMe4Mzbk+92WvRbWBVEHhWmu6a961o2+/vIsuUY8m0Ez
	CF3KP2V1M1kFpl2ZgR3p0VQYCPdp9NwxqUgl/ZIgpMETZ/MtJ1ttvyfvTHfJmC8l0yQYO/ATrIe
	rZ
X-Received: by 2002:a05:620a:26a0:b0:939:b8d6:9b1c with SMTP id af79cd13be357-94408a72eb2mr214268685a.19.1793179510714;
        Wed, 28 Oct 2026 02:25:10 -0700 (PDT)
X-Received: by 2002:a05:620a:26a0:b0:939:b8d6:9b1c with SMTP id af79cd13be357-94408a72eb2mr214266885a.19.1793179510221;
        Wed, 28 Oct 2026 02:25:10 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a969e61f9bsm19434555e9.2.2026.10.28.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:25:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Birk Skyum <birk.skyum@pm.me>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pinctrl: qcom: Restore the pin configuration after hibernation
Date: Wed, 28 Oct 2026 10:25:07 +0100
Message-ID: <179317950511.9885.396157708908521949.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021210425.57066-1-birk.skyum@pm.me>
References: <20261021210425.57066-1-birk.skyum@pm.me>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aJ_GUg9x1ouZdOrKv6cf9y0IlabWDGPR
X-Authority-Analysis: v=2.4 cv=DtDDa2/+ c=1 sm=1 tr=0 ts=6ae1bf77 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=B8HrD5q8qNSOtOt7yzUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX/67DXoOHcgG5
 ACFIlTBpggpYBMFHwkmN9pRS3mePW6HJRAQ55sZnXk3qz4I89zhkAzOxYhW3rImUsZPLbVNaVJJ
 bpusOwymE46fAjB6C0jKQwQoRxjj02QdsgpLh7UK3Nr/pnPhzIINTDwECJQjtAHBH5yHDT5yier
 vTYGtR9nwIANFh6iCCx2YhmbQX3H5CVAy8cThYf+yDtk6Pl+bG/DPnEiqutUH75yxoXQcwvproG
 5jANxRdMhdCRhMxrF+NIkyvAGY1Kpqn/1JTsiRfmbNJUp1Cw5o6p4C5u1TU8q7vKbPL4LXff0gF
 Yv0SkiPlMkAEoJfn2fjxF0oMMGYRJM0DjI8WTFDF5Pp5h6tSXQrV/hIsEeIE+DUlrgGkkG/Ha3R
 wGuvVW4w3qr9Kg0h6jpsiEwLuKdSHzCoRIBewI3s6EAyzPaloSM58cvl5T2VtPGtQ2icbNau884
 Vk2kKE6DNYPG2Nx6l/Q==
X-Proofpoint-GUID: aJ_GUg9x1ouZdOrKv6cf9y0IlabWDGPR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX4Xod+adAJbDN
 7k6QlBKhenLHAPvJoh1Yl3a7lgYuwFc6YEYGEdnERYXQ4giNigeJih4cExmJzRqu6/79pGcneNn
 g39GbQKuM9BEtUrV4DDnGA7P7ozG8Ks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280037


On Wed, 21 Oct 2026 21:04:35 +0000, Birk Skyum wrote:
> A hibernation image is restored after a power cycle. The TLMM registers
> then hold what the boot firmware and the kernel that loaded the image
> made of them. The restored kernel has the configuration it applied in
> memory only, and nothing writes it to the hardware again, so every pin
> that the loading kernel did not set up the same way stays wrong.
> 
> On a Lenovo Yoga Slim 7x (X1E80100) the Bluetooth and Wi-Fi enable lines
> are two of them. Their drivers are loaded from the root file system, so
> the kernel that loads the image never touches the pins. This is
> /sys/kernel/debug/gpio before the hibernation and after the resume:
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: Restore the pin configuration after hibernation
      https://git.kernel.org/brgl/c/30d9a180c86e3cbd53efb7152e05cb059112f6eb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
