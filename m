Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C335836A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897031; cv=none; b=NziYZEWEoMA4CdhKzYAt6OnCwtxvgu7i2JyANvDMTQOZyR95EGLmwmkHnkc7/H8AxBxz/YUgMa1XEKT9R8GvjPB/qUSXvmrnx73rKw410DU31ZGAkB0IcadehRM+uaLLOvnGrQ/3kiaOtI6TGsIjg1fyH5sffgf0Js11MQU6mHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897031; c=relaxed/simple;
	bh=as6aUcNr8pYRXi+K5EHXNogQnWjAD2RD1NlxYEUoRSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8otCIYrgD+i0FdQYKb6Ih5APzQHH7cPIOtV0t45JqYXSJb0faAli8nNv+egJ8OhOKlwkWuYTMVOF2TF6zBNJ0tX4juKPV0YA7dnU6Fdq6D6LR6FmZB9CNoQJRsGWDh/KwmfZjaB4QCji8UGrXNnSHRqysuwNHF2Y/WG/ePOK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLeUaycy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLeUaycy"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c859a374903so1250110a12.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 22:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780897028; x=1781501828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6AIP1fKlQGekvl+Me5wDofffuQ5PdwnrPJErlJrKwU=;
        b=uLeUaycyHECRLtIvf7Vd7Dyh/ab7Aqz60ZGmTVaEBGYlBKWXkG0SsajccwDf6vuZNG
         q2O88SjC9Cr0+/fIuaepvmtNlfKM6Lgd76JPxKhEErQkkWZzULR/mKsKa/a0u96dmCsB
         qIOjHnhZ+PadyjrQBc08Hi/wT/4xy8nf39i/L9KPvey3b2zRvyomGzoL5C+BL/Aad2AV
         XCV43KbnFeiHGD4pxBpQGZM5RQpZH3s4+xHpxjwkHYf248ZnhA8YltckpYHnwv2o0PaV
         DJv6SJKQHKP70YiqbajqmFZ7kg3Z7dI0IJSuuc0GHAcaGPv14NvgR4gTWEJK8inBzTM1
         0srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780897028; x=1781501828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6AIP1fKlQGekvl+Me5wDofffuQ5PdwnrPJErlJrKwU=;
        b=GXQD7vzrsjvy9i3hSVIP74Q/sOu0CgMUDnI/z6JpMjybu9xseurKPeBDYThT5qgoPP
         6bjfTg9LTgCdTPzIIsVvorUjIG9SC85A5B48zKZYREnbz3T8yQ91f01FOV/+HmloJ5s7
         of5PnXm5977ezqmDX/KqiFRPpw6PBGIDI2bz3LNeZTUGLK4v89dotrgfiB03u3a9Ac/E
         0y5tsnw6k7Ab0Sjfo/sRfa5vqngdrGdbpPy/n7ziDoRnuFKNQSRQ38xDF1rr4x3aEchG
         3J3sLWe1UBKlJH28QqfPk7jHBwIIF3jhI2VdXkaLv9JaNjXfsujxXOOp0kIFB3qkYiPe
         NajA==
X-Forwarded-Encrypted: i=1; AFNElJ+e97K/HuK9aOgwUY06+2RbWSIOycHIPukuTiH5pwECD96i9qHSYK8oFbcDsF6E15ZW69Nl05encg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQpvGPTcBMZ5ZE9ikfCoGCAkLVLeY/SNAWWtWQIWp0H5cAe7u
	zrhyiAZK9jOSinuzOHJoOpsJ8zSJIq/fDeuk0YFOERkQhTXNhA1xV2obL2KoXzSdKFg=
X-Gm-Gg: Acq92OEVju4XA4KWPFWFJg3O23dB2Ot7ArSe8bRzRJMYolbss49buuCB34HaLIgggjr
	PFIgzBZY3wITn5e0pOeV84iPzNVVH6GIY4kYAgGCXC7uPNWJ0lOm8OallvIDyI1YM5Z7O5fgqcU
	rsFKdx7RFZWPAa7w4vm2rIU7KkAUpMXp6y01QYq/gJ7uyVoggZFMHVqdZKCQ+DLJAHV5SRAX0OU
	LKQbhxWD+6M/W1J7iTDq0MXcO6glkya2Csn6T+Sfg7s90otdj0pGXuPX7Enh3IA+7cVpb/MtMfs
	z1PdknJNjpYL5BZuTJSvRPd6NUfuSFx2Be9jIeDpjumKvFmfA1v8ZR56PWNfsgefu6AKqddRHCd
	uafmK822RWxTqGJ0K5lwAdinO+jmaDESVOe95jIgL6Dbmx0pIM+QnrjN+/2+L9otVkGg7zFB3xM
	Auo3Mb7Bp7WZDuXOQePzHwNy1yE4t0GvDSVw==
X-Received: by 2002:a17:903:388c:b0:2c2:27be:39a7 with SMTP id d9443c01a7336-2c227be3b18mr99546265ad.29.1780897028229;
        Sun, 07 Jun 2026 22:37:08 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm173360235ad.54.2026.06.07.22.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:37:07 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:07:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] Add cpufreq scaling support for Qualcomm Shikra
 SoC
Message-ID: <fvixbefu2yv3iyoivhgb7ty2fz2tod3rvpier7ymiuxugkeh2n@b3hrqngirn7y>
References: <20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com>

On 22-05-26, 20:46, Imran Shaik wrote:
> This series adds cpufreq scaling support on Qualcomm Shikra SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
> Changes in v4:
> - Drop CPUFREQ and use EPSS in bindings [Krzysztof]
> - Update bindings patch commit subject with correct subsystem prefix [Krzysztof]
> - Link to v3: https://lore.kernel.org/r/20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com

Applied. Thanks.

-- 
viresh
