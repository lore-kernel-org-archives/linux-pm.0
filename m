Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE1310779
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001206; cv=pass; b=kgRF89zij0LXgG+bLmUsUTGhqAPnA9U+/BIVtmgaJkYAg5Psy5xxSDHM1M1Ix/CLKew6ppgQ+HeEpmcNltiEFKzu8Jpz5+S31U7yQ9fipeWGbLVStLs0/hc/8g28TuerHVvz18ZdKjLZzPmb3njS+NiDlFQvn0nZUJKpOAPE6I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001206; c=relaxed/simple;
	bh=sATvNU5ARPGH1MnYpAlf3xrGfZCKT8Y42kVB75zG2rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se1QebyDT9cP6V4+H+2A1WeBWS3LUaiRDZhc6fAhvDW9GwRlDeAVNnTat4RhcI6yUhJNCaw8OUAmuzEJFuU9GjYbWzbbHOP8CPvI+EQPvcE+sjL3QQJ+6uiH6gec5k1LSHpgyGkkVXQU7RBDdQWTv5X01mtHGq07bjf6fH/jkzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F0ZiPI2U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X6I1Rnwy; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F0ZiPI2U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X6I1Rnwy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGNd11553091
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+OnJW+Je7ol/VY88AJ0lhYndGRLwxR+wIaVhVdJ6qE=; b=F0ZiPI2Uv2FWrawN
	CDPcczsZ5X+BvOtSdkXKG7ToN+WH3qhQORYjkSShmhgY0zY3mB72whzOkiKsl6qv
	LzAOahApWZAZXDvwaI0UGGPO1P24N4IlkmuO4X5cP+84cDDBKpOe12fjACXtyEEG
	egj23arLVe5pPiEXCGCPzNW57L4FlTFTfWCMR2e6CVxBuOW06X6bsYwok3UcfmPL
	9c1MdGNdY5i0XIOzO2b2Oxj+iehQR3Ac50ojRniKpadJLBdT+tQH6KtKN4IIlk7n
	ehdQy02E1ql6/mcSt6HYQmuABrjiA4YRyC3KbNFfsJmdRcaDOUIZa9ktzXqbglvz
	9gO4Bg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csgtu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso75822265ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001204; cv=none;
        d=google.com; s=arc-20260327;
        b=pbUtwFjF2xmphxgki8BTPspLRQctvPBuSqy6wcnEXhvg0GT1DcXdyxK5T9ZDFUaVPZ
         ti7m4ecJMarDg9BvuPsnW0AkyBbr9g7gCBGdll3WJgd2PmrULYQjoO2Om60vjRESxlbh
         cMtUax/+0/jR09yIisqvVb6+JM5tEgxY+rd8yUZOAchySHZMkyDWBKdgNLYlb5Of21qT
         Qpzj3oWVxt7RBUMUqo6KllCNcDJETY80PRBXMcOTfqWLAQhHXKhpwWj6BmA7GHpoOA1i
         3YbAUyyHe25TcDh4chW1YN6iPRq6bUxSrOy4bLJNEuyijHoKDRHc2BG4HpC6Qy/jNjB3
         ngTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+OnJW+Je7ol/VY88AJ0lhYndGRLwxR+wIaVhVdJ6qE=;
        fh=2fn/rSI/Lm+6mMn7mrJILyDceglIbDu9oZ9pf2m85jc=;
        b=kHUm3MGg69W4xVQN1pUYyFUp2/LHvwcBjpBstjOwxj2bfEE5I+/gwtc/2h9bkm2+P+
         o/r5suUd6oVAgZMhRbTIgp0gBc96P0tMbyyuJ6IBPMO499JSddQ/LBf8Y8AcWTlmzGlo
         xyklQn8L5nwQumHNBpxFU/4j/1KEhIvCVWSCKkhOSPjIL31z1SZX80rbw1eBVYmuGsTK
         lqN6QWM8nLXuZ6wtucPadhWWu+ba0ekpe3tGjjTu9lan5efsUr9JXyz3Dz+hRwTHoRyr
         hKv6MjdXeifThcNiwXeX41todkT8sX4l5s3/m64Jv/Z7UaEUzmvuXGukpOM66AeQl5Wx
         u2eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790001204; x=1790606004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+OnJW+Je7ol/VY88AJ0lhYndGRLwxR+wIaVhVdJ6qE=;
        b=X6I1RnwyULI0ayduABIf2ykW30sv80k9ZhE2Q9FBKoXb9LvjQ4vCSpw/3fOfzDnHjM
         VguGYrenbWu4jLc8ba6Ow0TF5pKXFVIk4ijDfsjGLtLQeCfEMVeYObe0USKjX4r4rqmr
         QsrdhGBQu2fZ67yZtO1P3F0vTrHLZVqivCGHnFjh7wJvU9HTzX9VuZPSNSF4PhniwgK0
         +zabMUcz1pN1A/hnrASWsCpkIWX21Dcm2JpIIjQflcL8VRQeS55pdYQ9mhxdPXXRRRqU
         jc0NcMjSynjZDI+80lPWyT+oDN+HdJd+KtFvKrgN2vnGzWxAYpvTExOTL/cErVm/LMhQ
         g88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001204; x=1790606004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+OnJW+Je7ol/VY88AJ0lhYndGRLwxR+wIaVhVdJ6qE=;
        b=ff6wIkk8r6FGmkCu3sQ2AGIigg4bTPkqvFm1zuxk9jeRU2efB0znZu9gimeHKzIoHv
         HOqDrT7tU0PPzCqAGwrC9zjb69WdsdbVDPCWfZ+UO4eualAuh1qRx977wmTaoV4g5wqF
         7wBCzBApeEuxn00TckER7boZQ6OLVj53NfIejZhc2aR6vf/9kjH4XqRAm5OhpDeaxnB/
         QDf0rpb/xzBFHZrZOZpjnK94Jl92yPCcob9YbggR66zRCsx4ipI41Jmn+LMqFrw2gpcE
         ShvyEza+eD3mKwth69QDXI7ilzW1/PDNf6k4tri6OjjBO/+Sfib8waHGpNOVNxLm+Ovu
         NfFw==
X-Forwarded-Encrypted: i=1; AKwUvBx6r7FH2Vm/4/mSmVzhyGoyjd9fBXhuOerQuuKoInqhNcDCkkikKTJoC9sqSG5kjkgKSkegwkATEg==@vger.kernel.org
X-Gm-Message-State: AFuF++mGSZF2GJ9YJ3y/lj30jjSY3q7T7F19naNC/ec27oUCaVWEg38e
	BzxiWSfkNdsZ08WZafZhV2P8Iqulc/f3Fk8uJ78DeTEBaWOJ0UuONqWYeqsg/0FMc6gY1DkOjhZ
	+RwqkjbzrpvuV/Lex+0d6Kr+F8YLgEEmRS7fNxjZRv1Edg/H/b6DXn9bwupJRXG99MBSt7SPlYb
	6bqYcI5xBxWNMa+A7vLwRwfzzwvdlreRYOPj+b
X-Gm-Gg: AYBFou0MAlWGbOOx3RkL7gFyfj7idMlcPtvCMBngqkm4Bw01hx/rtCJ8NEVfGTAkbiG
	TyIKAIJnTY5ajTQOrpSEtdM0uTuS8R/mnLGiQyNtl+AzKE9teKh0deWIJLN3XLDmc+4dY4v1Q1T
	hkIdQpeQcXTGHQNJqvQCnLGh1zS+lr4ONOZJk/+6PFvibK0jwJLK4t2DlnEQ==
X-Received: by 2002:a17:902:c941:b0:2d9:3bee:4f32 with SMTP id d9443c01a7336-2ddb1b9a350mr168383695ad.20.1790001203649;
        Mon, 21 Sep 2026 07:33:23 -0700 (PDT)
X-Received: by 2002:a17:902:c941:b0:2d9:3bee:4f32 with SMTP id
 d9443c01a7336-2ddb1b9a350mr168382345ad.20.1790001201286; Mon, 21 Sep 2026
 07:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907061237.28169-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907061237.28169-1-hemanth.selam@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:33:09 +0200
X-Gm-Features: AcwNN1WNonjPFfOApeY9wJvwgx35yMtSwgIvToN7rVqLbJMrCQIClZnNJ7PruzQ
Message-ID: <CAPx+jO9bgR321FDpy89HEyoF9tjYZe2kdyCiyi147+k5FXrtFw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: fix typo "releated" in comment
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfXxazXCtE2Ulhu
 75w/f152WCFcLxnRygopVtEsz0chYh6IJD224VmwzwaM0FuPEiQrVN55fTne3vu5z1gWxAIDnXI
 SYfZ+3ogelHlQ6cma71uYrsRV0XzzTQ=
X-Proofpoint-GUID: dp6GpdDWngQOqy9J23DdnM59vgmMFNIf
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab14034 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=rrkdCiAnefG2keYV_MwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX9fi9gIJT+vS+
 pT6tObjwfRvP+N0D1bYWbv4+8HM9frtmoHgx5oWjhF1MX/bg2GcetJjDrwT5XJ/V4AfltTsHxF/
 QuW5wuULQJbSLMNqLWbw1NZTGR+F0QzDFRaa6vG1sAyKOOVG5SbKSwssx5ro61KmmHhGPWHx8eV
 qvW7izME7Pm0ZljdOGCbpRHS1cGi9hbNyLRYCX93co7mWaYF0KXbCN7nELKELgPCthnb30aSykG
 Sf7zDjV+eeTTrxMp+o6dvfIBTjMfn0B55/bF31O77pPFlA1z9hFM0XwzIS1KESRl8+eT6F9dX0w
 QIf9LMnm16w2YJYx6scw6QhxQPnV++MLIfMn+PW4flArYUs1fJ8bJSm+06ULoNGAVuiYs4DEHfo
 FP77R8BolAGnGLqabKGtnHaU5ScbbJzCkWjYBW+fGVxvx8XbH0TIQW33MwjZ7R5TOzkjKwPRqRV
 mPzqHSVLP99XqsQ27Qw==
X-Proofpoint-ORIG-GUID: dp6GpdDWngQOqy9J23DdnM59vgmMFNIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211

On Mon, Sep 7, 2026 at 8:12=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Correct "releated" to "related", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..1a58aaf8576b 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -940,7 +940,7 @@ static void genpd_queue_power_off_work(struct generic=
_pm_domain *genpd)
>   * genpd_power_off - Remove power from a given PM domain.
>   * @genpd: PM domain to power down.
>   * @one_dev_on: If invoked from genpd's ->runtime_suspend|resume() callb=
ack, the
> - * RPM status of the releated device is in an intermediate state, not ye=
t turned
> + * RPM status of the related device is in an intermediate state, not yet=
 turned
>   * into RPM_SUSPENDED. This means genpd_power_off() must allow one devic=
e to not
>   * be RPM_SUSPENDED, while it tries to power off the PM domain.
>   * @depth: nesting count for lockdep.
> --
> 2.48.1
>
