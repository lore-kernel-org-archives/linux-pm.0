Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1304D98EF
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690675; cv=none; b=LcdnpDzd1crc8RqKPI4/8eNOEGUCkn4BplgHszbmDiQ+BsNPrV/SzhkoHCGnCcOXHMRrwetEmOs7V2hbpxaa9Uty5IWJJC/jj76Laymqaf6/M3nCeZF0U/3HHuePUC3si74dGz3n2Zc0XTpgP4WHB487idaXeVvbOAojl/uOqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690675; c=relaxed/simple;
	bh=vAmyCpUIu9IUlplJc4rGmydGdjUb6w4tYNaPIxlBDiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFxQp6iBJdJcJt06Zfw318JDhNf0mxyS7E12QOYnlcQJbaClSwPwPgvhG2EGYTR7sNZkG/jiPzQMxdu3Gj5hhlU7COAoqoUYOc0V/gtfwx0GhgZjNDDiX94aJsEnA8Vqzx21N6MqZaQDPe/UihBHvpiIomQIXUMni7vwvWMiyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cf3SfnnL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ToXzwvRY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cf3SfnnL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToXzwvRY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGAv4v2524359
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/yocMUcQeW0PxY80907g0p8nmDgbrIZycpfry1XcMUU=; b=cf3SfnnLkQ+pkgYE
	MS33afG6mXyDivAhUfoDnbMgQdWM5SSnBmh/t+YQKOk0CzSS/H/p5gqggy/bz+Ld
	kUoeG/PH+P+Eie4YA/PuNweQtcaYkDgPM0jm7xDzeEYM7+OiwaPXJH62mTGO8gBV
	HkYv3MlyhmuzTA3I4+Y9vOzgWX/YB10Y3VMfzdwYDL78aVMwcC7J/KI372xBw8a8
	kSKyv6hUieVWgbKOybaOU4o76LKGM0LUtBCFKhnR4PqdlM6igEomq6tPPCAIFHil
	f6CH3F03k4IRfc171OnKO4bJwhW4Dz05WUK7ZrOvWveSOSxSzVof79L1LLSz6o7N
	w8YjVw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjg495-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:44:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ef62078ee7so9262077eec.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690670; x=1779295470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yocMUcQeW0PxY80907g0p8nmDgbrIZycpfry1XcMUU=;
        b=ToXzwvRY73EYoxvby89bNOhglHuAmWspKwPbnjoFHnQVXYiTUCfWsHGjAB0b//pfas
         ZPqZZF9dz60NsHH1IEJjPzxVx1HYcyxUckzWbMPToJwZELBL8lpoS1127a9y81G2bQTS
         2dvPBP+4hcGQNL9LoC/YyARtFlYHYIg+Jcv8FQYr7GIQdjHLbz4/K9ximKMvz7Sdvr+q
         aT95BE5JKt8JXTb7lC1iLDanTzDP6fzJuQsSYT8AcL3FJQ9Na5L+EoGis7RfKMPWAXil
         lWFpSwHLZCbE8yb55Hgj39+9rktZx32gOWbA1kEdu6rXAkaqE4sfD3nDXJO5Df+70HCV
         0G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690670; x=1779295470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yocMUcQeW0PxY80907g0p8nmDgbrIZycpfry1XcMUU=;
        b=E1CvjcmUoq+91D66J4775N/+DeNSltGr9vSRbt2tLGa92giBa6ZNUycodlxgOilfnu
         GkMTBmBLI9T+rYsLmpSZArBDyR7oDbkkWILXbaB8X+OdY+h2c0vYlBc9FiXtaGKu0oSR
         kmuMkBgRyYZ9f1KtwnBbwhzzN85WtSWa4XbS/p2wlfvnrcn1qayNX/Ml9aySzmblVQdZ
         +ToWq7YryqEAwVZWca7S9JCMAkzFPRpNSzUdjLMW8jcKJcGHkk+nm2QymiqiiXRori6s
         Ugwf9r1fTefOTvxiP5TuFnUZBwibAA6rCLYHUI23thtFnZPjEs1FwCRyhcbiwojIidnY
         rukg==
X-Forwarded-Encrypted: i=1; AFNElJ/F6Pa7g2ZNNUAf2UKao+hp5fThUNrT/+VNetEMyeZcZnrXljYl7WwWnspwpElr8Odzq41bGkOO9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv38Kb9KKjsCjrNGieVHLCeBWkey752BhNeWdGtPGU/gMvnPEQ
	EFZJztbj4tst5AeZJX36VxsGVw7yCLYurskSemxdBRtrT6lIfP8NY39DVAFTkWFphQ2ncne2l2K
	3/I5Hnd764mGL7vNIojDmccurZU+NCJRJ0HXgn3oIsDSf5r21LpsZi8Whrv6rGA==
X-Gm-Gg: Acq92OFU0Lcck5oDt+cr9IpMH4VzOJM3+UIJeOoP56hDwM+nF0O6Qhwc5HgCcOFMmUX
	6c/y9B/jVJeVjmdLxjgD1qXDOq84PGseyZTFM0/WS3m4dEohmLop2TY7vSd1RKMyR1f6iezfAkx
	ol2yeJbKjE7a9KSEltvh+PnhzkdKz2YR5O2GvSpqT3nx8DnROPDiHegdceogYsLslmIIxG3ffdh
	fXJqXWhGiBVyhPIEvb7+eH3XoRcQjf2Drv3A3zadROih1rLEG3lm4oPR1ZdwTSFDK1Y4Tfrp1YO
	dEAHmNeaXGHZp9jqDbhi9Wb5oWcfsdCWxvXWDiuLGiDzaUREMh2rFLQiYaVRoGHsYeImL6H5lJ1
	mMf9eY25qZqXqEZ0m4MzvrXfRaOeTDde5We7Dr4OuzsDYEzPn/P6RmYiZrNZ8QGIKqGREsMA=
X-Received: by 2002:a05:7301:608a:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-30119874a96mr2588026eec.20.1778690670438;
        Wed, 13 May 2026 09:44:30 -0700 (PDT)
X-Received: by 2002:a05:7301:608a:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-30119874a96mr2587973eec.20.1778690669842;
        Wed, 13 May 2026 09:44:29 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:29 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:21 -0700
Subject: [PATCH 3/5] hwmon: scmi-hwmon: Log number of sensors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-3-00b47b1be009@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690666; l=818;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=vAmyCpUIu9IUlplJc4rGmydGdjUb6w4tYNaPIxlBDiw=;
 b=aHNXRLWpAchmivoKZfcxADgDkm5hnjgWYXKl8nVGRM6MkaZazLd056E8o8GAQELBgC4mw8qtn
 4cXbX3/bAUJB7GVGGgv4IJUzsVLQmNc0vvFg694a4U9/07cs9TUFFk2
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: dVLFrEW9-_x2pcwHfKlpFB5JliZQO9wQ
X-Proofpoint-ORIG-GUID: dVLFrEW9-_x2pcwHfKlpFB5JliZQO9wQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfX6Yqh/iHJCAFQ
 b95/GAoaEftBBmWZ9Ena8b82S5qKVQoz6Dx2dP8vBxL2VdhrOewPPOkIIC7i3fzoWb4WhnmN7AX
 vWnVcdIkl+3eAQ/M2EEfRtZGkCQKnh+btKRn3n1KLd6FYQUIYM7nCOQ0Fkid6kaZ3B+GVsH79/M
 j6y8+6X6z9pD7alRnSZryxDMUXa8WBST3gSS+5Jm9mfR3hAeb/Om1qNDHM/GnfH4D5BtcrYzWFa
 7fLa48wHOFQDXvhfDhSFXhZgxKg1PODr8AOGUKpsCfmyUyFpJrWWAjqKm1LJcuiSufsWcj49y0Y
 kckBh2c7E8Zy8jYT6S7EOX0TtZpFGfMiD4CNxa3QXq0flpkdTKobgnU6Qs0v1B+wDbpRn2BUdOZ
 W0D3a77V0lN2Ek/K3k2NMvokyjzQDYwjaPIpIabZ445SfOzeEr8WRrN8Aj2EfAC6JYFC49px0ug
 LTluplGuiM46Em7ZK8w==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04aa6f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=U6dIrDiPZIM1rF_tHS4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130169

The SCMI hwmon driver does not currently report how many sensors were
discovered from firmware during probe. This makes it harder to confirm
the firmware exposed sensor resources during debugging.

Log the sensor count after a successful probe, aligning the driver with
the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/hwmon/scmi-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index eec223d174c0..6f1b0559d5c2 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -362,6 +362,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 		}
 	}
 
+	dev_info(dev, "Initialized %d sensors\n", nr_sensors);
 	return 0;
 }
 

-- 
2.43.0

