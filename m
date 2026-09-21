Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04F44F570
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980110; cv=none; b=pR0Jl3PssQQMn8wtibCkSRqoiLyLoc7EO1uRcl3yXIAZMcYtVyiQzK7ht6Tknax0nI1HnNIakc0XBiW/+a6kqAyAzrmsBTpGXuXqZ4UQOwGEFtc8TEjIfd8NDDtm14ryDROloo6U93HDQ6SnhvpasNUlcJBlGPconRgUftvPtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980110; c=relaxed/simple;
	bh=V3z8Q6QM1+WIqVVJT9vQ/tq1lzesanx0RdBKGHqMMbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ08i6hvnFlp/M7fmFhhQe5XmVwcSdvhTnhi/j7CttVLoNTCO9oSzc+zvZ4ckA8F/w5F87pPkB+Hrk03jLYEzq34NORHx1k1isDO2PTXTg/57aVCwwky+OiEfQSkP5Z5dSnJ2ng8uPyhMBroK5S6nZBUVxB59QqCttVyE8xP9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKTI3DfR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8DNAB4J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKTI3DfR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T8DNAB4J"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L8aRBP4146614
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6ShR4rnHoHnEXINqW+ybyNwN+9yX7I48PaAhsMmBM8=; b=MKTI3DfRTnrbkXS8
	DC5LyWbpVjMR5pijpL59QVo1Kqh7nRIYxJweXPtHjPuKhTDIaMAzbFaYArH2TFLa
	J8GYEuhR1D50eDS5Mklrb15lNiwQ6L9r4k9BdAQzitu28bkt5gljVYPAmwlgDVrU
	4Eg/+ud/CRkJ8Cvsf+CebnPOe11QvSJ6wpq4Z8g3Kapuvef3/ZAyAovRc6MAyJT2
	OUerinnA0a/K4C7yno4dhkjiyEfRer9RfxsB0SbaE7wVfxUQvfIdfP8y/J3hqpcd
	g+NUbbO5a3f2e3xOUT5sQA+20E/Howt0PD0+Bng8u7udBRDYq7KddElxqvZ4JZaB
	DwVYtg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gr0rb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:41:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f925ba4eso381397385a.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789980108; x=1790584908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6ShR4rnHoHnEXINqW+ybyNwN+9yX7I48PaAhsMmBM8=;
        b=T8DNAB4Jg09GmlzlRGtRkXiSTKr9DGNs3mO2MOuVkrIYrQQK8Ckp2WNKOAuOE5zpbC
         gTU020IflzjxDVRKT6bdzQZPaCn6S9Z5B9f9eYs2cCenLOWNIMoY5RJc95hDbttIGWO3
         0LrSWa7ztUv9WDeZuk1Y+MO6LnsMBja/iMwdOa9kNKYIMDD7k+ruv+671aEJqQIbLg8c
         xlHdGEIvi5INS8Edh2cpzSvKMr58Gx+RDkN0OvTuwxXBbuNQbz8G8uFNhJxdxiiDJSsb
         MyeGiUtIB6k66jZENQSREeymLSawQvS97zYthJ+UnPnlZZ5zR+6iE0lvTRK8ZOktmoDK
         dpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980108; x=1790584908;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6ShR4rnHoHnEXINqW+ybyNwN+9yX7I48PaAhsMmBM8=;
        b=c6PrEfPcPNBW4m5gfCP5mDQxDt4HTQs3XHqq1GGpbN2GOjI7ZBQnXdgP6oLD1ivHKG
         lOqDz2cz7LXUFtLcpIp4WGSQqreAXT4LRNSOCK2Xdv2MfB9jG+On+Y3UCyCeuKIfR6aT
         awIZXaGWfSvc/HK6hUGODsnv9Ye668UxbkQ+QHwUBga72HmJZtzZMoJXqigYeRTG3XSk
         M6B+Qo/izX3dkNbJPR2Fnp6ES7qlSSb984XZEebJEqi6f6f3pqT7ifIp5edKL74DHWZl
         Jn8px89ANBIYgseXX5Whv9FZkHiGzNEqQo38h996zj+Is7mJZ6yp1xg9EiM6uhVm6cSc
         h3Tw==
X-Gm-Message-State: AFuF++n3b93GJRuY5CObO+KesdNCOMKvrGV4NHVQKNM4sfGH6sVnlqJ5
	Y4sVKeYD8SsQYnHn1gV4vgHosS3bf2z7478pfkciQ1dtmKhopzFwqROcSye6PfVmuFyRk9Ry8kK
	VzuY4vq03UiWkmClAkF/4iZQ6LqMTSLIEbKIHqSwfHltu+3oS/EC6S1bW6gaSIQ==
X-Gm-Gg: AYBFou2HyI6INcEx5sLDS4YivGe8Drx+KxDKI0hiPjxbQU7scJlfEMsJMg2o1vjAjMi
	S3vdCtx4lTf3ocMvKAzrcaHGo85GS5wSqu9ntLXSVGFmdBQjmjsXEznxoz/pMnylATK3JlUjJQk
	bVlu6Fd27UXWW01yYImoJv0P0cUSxxVIdfPmZVt5Cp8UGA0FAC086zWwk+rP38PDdJ55cTxFOSi
	ikHoYudN14aJcKueO7KXmrrEaE95kgI8VG5IiaCMWEHqz714Fp97Zswz6Jr+ShhxXhFojhtmEWP
	j0JGF/Dcv8PyO2W0cwYqbBHuM9rXgPTW9B1VjUkG+kPNZDap3Dd/IuoYraoOki+SPLaXo2hGlL8
	7EQPOu3bnkXtfGRMSCtwn0uluyw==
X-Received: by 2002:a05:620a:8808:b0:939:13bf:e861 with SMTP id af79cd13be357-93bf56efb11mr869353385a.40.1789980107761;
        Mon, 21 Sep 2026 01:41:47 -0700 (PDT)
X-Received: by 2002:a05:620a:8808:b0:939:13bf:e861 with SMTP id af79cd13be357-93bf56efb11mr869349785a.40.1789980107158;
        Mon, 21 Sep 2026 01:41:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456325esm21220967f8f.15.2026.09.21.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:41:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: (subset) [PATCH v2 0/4] power: sequencing: add kunit test cases
Date: Mon, 21 Sep 2026 10:41:41 +0200
Message-ID: <178998009681.23332.10018072172593243626.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TmwbtWTc4n5qLdbHPWXomptHDSNY4pMy
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab0edcc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6CFNrt-8cbJvt-LAfKoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNCBTYWx0ZWRfX65NzEg6qRjUm
 ntnrNjaaRNsaJSPhtEdzIb6R3EHwyx2MACTVdlE+BbbMEDuOHKsESn0NlG68o6Z+2SRf5dpRnxN
 khSSHgSu1TLgrM2rQbc63XmJkfdB42t55Z9kpfL4SZKKGzqxCMKkI36hp4qBw7m/rZraw/AM0FC
 sgDO3QvMcgW7dJCSESHAavMbKUApX31rehLNmEdTmkX+HWVYGqBNwysfpEA7S2KvT39bn5ZRUsG
 7z5DGJYcAIFhCzzjJl3swRUu5McMUeOByuGg1e6OR8G6w1XarPcKC6XM5FLfnAPnyrHvp5lFkYe
 SrvOAcpLKegyLz0s/PljG2ZoUqfK0orMyX2JZFaAP6GaXpt3WZE7fMmBWNw9+0jgHeF+AL2viyJ
 jnymZgzend9gs6l1mPKJFolSWn2PnGU1wU7oOM4OrijYtZi1cbHuptkkBUiaFD7BTUgEu5YOz7N
 v91tHGwLVgK5Mf5R2vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNCBTYWx0ZWRfX8JWkyI3vObQ/
 iY4xlaBARU2NFK2SkUmHHOScHJ+ZWG/zIcMhqmhtYgDUIGGUYmj7+JEAYVCryUDSzTnpzb0TvRo
 j9FgaZnTinPmkMaFF60BhIjTQcMVTic=
X-Proofpoint-ORIG-GUID: TmwbtWTc4n5qLdbHPWXomptHDSNY4pMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210124


On Wed, 09 Sep 2026 14:37:06 +0200, Bartosz Golaszewski wrote:
> Add a set of kunit test cases for the power sequencing subsystem. Also
> fix issues noticed when writing the tests.
> 
> 

Applied, thanks!

[4/4] power: sequencing: add kunit test cases
      https://git.kernel.org/brgl/c/c42e50314a7629ada42a605666b18e22867a6b44

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
