Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763426;
	b=UYMkUv07p5fHGFtli0IlEPfwGmJJ/CIGly1GxLGXJNAKT6UIHVe2tfISXVm/2EQ6XxCw
	 nPal+DJ2nGW2NOLn3QRtRiAhgzydRE69lkbCiqCR5yL1a5Im1ZEcd5x7XY9pKxvcvY3bW
	 wLD9R0+7dxhQ8WxXyYV+o6WcKMcUSGs50kJGxiE3LB9drXtzoFWbDrelx7JFqBijic7Jr
	 OYgXqK+fRf1Kjf+1BKWirw2xWi4CUDU7ztxzBo2Nh3mzrtCRpwVyzBZ5VDdT7LBhjv4zT
	 JTIfIaiCHEsX8WGnz13DG6MI+0Kty5/XkGZSCEplq1MiA0EDudinM0CBfCY7uAZMT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763426;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=MJEiBSx5ffbjILwUo5rg7AlqTdNj8Kfl6s2Yyatx3Y8=;
	b=iSqty0cyV3rRdMjjCNnBwltzH3ARcwCtI62gis6B1MgK2DsxxrxwwdpXsrBCssIRf/Bh
	 QAYQ6tU8jeDEVQegSshyCQIEVn6sS75Y/MWnaFLDjKyuEiUtoRJj1Hf3rNSMLGfACGe3k
	 EFvSkaX9oR7xj+1xCvFPcgW509HxCju9uxI58n/Un3GGUUT725qPQNHZ/F2g6SjXBPPnS
	 aZxy0hTIeT3+6rF+ULki8+vYjev7yr8rmOGB1u0UcY+dnmVZGMrQR/uNB8TwapEH8vH8r
	 0Ff4r3Ma5xk1XiqBo4uo9To+k+60C7IOERd/Fwdzw5ZwhVNQWwDayPNafJ2VgtYSSrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=CzyP41rI;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D3606A322
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8D3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=CzyP41rI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=MJEiBSx5ffbjILwUo5rg7
	AlqTdNj8Kfl6s2Yyatx3Y8=; b=CzyP41rIReYZgxueQSceGdIDT2+Nnf0RMa+9g
	0Zl1mSVkgQv46p0JItNf1Q32/F0QE6I7BT6oHfhDsAgfo6WKQHZj4QhQZ9lI2Mpq
	LKqxh6auwmCJhqNVWmL34T/UFqp0SpsrmAxE6iHW3uuGD34ho9l2vALJdeCpj4Rn
	6cUMZ0=
Received: from [127.0.1.1] (unknown [114.214.178.200])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgC3QkcfZttqdlU1AA--.2036S2;
	Fri, 23 Oct 2026 21:50:23 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: konrad.dybcio@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, sre@kernel.org
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Fri, 23 Oct 2026 21:50:23 +0800
Message-ID: <179276342356.98176.10645303509497652146@mail.ustc.edu.cn>
In-Reply-To: <179276335779.97093.2561281074827129812@mail.ustc.edu.cn>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
 <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
 <179276335779.97093.2561281074827129812@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:3pYKCgC3QkcfZttqdlU1AA--.2036S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1rKw1rurykAw1kWw4fuFg_yoW3ZFc_Kw
	n3WF1DAw1qvrsrWw4DKrn2v3ykZ39rZrWqvayvgFWakasxCr15Xr4kZa9aqF18GFZrGrWD
	C3s8tFykZw10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbrkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07jn3ktUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2raZFVgmQABsn

One correction to my previous mail before it misleads you: I wrote that we have
no vendor sources, which is too strong.

What we actually have is the OEM's public GPL drop for this unit
(android_kernel_lenovo_sm8750 + -modules). It does contain vendor sources for
display (qcom/opensource/display-drivers), touch, camera, wlan, audio, video.
It does NOT contain the battery/QBG path - there is no drivers/power/supply
vendor code and no qti_battery_charger in the drop at all - which is exactly the
part your question is about. So the answer for this thread is unchanged, but the
reason is "the drop does not cover this subsystem", not "no sources exist".

We have not contacted the vendor; the drop is public download, no support
channel involved.

Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

