Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90C376BCC
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853555; cv=pass; b=VnV5J49P+NBGI+gCZQUVUL76O5xat3BGLGL743JVhRnYXpGFw1LmHV3Hh6ekAne6P3eP1sUJIkBr87dDBOcB56QKOIY0FqiWxCpPC/au7rbnrW6XIBZlNcfoGAanUFrTDkrurqiJ3G0eRgSMa1XgN8eAlv8EagKyV290+X48hq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853555; c=relaxed/simple;
	bh=YooqRyA/DUQm5e1Bubx+ZKBrDAyHYH6gU8LhytOsrLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pupmTIkhD2Vnmi8vXI3UKyNHVnqbruxJsKx6JFc69UZm0fRRWIRP3iCwmhX8zSnCj6Zv72um7sqVQF7YT/CqAwPIXRrpTPuX8Y24WiVodit6PMEuBtwlesupDRbpw6pg/O44bJaIkQ0PT/pvwUydcEMoRUb5A0/pU15cbpmJOeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9faGqZ4; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9faGqZ4"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso5566439e87.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 03:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776853551; cv=none;
        d=google.com; s=arc-20240605;
        b=aqH+lumDn59zvmSDU3zwDj5MC8w2Y4z6y1mqNG2+pXJ/GWDBImhGtDYclXmcasCfXV
         oI4H47YSBO86s0TM0a/KhnUC2QJdGaVY2GKg4I29y2HV72FBhlsOSfeW8eZ5gLhmsWIc
         ZldDyg2Ryo32iEfW9lOTFvSjn0Tjs6/4vRXCLY0ASOXBfN+nqBUCIKsGhp+F2DUzdqTQ
         5pwoOgWUFRuqjotYW+c9T/71HTucHg7+3kRn4Q+fKRqkZdfXyymsi7rZabTq6Z7E+VRw
         0cPJ6JLMpIiaE6GBWazPWCRFQ3B7Qs92rh0shYBg7l01Z9Q5/w3q+eZXHBBhwC/Nhaa/
         cUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wq8+U2WZxewGPTZ86+kP7pb8whJIc4RPuZ9dCPJUDAo=;
        fh=2A9nozOWgmBmIR9kJYBb9sRyWcoCm5QDYceVA2B3i30=;
        b=Q4L57vSwhU8aMKqfeASQuiZtHUw2rqtR4nZZg47/2HDBT/76on2VkVApCkWJVzw2C6
         llFT1bbHk5HS781IWNLOylNM+ih2wnWVqAVd3rnRoDx8ZFFiqnQa2RWUQFzIsMHL/6Zo
         PNcQyNlhMbZvBspNdB78OibGKIBI2m0OiEzl7P1QCRQZ2x+UJMFD7bZtEF6CEd/s8Odr
         oEwma82WBF/C07D5g+WUeFlVUNt0N5s7dwzAPcrrX6xO4KPZiQgJoHZGXiyqSAFDsCaY
         d1SluZteVaICCGIRI0h8LojVmyCoeLQk8xT1axJg8t+6E8/fqwcSow8n4brfGzPxG3fC
         kskA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853551; x=1777458351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq8+U2WZxewGPTZ86+kP7pb8whJIc4RPuZ9dCPJUDAo=;
        b=m9faGqZ4PSfRm3Rnz1Sqa5IyvHP9xsw9M6T5OYo4af1I7rVNbAdyOr7OpOxQwzblao
         ik0E2Tn+NX2fAb0XQqKFEr6/pROqKEGjbhg+ei3TArkuOzTB5x2zucxlOoN6DbKO0n6C
         e1OaFlKAe3M4ER4A7+WVfSZR0mVs1SSneq3qJFj47ghNkueMcMPSnZIQ04xiF4N/cg6o
         K3hyKM8h/tGLk+Kw0WEtmlxoijE/oQHKEgovwyjQdMfQx+myBW1BHqW/rUtQKcS3ImAt
         SOp2kzV9VUTj7kDlkYPfUnCuY9vKtDsA8pPOsjqlU+iK6kShJFjiruVJ3hqMOJPAN3No
         T59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853551; x=1777458351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq8+U2WZxewGPTZ86+kP7pb8whJIc4RPuZ9dCPJUDAo=;
        b=jBY9oh6Uw/3pbZ8Zwy4Aq1ShVzzlBeEoWYtJPSnAoPDB/8Ha6bBf4JrYoxw5ESrQ59
         uGHJLuHDX/JLNX7s+4aYuldhLSIfmi30vYz4ljetPSn1eLL8gIdYCGPK70xjrYJbJLbq
         qK+U5AGfkKLWZCblR5kBjaaMatxwFbo7kEibzGJS59hXUBFzkhr9On1NO3SfiakKFNCM
         lYfuZKjC8z5354BoSxDHK3SD9MKfeC/dSbnII6oIU8ArALFzhv6W1oPV1dxqTf64DVAg
         nTPh1CNd6YqkyDEkorfMhjIIuDVlhXWhfYO5WjcC2TbtyakhqU5m30E0eOK6/WwEryh4
         lUog==
X-Forwarded-Encrypted: i=1; AFNElJ9yR39slNU9ILM/+7H2QZ8mD2XOJO4Ng2DvJKoixBs16/B0IW6J9Y2Cd/HeRyE83oEdB4TV5PeKlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEtR0bxNx0UA3J3SBzJNQI6m712hijlAX2zVV6Z4aph2ngXYM
	S+78G5CItZZXVxhUyOn1go+jeZQ4UL5kdhs91L+EkeG/MFfLhlnCnalm1SIPAWuhlcbreQFyI36
	Y+v+x3J8SqrZ89xmfTENfkEROGMmcSFTz5wuSQ9Hwlg==
X-Gm-Gg: AeBDietujYu1iPBtXkka7WUwrVwxBUtHVS6Nfze/nWL1LdlsOAmv9PQQaZ0Qk0UdWb7
	yNMo+8Hy04pasQulsiA+pI5b4sxViGbBWVzi/5777C/mrn+hfCydtxv42S3M9k03YEx4GQm7T8U
	+k7w2RMKyoeAXh2IgBa4HhxnBoZEFSKYPw3IAEkJHL/2l3ei5x/qiWMx6H9Q+SPWV6jNxAhh+Oc
	kUZ0oWRzes7bVt3/oWJ7QDET6yOe53nOSAgj+qkevnS6QpHJA+OyqC8E3uVL3zbcwokTr/WDAdU
	xo5mboA0+hIM0/Q1TGo=
X-Received: by 2002:a05:6512:1094:b0:5a3:ff6c:9df1 with SMTP id
 2adb3069b0e04-5a4172e7f69mr7060238e87.39.1776853551219; Wed, 22 Apr 2026
 03:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-3-ulf.hansson@linaro.org> <DHW8QV8K3CM1.307C6PW2BM5RN@kernel.org>
In-Reply-To: <DHW8QV8K3CM1.307C6PW2BM5RN@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Apr 2026 12:25:15 +0200
X-Gm-Features: AQROBzCHhHSXfjVj8apklmTonwOpiVF9jPJJQpHw-yRBihJtcF-VZQ649rGH3jg
Message-ID: <CAPDyKFpeSv+fg=YKJE_qc=Q5BfiJFn0tR7Ar8SncqrD0UW1P1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] driver core: Add dev_set_drv_queue_sync_state()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Apr 2026 at 13:24, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index e65d564f01cd..f812e70bdf22 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -994,6 +994,18 @@ static inline int dev_set_drv_sync_state(struct device *dev,
> >       return 0;
> >  }
> >
> > +static inline int dev_set_drv_queue_sync_state(struct device *dev,
> > +                                            void (*fn)(struct device *dev))
>
> As this is a public function, please add some documentation.

Most of the static inline functions in device.h lacks documentation.
Are you suggesting that we should move towards documenting all of
them?

In this case, dev_set_drv_sync_state() also lacks documentation and to
me, it doesn't make sense to add documentation only for
dev_set_drv_queue_sync_state(). Do you want me to add it for both?

[...]

Kind regards
Uffe
