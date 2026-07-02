Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2063374A15
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972531; cv=none; b=U6ngNUz8Td+dB3hFVhuO+PVV0T/YRcEqXFzcSoJwSv8jVu2zUXLpXpur9kpyiNZCo/mvTWEPq6wm86sDi88jGP2fZTc964cb6y/fQcCViAuUCBefzBZX8bftcqlH/v/ZB9UceuD4fdHa0/wx4iUTG5ZChnmFEA4EPJCqxrbjqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972531; c=relaxed/simple;
	bh=YWgBvXVXF70bptWYE1RikhsP4a8CbIlb6SjMxl7HeAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiS2RL1qK3MC649Ln90xrjH0dDGCJzWVln8Zs8wDrQhEjRgh6NfQn5NJxBU8EIc315Kj/kj/5uqDOEle6dHtsrGvdVNDPt8MzDL8mWtfy5NPTCk7bw2qggzpy9q7gTDk3uRY5rF3uqa+8xldbHIACRzjOQUKm8KBe3Ptbgb7Ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEtvmRRa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5/e44vo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEtvmRRa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5/e44vo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KQCe3067877
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 06:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcgaK1dgPNDQoQ2Qef50ug40L7J06HDgu6Mo/n3XcK8=; b=EEtvmRRaK0kWVQL8
	wv5z/u9NO1LzFb/wLEM3JLGhMOEdhy3ZSO+hHhbgT1xuI0RmU/GS+SM/E96TH45t
	03P4MQfL6mLH7CqqQeH6zSNIBq0LPBaJptKwkPi/pCAFAGeHiCxeOktnA1Lp4JVE
	4bC7P0mLIk0hKzUBZ8AxTWY3OPrpqHJ68NlUusEqmG2xura1QwKUx1Ua3+2Y5I+r
	0PHgP1MNJbOYcGSb7A7xsBZ6l/uubrf/RysfE7Z28o57X3OCd8NDvw3rXwbFI53P
	cgF4V4/vYQaJM+h1eTMOCSi5m00oET5h8clQvshlfV14kkxZo47sBsXcBNQI9dc8
	Y37N8A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510am3qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 06:08:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso36399975ad.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782972529; x=1783577329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcgaK1dgPNDQoQ2Qef50ug40L7J06HDgu6Mo/n3XcK8=;
        b=P5/e44voUo+E0ViCw91Ba++Y0I5MNv+wR1Gh6K45/M7i/HHx/UNQU/1TYAeNzcs7fR
         VLW2qPk0g4l3O51r+9jPbPvb2IJJ132iGsBrox4RNkox/lq+x4Nn5jHp22YLt4DI7EXG
         zjYSaj2cuIR6pPItuceZKL4ov4kLgQZKOj7C/Pltmhlv7rFsbihPRvqDjT9frZq5CBNo
         Z6I7Sj7BJJa+TMOji2W7xEUVRVSoPjWtGbIHzPEUidlpN5PxfD5e3aF19TMyOIX8nrdu
         6yHeogpkT2kq5EDmFhmyZQ5Eo0PykLzZKo1FME0gtBgVhAOAxIGzdRtXdqKUuWO4XMkI
         logg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782972529; x=1783577329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcgaK1dgPNDQoQ2Qef50ug40L7J06HDgu6Mo/n3XcK8=;
        b=d0aR+pSLm8C306YuOtjXx5O0GeqCKLfWL39glBouYtzNhQTqyeWPQOuVldT0BGtX2/
         gjCY69nySNunG4oiFE0tBpOm1T+xT0L2GoDXAXPV/Y7mdcyXU5054gwSgP15EOCGwPQ9
         UqppT7xYotIS3DB58qjU9l/tuMdM1nNyhYNMog98WU/pR86WX5ySTbr0J10H8uy6Rm2i
         KM0PGvl8lreZfjahLnPp8YD0XoI2fee8ISpB2klzmeBGSXuCmg5zZbkCRhMt5fD8P3Xv
         Eiww1dc9KDB9gopUzkTJwxJ5IH8kkcHM2sPuX1fT6fhDVg3t44YInLIQSV2+hK9duOrn
         G94w==
X-Forwarded-Encrypted: i=1; AHgh+RqaNZW9JGl0NQyk7bRA5PvdldBQNeExhgpHkunSM8W5SHSSGf4LUPHUvFDpYEKltYfsU2HvH8YO5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4iQQJlVoK2aJD8ohrTmwa+wrYcNmptq3Tp4g9QiRvCMrQzR/
	P4KXUq9102S0jkAdSs7HRtPAc0sxN9SgX/7tWERT0mcLaRZqtRmPQ2DDZ3PGVlnENyIktgnhRGP
	xK/9zEZsP/81mQbxeXb6lxa1AxFVF5zJK6CPRNZgc5bzL/9LNYD1/aIETkPaoIw==
X-Gm-Gg: AfdE7cnVyAWbUEYl/xSNdqU5Ikzhn05Oh+i6aTa2vODeHFp4iwVluliV/R4l2yG3tS7
	s0aw4xHAfgswZIv26kDTGgeNv2GG6njpmVQ7ZqhlwXmy0dGj/bhfFaTPc+Um+BV0QVpDxqdoz4b
	oIWJihyttpHYSUg/rZ7TQbtk4EgC4MCWtwtXTY8FKXcBvDz4J3yYE+NQErtmb3MT1+J0biUwY2g
	3MXuEiAXgUNJPwqTna73Fe5IuMilqYNHwdkASTKqEtcJgkTeiw6Vr7+tdXR0V5T9d1gJkW50Ie0
	PDtIPNL/Fks/7tTrfti6UNewfDyHPeL4Ew8ucdUhmmQV4Ce1Ru4xRB50XTA+X8o7lJGVDg+ydxM
	MeMFG+fnc2mKjNg5t+Nbzz8xg/swrtpVIswliDHNS0FXE
X-Received: by 2002:a17:903:291:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2ca7e6da0c0mr47280175ad.20.1782972529048;
        Wed, 01 Jul 2026 23:08:49 -0700 (PDT)
X-Received: by 2002:a17:903:291:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2ca7e6da0c0mr47279405ad.20.1782972528367;
        Wed, 01 Jul 2026 23:08:48 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm8176325ad.71.2026.07.01.23.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:08:48 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:38:20 +0530
Subject: [PATCH 1/4] PM: runtime: Clear runtime_error on supplier after
 failed get_sync
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-1-6ddc317011c0@oss.qualcomm.com>
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
In-Reply-To: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782972515; l=1363;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=YWgBvXVXF70bptWYE1RikhsP4a8CbIlb6SjMxl7HeAo=;
 b=eGIuy08vrYVbcIxdGvnJdWobvqVc5GrVZ7OD/RcJlS0vqo02DvksM+Tt0rOqqgYWAVVDl+SBe
 dL8ayeM0rAiBuWv4QyRzFiGt3oWGRwtwUlR27Bje4QrlZB4ffTgSOr6
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: x49oj5p67DwC8j0CNJMnvthgZEG6rck9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfXzPxqytMBvaZW
 U9wXzC/kiRTa4gUi2GVJIEdtTtNfZ7GGEy/k3etExGL7kiMeG8CzlrM7xfcUO6T2xV6VXW0Fj/I
 dufOZxKxuB4y2IGVQLczPnLFZ8HZdKbDpXyLkz3myRQNLU5r07Nc7aLPmp9XNUINNryKdxqsPRO
 idvU4CX594/S/3oVN20iicCzQ8YdhIscC20CJb1SuiNd4PHoeiRFmrZpn8Qi7/+oIv2fq3WkKOE
 YS3+gSux5dvL9Bz2NpcRwVWxgO3IgQY5D33ZROfus2H7TAjEAS7gTJiwGuhDfYqBPmVyontcZJV
 CJSQIic/kr+h3DqwZYRW+4p3E/sEXFkjpAwSBYEr66xcTUiYUCkIb4T8QB0meMDgCxagvHZktLT
 JXM3/4rIKJ7zaYgENhFAF0KlGKB6iW9jtL74bhZ+O08HnHGW2C9jRl5nrCBoL0u/jmtMKxOlGOb
 IsSkuqZZI30oVn5TY5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX9FPkCJ8+qCaz
 psonMJxzmBQ2VKFm/sUVB72bfF6cgeAc1ymUKndNHCshbnNgvnUg6ONIK7PM7fYiqKUwNfs4JJb
 feDIMOahxBGRZMlZq0gySGDHrZtY8bg=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a460071 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TbMguNdjUikXwpDzob0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: x49oj5p67DwC8j0CNJMnvthgZEG6rck9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020060

When pm_runtime_get_sync() fails for a supplier device in
rpm_get_suppliers(), the supplier's power.runtime_error field is left
set. This causes any subsequent rpm_resume() call on that supplier to
immediately return -EINVAL at the top of the function without
attempting an actual resume, making the failure permanent until
runtime PM is explicitly re-enabled.

Fix this by calling pm_runtime_set_suspended() on the supplier after
pm_runtime_put_noidle() in the error path. This clears runtime_error
and resets the runtime PM status to RPM_SUSPENDED, allowing the next
consumer resume attempt to retry the supplier resume normally.

Change-Id: Id5067d09caca464f663fc95fe745d037e9c56664
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/base/power/runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..9811d024d140 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -309,6 +309,7 @@ static int rpm_get_suppliers(struct device *dev)
 		/* Ignore suppliers with disabled runtime PM. */
 		if (retval < 0 && retval != -EACCES) {
 			pm_runtime_put_noidle(link->supplier);
+			pm_runtime_set_suspended(link->supplier);
 			return retval;
 		}
 		refcount_inc(&link->rpm_active);

-- 
2.34.1

