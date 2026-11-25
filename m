Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795602865;
	b=GRupjDogMGzxOTqdUTvxeBexNuQQhF6QMzw15INyQmDloC8m84lDMJrgziJA4ekbKGOA
	 cYBfSvWm6XIH3z9KIDfY30u6u1ddEmOroh6k8ISii+qvZclKKoByRlPkjQIxdZnA0LcEw
	 aLiul1UUsyp+sTa3igaufC5yqhTeQkD71S5XIJzFG5HfEeu0h6JERvHSND8vGKlqWqrHd
	 K1nvCywljFxglMCeVcgm6ShTfTxO5HxuXE4ICwd2N9SztoQZHaScJIe9qouj/ojkFj6pk
	 zdNoC5OCMi/JPcZjidAJFEjdTxzLRq3GR14aJjelytjWj27Sq6GyH0y70v3uLuH0hcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602865;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QhX3qlZ46C7QHPDAi6gO1rqKUJVvN9Ln86oiJ1McZTo=;
	b=XtmU0NpTOq9bAgw6TKHA+4cuh2ktOV7KxAS370wE48ErLU2HPk81WNhnH7EKtRr8D4Nr
	 T8tQOtGCHMqewgaqv3iI/ibqS2sY9F+6J9txnmc0o+sij+KlcEEM9Hk0Efz5drcqbu3+4
	 F6jSrD37Zc2/GBrQmxi9FOmbSan8DcpTmddtne3JfzL4BvT+jjSFjzO704KtGOmQNTsel
	 fent3FILlHBAJ5iq8jpHr0vEc2shgX21V4qova3w2lLc7m9ZbT6t8ZDzlyNDBnNwX1Jle
	 nzOtKvJLj2dJmxypPN689bhNo4+ZytPSogD3jGabyrJPijxEnfVREUYMSqoid+WH1zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MTlNwwTQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="ikYVrG/G";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88E60A260F
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D88E60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MTlNwwTQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ikYVrG/G
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mBmu115133
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhX3qlZ46C7QHPDAi6gO1rqKUJVvN9Ln86oiJ1McZTo=; b=MTlNwwTQXga43xmW
	iM7da30bnloXibrktMFcBqpiXRmX+ABlAZ6LWDcXrCAu0NK0regToQLoMG4X1IXy
	G7tQwe8D89/7GJnRKRlEyOM4FK4yU/t5GDBFMcCZ9zrfTttxMThIoCkVE8yBJV47
	VNirkCtgmLSpMEBLeQa0468ZGW7teO2Cj1gccoqV62Hs1VUwiqyGtwctvF2INn28
	UDR+w28YC9fOR4dapuOlrgxA1VUKl9kwwYJA8zPF6gEKUxe92PZn5cz5Tq/3UmkH
	iLj6bhcMtxKNs2MSEsjmLBLLEPtQ+CuCaAGf7Z/c2vlRF6sd/6D7EHg4pxZkIP9l
	iWGLsQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxkccp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:34:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b41f4ca1bfso4437594a91.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 02:34:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795602862; cv=none;
        d=google.com; s=arc-20260327;
        b=IRFYYPEh15WnGa0tc7Q/oOq7V1cAPhre3mWGCpPD+WzqyrLWTubK9JEAB3kmdzygT/
         QsMfWOTDmEJX185LQW699C3jGvvX14dqrqgZSZuhEVLoeVLDmlRxthI/gPCb/8TkU1w1
         JsFHahCpSt1qkEhu0SxbGvxDbaDRpzJT0nAl9DwmXU4e5o5JvCzBavvduZtKFI5o4mH7
         7TnurMLWEGDbxeb5LTt1/s+F7iauOrNKl7ayFA0WGkBrCZwGEadWGhYrv/4uLdRyr8U0
         E1cSJjXFyiP+uNaD6uL1HNMwI9QoL0XZOl//8q9/Cd2jOSTUUz3UAe7sDJhWfefZg+om
         saqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QhX3qlZ46C7QHPDAi6gO1rqKUJVvN9Ln86oiJ1McZTo=;
        fh=z97hTyfnyW1vGE8ySgYKn0TsnPwzeJiOBR5k6aPR9XM=;
        b=IpEalzlXp+JSUkypJNkBujm8kh5E1crnsKPbb550e9SBkiKshXxdsGzwuZ1V7dQGaX
         guuXOyJWxFdlYUafaBnfW7j0LxSvuKmDhsSqcJg8VP0rLzOIel05a5RSA0V3C6+u9Ald
         qSY8wFRPi6ngbpJqhyRTlvH6U7u6uGRDHShFimXXZSQuFAl7WIde6Pt06IrBu66WtTnF
         yCE3c//CqRAH/Qy/f1aMSAI8X2Zr1tTwtKnLI6MAa7Ndc3TtlpATCnWXl7eaWE2oc5ve
         h9O3II512l+B/ohRTGjo/i9bWXHTbwo6SBL3kHsWre4LN1TnkbwNwbnSgcpB7naZOTiA
         WOTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602862; x=1796207662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhX3qlZ46C7QHPDAi6gO1rqKUJVvN9Ln86oiJ1McZTo=;
        b=ikYVrG/GZVAulKueWOaFTJJixcBWGII0Ze4+J9NdqGZ7mT1POgfcLCPcrEOnGXIEKt
         vdgYZGuRPhm/yB35jVCyEh8ul0CboFwpb9G6SoTPCGSGoDfMp/IrQzUfszm/fqAbwSr/
         OX9pWERAyRf6UtPzm82bOGXp0E13gZhc0/Qa04EVWolL3TNM+67xhRn7Ply8UzTjkbzx
         DDICb7Ur1TcpGILPIn9ixvfmSRfASEHzKMLNmxkHLodkQoUGI36dQwVLX5pa+bwoVu7t
         6WJosC/Y7QJVydozS61+KAVtZN2k4j3p4H+Cls3ps64qsyqh75R9XTMK8Q9qhp4UP/sj
         KRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602862; x=1796207662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhX3qlZ46C7QHPDAi6gO1rqKUJVvN9Ln86oiJ1McZTo=;
        b=opbEU0gdNczkag59ZrLjKCvT4sMMZfJouwLSU2E4cuwd6RNSrCKRWtd2T3FvNyAzxf
         m6rufHKiGoh9ZthabbKh1TuwiZtwK24egfJhnMqTg8VtH696omE/ON7Mr6quLdi2tr9K
         VPyT/5ZK67dVtAaEwlq43XpzpPr4F4u7yEnygng9PGzpGwEBEAvgwO+JpAitKR99rbVf
         F6RTOWj4EaV5ZPIhXHFFjjVyNkGu5dzuRwgxBaIDtfrRWseS05yD35EAnPOx98HM5hJD
         Y1bxt3w7lcgxCEwL1SGpGjHm2e97AMyY36IRCG8zKTqpieVvgXb4oCZ6Av5qFy3xHfrP
         wm6Q==
X-Forwarded-Encrypted: i=1; AL+hErFy2/EWFeSqf1YQI43X6NqLn8m4BOi6pB8vITNd+3/IGoOLbbqOQwF5zGl0QW76jgGdX/EhH+qKCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z83Jde1TqmHRRebI99Nr1yNOvaxssloZ8X75X8vEZCRqsRTEMCp
	+MMAARFlEd5EMXAMz8uCcXvBg4dFY4Y2bX+tyETu/dE+2bYMggCI88kkDsZDLWkjEo7P/e0Q492
	JvLbj4fMvlAArO3pUpr9prRvzRVY69a29K3eB1f493CisSUEeJ/lPELPVYa1UHdsGgw0Exi4hk4
	DQv7WDCbOviFtLoJrU//h6KjJooK6ssHSg/Xuk
X-Gm-Gg: AZFdTZcCzzWy1DlZPYH4T60N1YRSl36EqkBsLTdrdH02Fd2WsViPHg3M3oFL7Xc2BzM
	KMRcI01b6q+gXo206YixUPpADZ6VPTe0uCFmHA+yQHCi3r4JT12P8Nj6cZ1XJQ++7B98mwWihbP
	R7yeS2vj4IAvVuFAproGhWcH+RMHb6VFiG8lxu9Cv+sqkPmulJn9FzVPdkDg==
X-Received: by 2002:a17:90b:2c87:b0:3b0:a37a:230a with SMTP id 98e67ed59e1d1-3b41c911819mr15585907a91.25.1795602862224;
        Wed, 25 Nov 2026 02:34:22 -0800 (PST)
X-Received: by 2002:a17:90b:2c87:b0:3b0:a37a:230a with SMTP id
 98e67ed59e1d1-3b41c911819mr15585881a91.25.1795602861775; Wed, 25 Nov 2026
 02:34:21 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org>
 <CAPx+jO-37Km71oSW+zOO7BBWLj86SNCn=U=EGmBXdC5SfX4nbA@mail.gmail.com>
 <20261116072442-GKA100890@kernel.org> <b7d7ac2eee0e64aa7c267def5c2a8a022c7da425.camel@icenowy.me>
In-Reply-To: <b7d7ac2eee0e64aa7c267def5c2a8a022c7da425.camel@icenowy.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:34:09 +0100
X-Gm-Features: Aa3M54rH_iaUZ5ip693Y70gQCtTHGqzR_7H39x_RiS3GWAMpcjgQcywZy4Jp6MA
Message-ID: <CAPx+jO8bY7WZjeSuOjNE1=FxrBhs=M9fxEJx-r06c2S84xFr_g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: connect consumer with supplier via device link
To: Icenowy Zheng <uwu@icenowy.me>, Yixun Lan <dlan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX3jMfz5NYjlPX
 9ZHJzHtcw48PtEO5AFrbll96V2NI1OmesNXvK3YzAIn/RJn/2/aSM1Pw3dOwd7ajZDs7B4UFCvA
 cvOtbCOVL4hmGD7hi21d8coa3zeBxZu+Z7c5/np07qiuzBf25/8PTFhV020KDydXyn5Ghh43IuX
 Op9HAyss97sNMGa8G0PwAGe01qhAMAyfupepEtEucOh1lXE5gF2QzO0rZ3ofbIMIJaxi5HePIh7
 /k6yKL1QaPRMINKzc+b8i591nwmlOLp2EFTEWyQdn5w8RVLIieP68uDkwZWkjNCxDMH54k26oNw
 y0xGQv2dQBFFs4DnrcBpv0YwJP8DGYAO8cFiWmr5kK5DtMTtmCr1g+JhsSeqCAOtSaK43oebRcg
 P/32JigafoyPTlWplzbqt5yVDWDPNdfsqgEe5T/xM77l9kdrCOcb3SSqjPTzkS1+qwrpRAmyqIZ
 RwbYxcqUXqoT+cuU3Zw==
X-Proofpoint-GUID: FMVw-PTf_FmpknktEjghmNEETRzNVDXJ
X-Proofpoint-ORIG-GUID: FMVw-PTf_FmpknktEjghmNEETRzNVDXJ
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b06b9ae cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=8NAnHuo4LRsqlWi9iDsA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfXw92azmAbU0+q
 it88WKmcqL9YYF/dGY/TqRIClWx1uyhzTvQdOeTXRoCIQ5IhzMddZqqEIPeDtGbuz1527twZYL5
 vp/RzO5pgKHAeg778qsOmS7FQv/At4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250041

On Mon, Nov 16, 2026 at 8:47=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2026-11-16=E4=B8=80=E7=9A=84 07:24 +0000=EF=BC=8CYixun Lan=E5=
=86=99=E9=81=93=EF=BC=9A
> > Hi Ulf,
> >
> > On 12:33 Sat 14 Nov     , Ulf Hansson wrote:
> > > On Thu, Nov 12, 2026 at 8:45=E2=80=AFAM Yixun Lan <dlan@kernel.org> w=
rote:
> > > >
> > > > Connect downstream Power Domain consumer with the supplier
> > > > through
> > > > the device link API, So when the pmdomain driver is unloaded or
> > > > unbinded,
> > > > the consumer can be automatically notified and purged gracefully.
> > > >
> > > > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > >
> > > Can you check if the below commit that sits on my fixes branch
> > > solves
> > > this problem for you?
> > >
> > No, I've cherry-picked below commit and it does not solve my issue,
> >  it's a different problem.
> >
> > Problem here is the pm consumer side isn't aware pm driver is
> > removed.
> >
>
> I do think it's just better to prevent PM drivers from being removed.
>
> Thanks,
> Icenowy
>

I tend to agree.

Unless we have a real use case where we really need to unbind a power
domain provider driver. Is that the case?

Kind regards
Uffe
