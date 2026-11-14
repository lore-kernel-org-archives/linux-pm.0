Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657014;
	b=CeY2n3IkCU0wJsADsmX554RmNfd1TtYCR6BwEXiNrwJyIoj/Vs3F6MbEl8MfVrjhXksl
	 Tld0sn5YWpW87zKFduzjx/PWFbiRom/E+2O7OiuqtNItNh97qz/8jbcuu31caNlERF+9i
	 VOTmhovHlP+y7uzHL6ne6biiHG6KuRUgjOpofZF4giFIV51hy3xSofpzlVHMFVT0RCTrj
	 +9HMJOwBnhaFYT9cPdtum8/9NKTG7SJnMCDeL4KvXOwAhsNhfx3Lvc8V1BwdTLYxXDyL7
	 Uur0mx0rYkyVnNm9EAoALtLk9/hERwJwhpa4yxGvPvrd2S/F6w0AJQ/fxaXgbmwNYEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657014;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1/1WLzYMEGYQaXjv2m5ge60WfeRW/hTmJOCmO45FGgk=;
	b=JUwC6ZFJ6dwexkbMB9LqnhQtFRvYjTMBV6aG1f+E3fZhhC7cqptgiX0TZHf4EEbkfEJ1
	 owRY7ez7139FG4vmTz9y4ams9CzHuU0YGFu7WdhWg5NyI2Gu7+9rQ5b4iaqI0z+JY46rI
	 w1whjpb4HdwzM+3xqGtGltWXBSzkoXi8Yywd2t9soJe/eFNptaNdFiPzNFah7mUEiG/6T
	 QphHfRLnSErxH65qhlQaE13EKZq/MXokm5L75/v9ke5FjNa7tR2dKDiDk/xR/sJM5CCHE
	 /rrmNm0ADFsxd+svrxPZhFBdZEHtuGRvGUdjDWXQ1ZPHlIA6ZoFjWSa1cz9/Sn65MNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PiBqRjkM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BmuqHx9S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52462606A330
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52462606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PiBqRjkM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BmuqHx9S
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wR5T3276454
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1/1WLzYMEGYQaXjv2m5ge60WfeRW/hTmJOCmO45FGgk=; b=PiBqRjkM9SPylZBt
	4LD9BvT6t4t8REbdmGqwIYc/Ollq5iLejeb8xDGD+RFr59mzoaWq3uhTy7UYITKs
	MnhtYpWRbdBwtAH68Y5AoaaBkSudeMnzZPWJwsf5E2IiNQnBpHYeQdBPQHWUHhTS
	9XO4mqOnpn7qJSfIpZ6SW+WJ5NIJGdRdNataVC+Z0zxpeV9BJV7TjD6CNNT0L3s6
	01ZLJl3TCsz3eVOWMqVzu/q0i+tu423bKhPMn8QZ4q9sZnpRZKZ6+gMt+SFnnDXX
	c/rHVPQX9tWKPiOnNR/7qOfnxK+yzRXFCAMxGVkobtJGbo3+OoR5wJFr09QI289T
	9mF8Eg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqgsj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so2721979a91.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794657012; cv=none;
        d=google.com; s=arc-20260327;
        b=iSEaPgTc9uUkExvfoGEibPBhKlwwUHFVbOuLRWxXEXRZ9C6z/EGB94N/8VWX9w5LO7
         yJUYFZdhnVMiuf2/kjYqapJt9fkYSz0n6zHQPE+Qkuar2gzFs+k3bqCDyU8bYTtpdzYo
         jPAXFwjd219U8kt1UXmLTXkTke9uP8fg0YeKg4rMkZJ95EnH9oHCdXlYPKB4/clhX24i
         ivyc6onGh4H+c8S1PUzJPHHO5X6/6ZcoD5WHNmvxdmV2Rh3rp8IFJgDIJyk8cqHve100
         uskayscYmounciq8i/eDQMp0GFpubOkEJR33GrllgwHqHCOCXuoY8lSHr/dl1OCt/SbB
         VCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/1WLzYMEGYQaXjv2m5ge60WfeRW/hTmJOCmO45FGgk=;
        fh=YkOCcSNMX9MDfXbfKUXFtrN5/gg0YVODjdKTG92XV38=;
        b=dsfkN9ZXNr6+naVaguSz1E+PK8VMovkjW4uVPVOfrTqYS/15QVAoZx6KahVGU2VLC7
         C4UMSqL6ZZiRHDxCY2jeJTN9DwWuxDJtFGHz5LrHi2Rg4BZCqjvtuggmOwMVz9JS+5HN
         0HDVXoRJlcHTDaxL3qKWmuq306lWw8vgcAo9EvqXZRzK96FbwVGvYn5i4/HpeH/cTAfq
         qx0nu+giTlYRYk6j3Qe5RAFPM9r5ffYEq363OqBk8EGIL6qKnaD2nDUgNzWlEbDxfCox
         9ImWDJx2fKHSEiGCicpkPgTp1KwyZNaemiQzV7TbtkWvRbrdi9GnMu39U1u7/1eMF4QM
         enNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794657012; x=1795261812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/1WLzYMEGYQaXjv2m5ge60WfeRW/hTmJOCmO45FGgk=;
        b=BmuqHx9SFSzf0TqpqiCv8ZHXkMeunnrMk16NmDPtxf4eLbPAN6KqKzOvZP6sF+qIXv
         NgXe5HLO786VpZpMdklZR578Uy9tSiJucNYDEvYvIKqV5QqT1/5qMOVf7MVE98/lZ+U6
         Kudafa2jiOKoaGtPRfG7Nm4tvr7gApEo0hLbfGiqS3y8dcP8pUOB9ZWZEV/eEdCf7tkH
         +mhkZeZIyLn7iqmzI7q9dT95tp2fZRYWWQwrXsOW6mos749j0dGf/5TxfjN8rJo6WcNA
         AZr437cooNFFeJ3EM9kLyovEYTyD8BUJ/nqWKg6kcSXp9XSUR8gFr2LRGzShjS/1yXae
         batA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657012; x=1795261812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/1WLzYMEGYQaXjv2m5ge60WfeRW/hTmJOCmO45FGgk=;
        b=1hn6ni08NSPu28pGnMf7e4RQ5r2vd+IbGWOPip8DB9mX4IJBtpO4a5p79No2zosB1N
         N8UKSIb12XvwTksmcgXWasQMt+n+obyKME/umQ2WF1qii6onntJ4O5H1RUtr9ARGH1gb
         CDsn9ueOqbel9qyXmq1cRL1t7IJb3qm6y1GU5vQBOxc+AypeL7568XpKwgmKEiKa9zWQ
         Pa+U2E+MS0C+4nZZHiT12DYyWzJguMT9phwVbYmHJeimROb+oQS8Ndk8uHZYch1VuWDC
         fRZxFqYv2etfgfksXfsSi97WHnyDrTcODygUnWzVinTAaCiKqdNGXE9yr0oGUJYTifI0
         3irg==
X-Forwarded-Encrypted: i=1; AL+hErF6QIzN6zm0RiZu6MEAB/Cl0KfzDNXqmjuNu18oVRH5Lhu0bO38ymFstnqIvl5/5Fug5ARgtEj69A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nd9CYBCw+VyPSmiHcjcUHr5xCbQLVlBjaGss0qT6g7/cVU5lS
	kkt/jXU2G+2YrisR+8ha3jrSQmQf/VfrbxnjjuhFXTKaKV3lSodzj2gEep/+25Pd7lGCFFwWzql
	+u5gkH1n+tQZ3GWkyWJUnWlpfbnhaRzPIUe+yI7bs08Buz4Owhu42IWOoZNmUJINWR2VBpONcpV
	0L7z1Tqlbw7BE/QFp8rNF/6mZnXbx5Ew9vcoKTctC+Hkjy
X-Gm-Gg: AYBFou262G8EGPnE/IWhMmEnAj7NrosdTbvEizVYLh9FxmH3OlRLRlNHcB2meCGZcZt
	EzVX5SV5d4o6BedgrArcf7w5N1dvIWMXmn5ePXKz/tkECGRdHxVSNyPGBwavHz5ekZy0kICdyig
	8OqtFQQLZ1ETQsom6eWTe+uAlyIdzCpZOBFvSGpS+v5HpKM2pRXNdoQUXjdQ==
X-Received: by 2002:a17:90b:3ec4:b0:3ab:c80:9370 with SMTP id 98e67ed59e1d1-3b1b09e5ed0mr4929462a91.20.1794657012050;
        Sat, 14 Nov 2026 03:50:12 -0800 (PST)
X-Received: by 2002:a17:90b:3ec4:b0:3ab:c80:9370 with SMTP id
 98e67ed59e1d1-3b1b09e5ed0mr4929447a91.20.1794657011622; Sat, 14 Nov 2026
 03:50:11 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105001257.1368266-1-me@ziyao.cc>
In-Reply-To: <20261105001257.1368266-1-me@ziyao.cc>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:50:00 +0100
X-Gm-Features: AclHuK_M9u9pSitA56QWlgF1DmcZaRUB93icyXp210YoENL1vh_SV8siUFJBQLc
Message-ID: <CAPx+jO-OzHrQ2GXfBzWLRHSgyTpyphhvRONCwohg_F3OM8YgQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Error and deferred probe fixes to Rockchip PM domain driver
To: Yao Zi <me@ziyao.cc>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sergey Shtylyov <s.shtylyov@auroraos.dev>,
        Midgy BALON <midgy971@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Frank Zhang <rmxpzlb@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6af84af5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8 a=LTGKUmlCnc3-cF2NnXYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NiBTYWx0ZWRfX1GlTSlykze+9
 sOgVBbTJq2MBTNult4I7D5IINkKoe9iQP15A/Fe/9/jwG8z9+nIDgNrSobk5B3aOG4lSNdL0vDp
 PbLsHe9qo4hH8BvPvlSqYQdAfo/LoQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NiBTYWx0ZWRfX5F3BWrASZl3S
 8DYRSjArLSwQlTKKTdN4RXXF9tzn+C2XsrZ+DI5iaZc0tbQbhSu5aczQyAGYApBzt1yt8+qCXng
 vvflCaUTHBXEs5M95szAcyjTzE9QUqsHn5rktIyK5DqDhyZiytSNPH7UKnH/95lf5TVgj91v20i
 e8dbu4S9KbiHjcmEGLLHX0H/VBdFzIiaygZvVLQBld/nBq5Sq5FKVFLqibZ4hv24KoqJsLinxEK
 37JjKOb1LyedLWVPVYJS4LfMTCOdTo3DmBvMCKmy0Bm3fTSxADnl/xvwyPm/08Axe6WjNvZEj6k
 bcmpsfv8SGm6n04x7NZ6nPUbATOvR4ur2hGFT1JN7LF3djWU9L0P8mKwR9MjxJef/HQ7fzWn5Dd
 0Jtbl7nGQ1o2MybSIMvQIVvahfsSKv25ZDZvNMgLz1SL3+IJlQ52pfUXT46XTfgw29OGKXI3FFt
 9rRX7Q2qEzdUfrO2F/A==
X-Proofpoint-GUID: SgaYkI-lsPQIjHLQNWQiDOxxHJ-TirhV
X-Proofpoint-ORIG-GUID: SgaYkI-lsPQIjHLQNWQiDOxxHJ-TirhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140046

On Thu, Nov 5, 2026 at 1:13=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> These issues were found after I upgraded a RK3528 board to v7.3 kernel.
> Here's a configuration that I used to reproduce both of these two
> problems[1].
>
> Thanks for your time and review.
>
> [1]: https://gist.github.com/ziyao233/a5ee8862d1baf21ad756cf4e959e14c3
>
> Yao Zi (2):
>   pmdomain: rockchip: Only put clocks that have been successfully
>     obtained
>   pmdomain: rockchip: Don't log when of_clk_get() fails with
>     -EPROBE_DEFER
>
>  drivers/pmdomain/rockchip/pm-domains.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> --
> 2.56.0
>

Patch 1 applied for fixes and patch2 for next (by dropping
fixes/stable tags), thanks!

Kind regards
Uffe
