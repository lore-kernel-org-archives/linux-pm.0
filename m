Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689244;
	b=vTFIHpmkSQ0vWDHQ2BcbXXHaYAVBOTQCpb/tn9fKwoOxAB4YMubmYJrz/aVDcdZziho5
	 W8VKCe2RFAvbqChypGGY43/1iHU0Fbjp8LON585Dbe9eHOHd3+BJomxTjpLnvcdXmM6zn
	 uh9YDOmieCSCH/i+BDdwlekhIdtEAb2hoIz/t2dHKnqUFCSqylE8QzbzIePblH4qapp6I
	 M2XtEbpFUyiherghxFIL2YbClxb5T6EB2IjRDhQlz7faRartwxSJqbyNMsmnaAs5rcuCv
	 Nr+9bv2pOO5m7WWjn7+u0HbWuUcBnX+rjzZBCOsL9zFHBO+2nEP8Qh0SxPSaDN1fzdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QUY9+Y2VxoEdHCsHD5R8MfHCWDCl4kBtw61OaYnUOhg=;
	b=QjJGaZIW6d/FxENge9x/ZxRhXzqBIul1F/JcRSC+kwxBfcEBQ+bEeRVgPki0ut8p+7jW
	 5TG46WiC64IYKsvBsZSG5Ka2JlvK55CaBibWXAEB+m/hxZWM70q8sWuBcTA0sWJgCwL9x
	 MXHKFkvHs0NJkbLkvpWBGuATrz55DfOaUqjfxKimiUDkVDjxWEZUJ+1/csZGrjHG48V8M
	 cWS4K3yzoIgLh7jdorc7SOF45lSIwJsgmea514vVzCa66A2KUR9RxbUIJvF1xfQOgqJ4j
	 fnufLhZDoiLVjfAl87sxzamPHFqG747FJJ39iJAeX0IwjSyxYIcwi5qnDJd9VnHIh6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F5Dm8yJq;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD26606A31C
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 10:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F5Dm8yJq
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so2233278eec.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795689244; x=1796294044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QUY9+Y2VxoEdHCsHD5R8MfHCWDCl4kBtw61OaYnUOhg=;
        b=F5Dm8yJqZJ/eIFY4KXNhFuQ/PKsgI8ojbyn4Qk/Mv4AzNggmrVvBIXclzBnaw0Ihf3
         TAqc4T9s57gJ7Lq9gix1mZwarusULJYDrwY9qHV0IQhC6ZxMrrPZ0rCKn5ENv7LAIbUk
         Qd94p7yYd/mLJOckfK+3i/vF/51N/1jaVo5XPtSFXmoW/AfxALbT6BzDP7CbsZk+Mdii
         s9Alx9xyBDo8JoWEUTRl+c7vn48WMLXwuOWQH2lrvec3sDhIsL4poAdHPhkEfNY1Fm/G
         Oo3G4H7+tu2Xl5TJzpdBCNcKTBDXxFhHYwOTYsJO9HM0r+7+vNkQngffTDm8PHyhojAe
         EPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689244; x=1796294044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUY9+Y2VxoEdHCsHD5R8MfHCWDCl4kBtw61OaYnUOhg=;
        b=KHfMicVzBHwXm+zeCTi+o2+qaDHj2+25OEAXpYcMVrv/sSMaHOPqWzvohfO/moHFL3
         HcKZ/VNO4wo4HM/9L5ihZzO1GJMtB/B9qiVwU0RdgYKs0hc5GwklYYvfetej9htDZ2aN
         QBH4Zujkaw1oj815OEaReI7EJ70y5kPxaXuG7II4zRtuQ/duG78Xrv03pa+69NuY8vlu
         QjIxAd/3+7ids6wc4UroKwimP0c2vPXng6lcHZIhSCQO+BP/UvpF18CzxvOePVZWs0N5
         GcSYubi0WOqlQN7r+GelldKqd/AX2qM04Sg7tqwftUbKdPh09Bb4YvbLZvyn1VdIIYwf
         xfdA==
X-Forwarded-Encrypted: i=1; AL+hErH/UY7/rn5lhDW+AAeGlD+V1sY9p7TeIeJt6tVFw0CdIP6RTBxdyKlNwZJ4lu6eNWjzA3nvHPtC7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UJ4Aw2dTNYcyQslDpINb+EOV6rVxnXO+Dcqq6i+L1KrNRos89
	l9JEjv1pp8K82404kUmMrgn+kf5vEWvfD6KhTvj/4itzvXBS6OkmGadmIDU8iPKdN68=
X-Gm-Gg: AZFdTZdHNfxFbdSbqVKKTctb/M0TX29ABwSdiECzivqY4wpMuqKfbFkTyOJSPZKYZ1M
	VN2DumXUUhXPYl2VUwMddBREn/P407MG+g4TQGaHTyGXtim4ba3nx5nAgZdqKe/hSo9XrOltHYG
	VkSeoaCaZ+VzqNcD8bJsX4dB3JHbeIvK5uzi2aD60d38LcnaNmwIucaOVLHoYSl15T7eDxHD8IO
	DyMC12TbDfTJmQC8tiFXPY6u6h5UNpc4bOUSFR6YKIO+axXoKbC2H203vrDNsgfdqNfI969RMh1
	yQO4WvBzo7c7tDMsQa+o7N9E8D8QPJGPmgdYTD3oNR80FAZLksGtYZ65TMlvriykDZwZeH6Kw/q
	4kNeqLz/0HS4YPgLuuDLNc+4dRA9CnwCYU+X/T5UkImVXvdXKBakF5rprIWyktybJHbRo5dQE5R
	BhcnD2K0sMFs/gVw0U1rrl7WQlBliJoNPWFOR+OTRleB/FNBbAy7VEa8JdrvpOf0ez0AxdAvsoJ
	NWAZy+Ck+ypNRWzZwSi8CAKh9jg07vp2275Wlp5yxcG+18pAq+fogvIGep8LaCUzdI8/esyoFCk
	4FYlR2tPBy76vwJGTMQB+koEWwUgcQ==
X-Received: by 2002:a05:7301:dc3:b0:386:ce5a:41aa with SMTP id 5a478bee46e88-386ce5a47f9mr4653486eec.13.1795689243454;
        Thu, 26 Nov 2026 02:34:03 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm76487652eec.11.2026.11.26.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:34:02 -0800 (PST)
Date: Thu, 26 Nov 2026 16:04:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	christian.koever-draxl@student.uibk.ac.at,
	neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com,
	khilman@baylibre.com, rafael@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Christian Stefan =?iso-8859-1?Q?K=F6v=E9r-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
Message-ID: <awgLGFpH73_fcnbC@vireshk-B250M-D3H>
References: <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
 <9556e959-daf3-4c85-8794-9613e7e7a9ae@gmail.com>
 <A45EC676-5B14-4932-A4CF-87ED3B71108D@gmail.com>
 <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
 <CAFBinCBkJJeRPKLFBA9KYjwXMxFjow_NOtvFoKRQdxD=rOPW3w@mail.gmail.com>
 <48b333a3-ef88-4739-a087-3ed9d8ec60a4@amlogic.com>
 <CAFBinCCgmRmk--W53wqdJhF-SzJbai--s7wyzDNt3LpfN00spw@mail.gmail.com>
 <b606819a-661e-4488-b5fb-9e786de463c6@amlogic.com>
 <awe_Wur5fVbeqV2d@vireshk-B250M-D3H>
 <1dbf65eb-fd04-41a3-876b-e2941cc10172@amlogic.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbf65eb-fd04-41a3-876b-e2941cc10172@amlogic.com>

On 26-11-26, 17:49, Chuan Liu wrote:
> Yes, as shown in this patch [1], I forced the above two
> "assert_single_clk()" to "assert_clk_index()" and it worked.

Maybe this is the right thing to do:

Functions using assert_single_clk(fixed-index-0), can be converted to
assert_clk_index(fixed-index-0). Lets make this change in the OPP core (in a
separate patch).

-- 
viresh
