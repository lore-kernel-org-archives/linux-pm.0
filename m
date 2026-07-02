Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC092E2286
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782968666; cv=none; b=XICT6pBqgme/jD8DPVdN40GQgxGWVq+97SPxjIWtm1ndZ+mF06axriXXTCWJRqcyAnyt2rQmIuLiUGyx4r+5sHKlUhayddegBlDZqRpmJYzXmXtinEEDzde17sP5MDotJDjD18wxoiqgGGvbT7kaq2SKX8Qezi5sTBXWWiYgf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782968666; c=relaxed/simple;
	bh=KY8isj8qnfFeVbnhDgajn0TKgbt63r5onHjMkJEDVBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2/CxmoNLrSDyCaQs9gCq3KmBXSL1ekBkk6HOHR1nRQdt+65qoVz8KHd/3tyLKY+wIjfEkkolGd32VDJIPTL6ygLM7L5cdZx7DTgY0UAmiAI5gL8doJMHQfEnvBxW+mSa1F3FIvct9Jw88YnT2bgsZC48XhUn5tTkF7Y0X7APxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snWr05SU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snWr05SU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37febcda057so607030a91.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 22:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782968664; x=1783573464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Oy0cfahmYAXjNqu8zns/MhJDGK3lg7nw8uo1AFuaGQ=;
        b=snWr05SUa29AgH5E2w3tvi2Q0PLnBP04IEEhVsVBUrbGf3cBT84L0lQXqzBu+g+BI9
         LNxJVjsnrz/fpi3dg3X2twVaZyxrkkA17a+8BicPLJ7yfG8rg9RFTyY9Achz+Z5KtJ5m
         mDLXB/YrRlkTYo0DsoEbLGDB5MM17s80Hs/JxGDJ3D4i5Lv4HBBPzL3jS8KFPcD635n/
         UJXriLSDYTwDwQz9h3pu7tIaPTvmjbOJI6BBGS3Upo84oi21H771GYbYrBimXG2gejvE
         MBoZBTVIFkNb628aPEwmbQZmo2gD09oz4qov+6YEQyHzOFTEFi8c4KO0/g4MbBKArkcp
         PUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782968664; x=1783573464;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Oy0cfahmYAXjNqu8zns/MhJDGK3lg7nw8uo1AFuaGQ=;
        b=AficsUsjo0zcHsfvghTJed7KTGfOwGWPrFhF8tCo6fpyvp3JRoqA5mnqR4TNuWkZMD
         BQKOx/Eu2xP4nEok9IlAsOyN/+kjgp40shocuvCio6NM/QrkMU/dXqvRwls01DS8DBDU
         5ftSKr4VePtd6I9Y8KBETs9oS6G1GNP8l1sSNPJe37nHcfnQFZBFiHgbYYYXhnr/yCdP
         Cj0iOtZuvB8uka1Cc/Obe5E+W2xkO2tjq8YzPbGlIz6VgR99Dpr5/WZohaDBSy4Cgyk4
         ZnrfT7kpa89Lhfzf9StltzmPWr7ltYase0LabHZgZgQe0bX4ldYbjZDWdqTcMV7hxiCg
         NoLw==
X-Forwarded-Encrypted: i=1; AHgh+RpJ8dI0ocEL2OgmnSQmWgVcFIs3KM6daiWHDpkE/5yZLy/nzmBqnWe8VtPPmtHmUmDWQ5HwGr+/lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkdrRUd3csGJh52qO4Z0R/VDNA9JlRu0fU7CrDr+BtVVHQfJm
	zPpumFs4uEWlD5P9GbXMCKKDo4ba/WNj5RltIc3+TY5HNHWcpFVPTDkx67OV2/Hi25s=
X-Gm-Gg: AfdE7clanUHmsDoQk8CsMtfldVo4qam9rfJAyBYiy+IsnuU+1CGCKXrBsY9KYtSDDJ2
	+auvMYp4zqCmthDDMBnykIR4DY9b1t8e2LnNoTlenwMnETFNlysMjQHXqnMkyhTi2Lvt9TMV6Tr
	Uy8XY5NG2J6L/eaCNt7HyLEzRBu9IUfk5CnVMt7GW2Y9qee5NyuSLH4ZlA+HZUiHisdsCO4/i0H
	lla8F7MxED1zfGad2qJJDGUaGR6YW+2TbZVZHRar0WzYLMFDSQy4cgHRldEyvz/p0bkBP3uCrT+
	dfOi3oqtMrqup8/zkC15fqHsGSD2rAD/vjiPSw/VDiO2xIejXug8uCqkpojBdjOp+iRj+Xp/9xI
	xTycZbzglTUuAJ1glzRmeLpe21NBM2c35ag4n3RBMAnKZjXqQdEL20ZfQcb51x07xvT+Xp6Nsrm
	WRzybCoEFrKNtbgMBR2/PAyMI=
X-Received: by 2002:a17:90a:e7cd:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-380ba70e00cmr3476721a91.0.1782968663686;
        Wed, 01 Jul 2026 22:04:23 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84366sm6143858eec.16.2026.07.01.22.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:04:22 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:34:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ilia Lin <ilia.lin@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-nvmem: Add IPQ5210 support
Message-ID: <k5lgi2x5y3li2cwqdcznfgupd3fhbvrcgepf56ukahlrexyofc@moqiz6k7x24r>
References: <20260701-cpufreq-v1-0-98656ad20ff3@oss.qualcomm.com>
 <20260701-cpufreq-v1-2-98656ad20ff3@oss.qualcomm.com>
 <09de0dd0-343a-40bf-a8ce-f28c3624e6eb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09de0dd0-343a-40bf-a8ce-f28c3624e6eb@oss.qualcomm.com>

On 01-07-26, 11:36, Konrad Dybcio wrote:
> nit: checking for == is easier to read
> 
> anyway
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied 2/2 with this:

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index b2aeda7c564a..efa766e98d86 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -205,7 +205,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
        case QCOM_ID_QCF2200:
        case QCOM_ID_QCF3200:
        case QCOM_ID_QCF3210:
-               drv->versions = (*speedbin != 0xcd) ? BIT(0) : BIT(1);
+               drv->versions = (*speedbin == 0xcd) ? BIT(1) : BIT(0);
                break;
        case QCOM_ID_IPQ5424:
        case QCOM_ID_IPQ5404:


-- 
viresh
