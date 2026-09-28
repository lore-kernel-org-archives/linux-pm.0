Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D83A1E96
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602847; cv=pass; b=diZuM/+Esd/DMWKzmTk1HHz4v+M5Kv7zPjwvMCFNjf4dRD9uJWeklfEt0xa0ChyL5oZYz4ynHRMckKPcHIMdKkMG04tV1RAW35ARnK/d70GMGZjc6pviVBY57xtYSdaz5czEePL1rMWoGwzRw1D6476sxiXNxiehfza4L1z9lwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602847; c=relaxed/simple;
	bh=0pyz4HHjVoWmWf9Rs4w1HcCuPm4nEgFAXzTG7e8nIs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYNIIroCrnqtNHwJu0HWjJ+UuqD2jfWHhs2OeMtC/nTjIiX9DROtoh7PRkyhj2tlEb+USa9lPiq2oNIVXXN8a+9TZZ0HiccZeZfHHF9ybEjW2KLa/u1w93urOYpqCLFYcAtClKNC7ZqbjX5hcW+Jtdp3etWfsyPJYbQoyQTmUKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U485Z+kM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VjbmLcjD; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U485Z+kM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjbmLcjD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAJsj2404444
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zZSLT0qtV3AT2pT/zZ5wK5NWtEjRCQSyl08ssPseMk0=; b=U485Z+kMLJbFSvmR
	WkIjc5xdaf/z5680yZzZThSkSR2x1e+GmWov4EZLH8Z9EfVM5gvvaVwtVDeW8+Jt
	LmXUqZiNRAKDs+I1xaLR2AQ/hUx/6TCP0z/BY3XKwkDNQZpZc5B6oNJw6jJDts9h
	rJYDICZFmYTRaqxsK3tH3zHlNi0gqd+BNSTNtiM73tvxXPik0eXbgTVvnk9es7/Q
	XcgqfmdrtG7ZmRXVhtpBfJdFb26QCwdTr7FbhyvHm4HH6/o053DJaz2+2TAj7gPd
	of10OoGdjY8eNvtR623zedm4vrOGcj2JvxYjoS7Ox17YvPtxpBmU0LqGFfhBldiE
	SIoOEQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1qrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:40:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so1589860a12.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602845; cv=none;
        d=google.com; s=arc-20260327;
        b=KRj020wgleOgeGg5j6fBOsi7y99nnAvnavWhK9g6GExZ+OKmiub2JbQR4h/8orHknB
         XzaARDNkQ6RAPkWPBNAmmTpZEu6XL8vDMY6MkwUGJJW9Vtidf1Jf8SEYnHxbQBDuM8YM
         Vz70pHHcxvZPwtzSFLdIVivs/t78PKy5P3/eC7AA/dZJLtI1TpVUlBseAIv+XsxG+RtZ
         c/luIzTAUdUjh8TFV//ZqoQztz5BfgZIEplA0Ky3Dq/i001evsO7b2EQhQcqKdNPFQLJ
         zjXQI3zdu98AFxdJLd3tEuGK1VnKCEMQdzZEuAs6JeRPsnys5AVvI8Z8rWQn7XkSIEq+
         urKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZSLT0qtV3AT2pT/zZ5wK5NWtEjRCQSyl08ssPseMk0=;
        fh=6lP2DrI0ANGjGQPnCvvWFd1KW2GowUTXxjKWEx1wNpI=;
        b=msXCXVgZ6hbPee+YC28K10pkGW49/hgu9ow+cxtiJnhabL7Gzi8ixqJ+kT1r9VOl6m
         Zczk3paFoEk28uSESdEpz0RUhQuJyuJqrpKRAcqe1Zhn8YB8feRgDFG53M/UyuWx05hH
         CavjMi29APuQtUpHaG3l3uAuIxGcr0uPMSCyz0xkvheTDy9KKOVToxCcC6mGTZJjpHR1
         JU0Ln094NcqVCnVC5SIMCLfDrlqenuf148gw+cf6HoZgByj/YcBRNJzl6uDdaASIypeU
         yxNzaFc+nrUcrxShEyXjWZbM79emdUD940q0raF4dUJqX4Z9/6wNeosde7c9MeURxdgv
         y61w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790602845; x=1791207645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zZSLT0qtV3AT2pT/zZ5wK5NWtEjRCQSyl08ssPseMk0=;
        b=VjbmLcjDmHmFJh9Wj5ebsttd6a8e2lsvKBQS+zuQzznMu8iwxRPPNRhnR/+uiRu5Wh
         CBWgfIQ6Iuc+w2JRD9IJsAs9GdQqYhx7zw1RHzexQkGTmMuPBIXXrRs7Mqfu3rPxF+O1
         tlyXLGeFXDFAez8Sw8fg+Hy5jPTuu8KrwdX6MZkb8g4hT4kDPkrOjfkLI+oO7TME3BOS
         VnA/s2eSq8MJIneZlQlQf/AQBb8rtn+ABYs2fgRT9Gh4ClgyeQj+oe7dJjwimUc7eb+D
         l76QKxAnevO47LDtWmw3wiSJYgpbJHdZLiZVj6GslaP1iu+nKSoVcGd5Pox3nuGFPJ3c
         256Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602845; x=1791207645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZSLT0qtV3AT2pT/zZ5wK5NWtEjRCQSyl08ssPseMk0=;
        b=M6P/fmVTx5r5bwWqlCONSN9HmhBr99bXYl2x3VcdwiZMOWc4qZdjGbbTUCrvVqWNZv
         IWVHNy+8PxXfeaxgO3VufytYOu/QjmWsb7M0IZEktM4zApdGlkXFGvxEO1nWR84r5rDJ
         eDtDNTQ5MiqteN3MT1E4MpcN8nPrFUP7Xg3EDMw1++ech3i0So//E3rlDcdkdHmZRoLB
         2Rd6ZQC9z9xrBlnfTyfLLxLxQrz3wktUf1SSmabY2CYHlod3PJOXYHMkL+yVM6eMmnsf
         m7rZ0YIaTof6F6CpUgdkTRPp5/LkEUdw+Si/EZ7JteAKbjNPSOpyqjvEgn6XyGeHv/w3
         7orw==
X-Forwarded-Encrypted: i=1; AKwUvBybtHcys74WVb6QO6t5AWD4lNBclaKsllJkk5+XqahLtZyVd8XFJD4k1NBatHNj3CP/VKTgtCyvFQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lu/lIuO8MqjBGuivh+0dSBcp8uByEjfoDr0aUrkS47UM2kfw3C
	or+l82rvuJrxZPACKl9fj46NzaDhECsm5ipLZlgu2W1TpDT0j3VXjil7sNjFFKUF+4yfZpYbu3k
	udl8W3hBtHl2+6rSiu6QsqqNYYspzNxdTqRyswhfxtXRozLXRousOBAq+eejxug6BD4PtvrtC6Y
	7ZxCfsZvhOYgyKzURJo2DrzMhH0cVL/1NW880X
X-Gm-Gg: AYBFou20xAr8kCCyaG02dTNelY/yqWoiKRyHVjfaJJMBwjf3efh0ez58LZY5z4Fe0ai
	JNBhugBreaNbtQicCGReO1A7L/YgpU4fUrxi2OM03bkw4FQ0r9kcGcASUoYnXM94QUVaYlmbxv8
	iGSvi6JpIKWaUqXHSPqJnCmkPPFFvVmKH0Fft0+EYNgrPDCbPEdIinK8JXFw==
X-Received: by 2002:a05:6a21:3301:b0:3dd:a197:cf2a with SMTP id adf61e73a8af0-3de0e9211e2mr13232917637.78.1790602844610;
        Mon, 28 Sep 2026 06:40:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:3301:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3de0e9211e2mr13232889637.78.1790602844134; Mon, 28 Sep 2026
 06:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:40:32 +0200
X-Gm-Features: AclHuK9sUfyIFRz6KpRG96cJdIw0_h7BlsY77sB9GJwOpGZD6WYoBk9TbbBZqLg
Message-ID: <CAPx+jO_EjZz+MQUUYrkBa42EAGun0Nb8rGrRfHg8HvawaL-tkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Small fixes and improvement for Rockchip
 pm-domains driver
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NCBTYWx0ZWRfX4ELf1mfNfGXL
 3TMD9psD4zEms0XeIoUavZ+knLFjoD+d+hiNF4S6QVPuVqPINtjMlN6BFDso+J4r7NV579L0M9J
 6rDy7MSuDJn6YvZwZoz8xAxHMSXtZAFoydILnNytcr52WyOHuIw53N2BgWSfR/do5IYOyUuybnM
 PkOZfN7ahpdh89gjm88nNPQusn6W9Hoxl+3D8ogGgO7qrpV8/ne24aZPR1zr3/KFW+9qeRzjl8h
 +8k3thFiwdZwzy6IgKM8ZPXWdtvSnBI7ZuWKuXra8KBqfPe5eI0DNmHVx65hMQuqUx3abg1o4lq
 K6Hs3YubwZSwrX3T5B1Cgz2BFGOxPs8KM6VqVWmThZCo3g/4kpQnfbonLws2TiLqfGBlsg7CVMU
 XJB3OJua3xwrYEjkjl+FYzDKdXLi2LircXPZRx9sc8lY8lLRQbOlmRnpYzBJRTaB37J1hWPhRup
 nhTBQ57Klogu6nVK3WA==
X-Proofpoint-ORIG-GUID: ML12TfJ8MVQGIUMxUCxe3zAe6ANYM6QN
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba6e5d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=s8YR1HE3AAAA:8 a=i0__BfBF2mjEo0ecNoYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: ML12TfJ8MVQGIUMxUCxe3zAe6ANYM6QN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NCBTYWx0ZWRfX3FwtchRA7ZXL
 B3SoIgW4L7JnS3J7eOAtgp27smYs2ixH2GgaErFg3pfbQRqRV9/luytgX+8KephGAxjplqCpbY6
 LGO4eKQ0jrwRrT6RJ+6ujb5uWhPwV24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280054

On Mon, Sep 21, 2026 at 8:53=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
>
> The first 3 patches are for fixing. And the last one is for
> improvement.
>
>
> Changes in v3:
> - drop the devm_kcalloc() to devm_kzalloc() switch; kcalloc() already
>   zeroes the array and takes an element count, while devm_kzalloc()
>   does not.
>
> Changes in v2:
> - add Sebastian's tag
>
> Shawn Lin (4):
>   pmdomain: rockchip: propagate subdomain add errors
>   pmdomain: rockchip: fix clock leak on domain probe failure
>   pmdomain: rockchip: don't ignore clock lookup errors on attach
>   pmdomain: rockchip: drop duplicated errno from supply failure message
>
>  drivers/pmdomain/rockchip/pm-domains.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> --
> 2.7.4
>

From the v3, patch 1->3 applied for fixes by adding a stable tag and
patch4 for next, thanks!

Kind regards
Uffe
