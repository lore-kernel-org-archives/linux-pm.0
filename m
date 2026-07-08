Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34240928B
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526402; cv=pass; b=m0l9g9leoBFq1QY2S3QuASSRfZYcoZ3uiOi5K8ckg2lGv2IEV/IUsC6Wnfm53Y99KACO5m3MqDHPvVwd8iaYcURrnWKCXLY/e1H+Lmfxk6HSIk2cc2Y81oLxaFJ8iZfjEKKZhg7PmpxylujUVgSa7O7oTr5ftegtJ6rS12u48wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526402; c=relaxed/simple;
	bh=S20u3kEIoDTzgKRFIDn8D1YCZgVa4uT1ltEDRmJ5pQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1t2N4oyQkjjP8GNU7bqS2+R7fC8AR+2yBa7PyLW1H35VXraLulywSRASATH6OMKk6cHKoLmr/x7dhxLo0Ki5cZ81hf4C5By2YxhayhtoC+Shd2jrdtY0XHJvjTZbYgMjfk3uatY+KW5tKy7wLEx3kXBWFSWM6if0sG1Nh2SPN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joLcvzan; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h1YBQe2v; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joLcvzan";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h1YBQe2v"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3EGZ2792336
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 16:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=; b=joLcvzannCuf3Ryg
	V2K/EMBuiTgNwVujenQonsGEky+ayxJmShjkbJJt+EoBPez1XnLbujmHhejHNZC0
	sUKxfVr97r+FGeWuLbLSlfpJNGv5X40kvQS9OfFowNKaZFN5vmf71h/iGriZzweE
	JjL3aUgfWB9AERjWRq5Y4SYXQw0CVyiY7KUVJ6oYYf4daNwD2oYozgpvCNb2bXnn
	s4WrxFtKp4DQJK42g7VBjAGqT7XRrEZr4GbO/EeO8sJuyiS93gnHiwTDFyQHyNh1
	QomU2GcRbfc2ilhey5UZFJ6HOjjwCNYRFGx4rMNcFXkG3UbcPQoi+0QX6sJInlzh
	Mf6XTQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswbb8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 16:00:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ec3146553so160627385a.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 09:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526400; cv=none;
        d=google.com; s=arc-20260327;
        b=aQbV8v+mHRn0BRIyM625EYlAsX1VbhpO7jWzCsedBkfhrFF061e4jygTd0qHLSEu3g
         caf4NpccoGXkYdNcqK/rl7rHMW9lfb+QbmBfD+tzPMBgLw6l1ECeUxlw77RWXAIS6R/j
         OKpi2tiSqXEJsmZ/wDDiQrWeu/8cob18ucxcsJ8qPaMnGQdmaEDlNjZ2G6IWOrhyaW97
         HefTfEVvIKphXNLw0T9ZGvLEh01XzQDJWajilH/hvOpdL2pGk8kfa8LK+HtCfggBuNAj
         7at9L2HgUcaQj7ma0WIunpWB98LhjQ063LjqFKCdQ1Yy2YHaHOiEuyjlHObonr6zIf+P
         bayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=;
        fh=dY7v0inwvHPup7hqEu7c7tK3JM22n1t2SatZLtVdQbY=;
        b=P0DPH0qDO75Q5UaHIt3NtOfD3vn+u5W+0NxdGfvkEvOX2Xe9QFcnUiqN54KAPdzpjI
         9M3yOa94wrzESd192d4OzeVYM6sRyJ6zlLvUxm0pPFLFbx/WIehLi9M7yumnNJnmmD0g
         Vzqj4QvhhNQmUaiei6S7/wDZ1yKhn+Tzg/Z6pJodF4+JvXjJpH0WF0vhfzf41IfEieNX
         3C+TqllQDFl3VJUSbamtHkCGfPTIrzCpVJK5/pN5qU0fbJX9PXiS6+Fky22q4qScOGOO
         adBIIIqDi42KHxEguHvPw6vPLUMwXwyFZ4CXHYR4TuZXoREpUhsSezvkbpsp+VkK0NdD
         V68w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783526400; x=1784131200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=;
        b=h1YBQe2v//shd8kDga5BzfryvT/XHVbtkksJrQaZq3Q7dA+SpFH3YayDMYfQ6nfPTv
         zJFf/a4iR1ZEDL+UKe4q51qKGR3P5i2eP+gOxXFQX4N2CdB3CXmRqbpS36ASyrvckZ1O
         iQj23l3reOeebx3KBPBkzTSW15wV8lb1I1w9UTeLJhAX2I6zRvGPvCeIdiLD0c7RK24K
         ACuUemE8P5IESonLUr6QybuWJyg68Ab7tlIJlNnMBPzBpTaNOp5EzORXWkANoVOg+tTK
         xIapjtmhbiC1xi3T3uR9N1KAhbz28813Kuvy8/ISZaysyinwqREJHRkZCb23KJ3PApJB
         JXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526400; x=1784131200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXMZY/w5WVF0nRMX+GxiSjwNGLzZb02w3JE1D3SfZP4=;
        b=PnH+lpwBZVXa5CZzA476fbQJyVKhJJ0mTAbeSqiH3hTYQcf6cezxPv62OUCBz1X8Ar
         jHzK9QQFCSMATXB4wjq3e0bzMVcKCjYGe3WgQlv+kxhgLhCbZSG7pdgs95+ZaE5T3wWf
         MYVmJO3rBBTVeEFvRDp8PvSwaRJTjo2jRTjXVSo+dFPdY7bxgguuK2CbiOnx9D4eTetP
         fsqWtJYiT4+3l0T78s3X7rrO2T9B+IIerg+Wz3pcQR/9jU2veV8zrJGMCYHdQJNphsz2
         2Wz/vA+uyhjsx04Z5lix4bKkuXmgJs4/+G9nAaiMN5jgBfUGNAZhmFbjo9AWqB/WMDgj
         WGNA==
X-Forwarded-Encrypted: i=1; AHgh+RoyIephb5FarsXj7gioFOJmyxvCfVto4hb7+84R1y2Dr0k+KAYp9iPaM5c8No8gPk1J1of/9JyusQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlZnGDB33MfW0JKXMvxOnWobyudRt2W07lDH18FdMCpGUebty
	dqEV5aNdNu9Zk8xaZx84Aufw+s1NOSYxoQ077dqF6XFxcdWaRXywtAIptT7mVLrjPGltJQP41Ys
	UkvGmT+e7tgGoqcAfl35bHdvayMagxwS+iUGVnURSZt1aKZKLHZq1BQc0WZvVgRSiRDwB17ZArU
	hZ2s5YkzhVotZnfquYSTc0amO6/ZisndIpdCvO
X-Gm-Gg: AfdE7clSJMVm4rW8CD515hG7jpBeJnJPiajYZdtbTen9GAxuU5y6MFLH8BhwiXkeSah
	ymbUTTqjmHtXBRHpNsKjlkWqW9qrCK6UxnD89eicBVf2l/KvHOzWupAw38P+Lpqdu7izjqZjVyx
	xqzbEdl2Km3Ndl0s8hBwGi86tCSgEK7ycXNEFpu/FpJS3ulf4n4exqCWcpKAiEBdVRvm63
X-Received: by 2002:a05:620a:1a07:b0:92d:e54e:72d9 with SMTP id af79cd13be357-92ecf5c527emr315767685a.1.1783526399236;
        Wed, 08 Jul 2026 08:59:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:92d:e54e:72d9 with SMTP id
 af79cd13be357-92ecf5c527emr315764985a.1.1783526398870; Wed, 08 Jul 2026
 08:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
In-Reply-To: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:59:20 +0200
X-Gm-Features: AVVi8CdAnkt7W-EK3sRgfNkIzKWDE74xqiNiWEwP6a_AAGRkEBuSzmKj65KtehM
Message-ID: <CAPx+jO-NMUPfXJpSUa09VrA=naiiFTMpg0qzqi4QeYbeeK3SkA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5_-ZLVik0bBx6e-LFH5gjtqRHxeKsJ4S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfX+KWM/qoxElrL
 x/u+7bzlzPkQduNRpDJzMBzQgl0UjCmX523ni7f0qalo4PNiyaN54s47TVrBWilc8Ok2Py6if/t
 /T3Kxe2nnTi2l5cluPuYA/P2zRaF0r4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfX63ZBC/we39zk
 wFjxC2SdUVL7Yq12m6MQ7vwVcHEZUBU63qKt8CuVRtqgwAuEZOz9YZ2pcs2sHH7IWuODJsJlMly
 06kxQhH6H2qwAHiqouQcTNErUMT4fm1ssf64DcBTKBEpgy9d2wK5jfXkAIOdzqosNP8wScZz7JS
 gLyLBDhM/hTxaXOeGK+uaWEkA9DHIqOEfz4b8c6yKGHK593BAynJLu7GRqtFItLkbJMm1hQZBIQ
 QbQynrZIvv2d5cE23bxl8H8XJCxtCYbBEKXuXn9oasJZwfiCQCrUHp8hiGmYRhx5cgGhi4f6pvP
 HwfGC8H7OwIlrQiEwT7EssublNhtH4c4eVnvEMV8BeNqbClBXw7gkgl4ANO79VhIOF+wPaZVea9
 qZhScck+lvmJLQRWEBY4PLhyJNtbaye2tcu+p+FtpHaX+x9NLMjlPccnJPYpYvz5aFwxHv2DhKO
 i/It7hiJ/3d4ZPrrJoQ==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e7400 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=P6ToQuPI3Mtl0Vbz5-oA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: 5_-ZLVik0bBx6e-LFH5gjtqRHxeKsJ4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080157

On Wed, Jun 10, 2026 at 3:22=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> There is an errata for i.MX8MP VC8000E:
>     ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMI=
X
>     power up/down cycling.
>     Description: VC8000E reset de-assertion edge and AXI clock may have a
>     timing issue.
>     Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate =
off
>     both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent t=
o
>     VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
>     de-asserted by HW)
>
> This patchset is to fix the errata. More info could be found in each
> patch commit.
>
> Sorry for sending v4 at 7.1-rc7, no rush for 7.1.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

The v4 series applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - Add R-b
> - Set is_errata_err050531 to true for vc8000e
> - Link to v3: https://lore.kernel.org/r/20260409-imx8mp-vc8000e-pm-v3-0-3=
e023eaa245b@nxp.com
>
> Changes in v3:
> - Separate power up notifier fix into patch 1
> - Link to v2: https://lore.kernel.org/r/20260228-imx8mp-vc8000e-pm-v2-1-f=
d255a0d5958@nxp.com
>
> Changes in v2:
> - Add errata link in commit message
> - Add comment for is_errata_err050531
> - Link to v1: https://lore.kernel.org/r/20260128-imx8mp-vc8000e-pm-v1-1-6=
c171451c732@nxp.com
>
> ---
> Peng Fan (2):
>       pmdomain: imx: Fix i.MX8MP power notifier
>       pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
>
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 46 +++++++++++++++++++++++++++++=
++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> ---
> base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
> change-id: 20260610-b4-imx8mp-vc8000e-pm-v4-1-a978b40c59d0
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
