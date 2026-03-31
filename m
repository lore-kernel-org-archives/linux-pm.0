Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A743DA5F
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979014; cv=none; b=oaGB0Fq4NwUeuZQmqWLWAdOU+eT3qqPK0fudoMNbymoBczAoAKvk59YR0F3nKMsOo+SG8CpB5+i0HcKAKEIwMw2tiOtZBD2AH9JKW41iTHr171pLKFqcDcytvke40nFE5I4v7vPZB93MHNe92fqBtPdNTo+lxsbJBPaiDAWgKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979014; c=relaxed/simple;
	bh=BPAI10K70e+CF+7qyTbXS4a+PvSEqRYiYd9lP4ZeYLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvutpWWQf4YhyzeDSvqv7iMaeFkaK3iZTlHeld094faX7HBab3wM/AKsmVfHNbHrjAxDnLsro5XjM4AV7ITgahg7XQdQOcr/91qMaGoDMXhpaDrqOt43hhNRBrh34zF4jdtc/yt8+1cMb/QRJA7cPyHFMLp8xd6PA0Liv5AvyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6r5RCFw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6r5RCFw"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc795ca97so535598485a.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979005; x=1775583805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbKHKvhaSMoLy6eA0IPH3efMSPpQIB4QG87MfGtQ3zY=;
        b=c6r5RCFw+becEQmdyeDtY4HM/UIya/k/fTr9BAL5Y15NZIvcm1rlmsk1a2uQjMn1VU
         WIe/nrkvQzhpK6mdeI3qYlq8T3NejDb9YZID12258E7ggev1Rac5K4XKIZepGgJUyncv
         vfc2f1zdqR0U6Vv6JQa6ZsTXB0iwA9+ZLf+CsRdgCEmLyaB45UrHFI3kcQZmvKkX7Frt
         EUxKT7jPCoKlTl4wbStty1XUY5vmXFT4j9ZwJdinwk4y7HzNrTpsS9xsD0QlrCQaD2Jh
         A70uGAogasAhAjtLku/3NoQ7Rt6REEBAPtdJpN76+AA1ntLrjRQFklq+XZxFz1irFgO3
         Ku/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979005; x=1775583805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbKHKvhaSMoLy6eA0IPH3efMSPpQIB4QG87MfGtQ3zY=;
        b=Uhgz2ouLv099NHepWxYe5doLN45zPb+S79GHd1ufPptYQ2prooCB/g04WwCpPSkoEU
         HAQRmLGcTblMWAQGBY/eIiA+MzPAHkFawmI+SSUSeRWa7vpTZ6qEYTMVMn6pdT7+aRCh
         BiYSgsCWrXoS1LLYL/PMbnf/ORp2FzBYHoCTppYem5KqzxHvoCWUMQyr/Gv4C7vcWl1m
         oiU6Jy2M60nuj0SBelVgVX7G4M4FNEKR81Bev4ldofv9fsduylZtkNBcntT8AXBoUnHy
         vex7HonMiz+9MgG/mZMPxrWbKnM/7xnaWj+xw4fbaF2yLyqQV92ShxzbokKErCPOyH3x
         5IhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvNOnSb8wJm8dzXHoXyfx9NLCcpsA1ZGPjQ+a9zzLnZ9rohqnPVjStxQ0nRqFIR7EUwxl/Xl8LJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrI4q8UDZRosdqo4SRHF47eLL4PikS7YcBP2S1k7hkZ2STOc46
	nCVTqK6eCXiWnIhuSpGWPUkqPa/0QpU0RHq9ivemUfn35kyr2/tHxLH4+PqhIw==
X-Gm-Gg: ATEYQzxEu3bapE8It4kCtbNU08fD9MS6EUyJf6vTRU/Jg+cKSYBP/Jnbyz45XBKfTVL
	jTYCDpGYQgvQDKub6CP4BESazu2kJl4y6FHEiXY2tEyo5sQbeUxjR/U202lnpZfwC8HTTU4OTTW
	BINPRQ67gFodbiuAZXqyf8TAoYISROOQY8CGRB20cA1wQdmL1H/qkY4fFtSpCoO5zyHuhNMRypi
	Hizdjt1Ih1lORj5RH3itGjUHqNiu0SUpmivUPU8Vbeek7lzb4GXQUIFi0eFTbMqMyV0gc/4Pc8z
	yyQqmDcqYSMs52RvkLSw8D0aqHBe+R9WBu29dp9xYobvxWz3UgvPF1y55z+fJA14Aji/IVr1hrd
	hX8kzo83Q5xnyfQ2w+g5aXUzc9t9mfdwQsqlXRmknBLYTfFJO74nRXIp8wfxyKKA6YC2UTPg0jH
	oo8gqxItwyj9LFflPLfs5zPBYgluk=
X-Received: by 2002:a05:620a:7085:b0:8cf:e0fe:f20e with SMTP id af79cd13be357-8d1b5ae8497mr88040085a.15.1774979005294;
        Tue, 31 Mar 2026 10:43:25 -0700 (PDT)
Received: from localhost ([199.119.232.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d0280374cbsm947500885a.26.2026.03.31.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:43:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:44:08 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
Message-ID: <acwH6N56W_ULNe2q@rdacayan>
References: <20260330165237.101045-1-mailingradian@gmail.com>
 <20260330165237.101045-2-mailingradian@gmail.com>
 <ca6c13c2-4e46-483c-bc22-0ebb6db704fc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6c13c2-4e46-483c-bc22-0ebb6db704fc@oss.qualcomm.com>

On Tue, Mar 31, 2026 at 10:30:29AM +0200, Konrad Dybcio wrote:
> On 3/30/26 6:52 PM, Richard Acayan wrote:
> > The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> > some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> > the first 6 CPUs are in the little cluster and the next 2 are in the big
> > cluster. Define the clusters in the match data and define the different
> > cluster configuration for SDM670.
> > 
> > Currently, this tolerates linking to any CPU in a given cluster.
> > 
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> > ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> [...]
> > +	if (cpu_id < 0) {
> > +		dev_err(dev, "Wrong CPU id associated with LMh node\n");
> > +		return -EINVAL;
> > +	}
> 
> nit: try to use 'return dev_err_probe(dev, ret, "....") in the future

Does "in the future" apply to the inevitable next revision? This would
be the first occurrence of dev_err_probe in this driver and the error
path was just cut-and-paste.
