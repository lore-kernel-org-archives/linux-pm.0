Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FC20ADF8
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928712; cv=none; b=ed6YRlfC4ljr9dp9xYLa0xSrRh6+qNBp7oAEnMYG/2Iu+hTPlEqlOKXQs2fIcZpRgZm0tToXzGcslagTSQC4h26V3wDobfdwnD1/PAf4wRijdGlkaCClYCeX50hOo0iPRFwaWv9fwD4EZS7CCGw1+ZNPnwm9ur0DQEuqovYkJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928712; c=relaxed/simple;
	bh=TnzJti9awPEx8I4s1eEp9WCeD037s8OKdorXNslKnpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpt93Ve9AC5YFXxi9abwdsEEZihxZ2zAOp2AEE6qX6XeiT/gC8LiTqFoz6+4rbb/F5kr9fr3fhJjPYjKCmjrJ9JeF4HcPZS1Go32IvMmrSJlVB4IvSlqrGP2uol3+2HzQWGoaJL7qJtfTzcBbT6Wivr22+IgVqBLKNwrt5riHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZX0lb8o; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZX0lb8o"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb63dbd229so2092081a34.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783928710; x=1784533510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JI9qKqUbDyY96qS77YO4lTn2EQ0dVAMQRTsX5tyDiBI=;
        b=bZX0lb8ovsq/uHFt0lTz8wwtjQSB/COni4267vcm8RfEUqMUPxTe9azI7q0wOgk838
         W8idVqKQ3i+8CFkamQqC/1baQ8eftDcQlLqtk2n9MqL/SGlRkjPvEf6vFWiW6GtoHM3g
         iKp0rxH3GlW1LFrrLx+83cki3wf5arvdzOjPeu58qH8FuEDgR3Rt3rU0Al1PsUGoXms4
         f/EqR/muou6cCT+MoEdno90/vlZ1WJWXXE30cqwXIFsVtMJDzTyp5u8Dj2xVTxXGeed4
         V5aNlpkCJ54uhyIgjsMPL6Eat9Av+4YY2tCNiZFpP57az8LwW8Fg+O2DTen0uzJCE3qJ
         8ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928710; x=1784533510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JI9qKqUbDyY96qS77YO4lTn2EQ0dVAMQRTsX5tyDiBI=;
        b=UMJKANr6pEWdgjczxK1LI62VXw9i0C/6Jr43RfLVlL8D+9sCKgbLhTndEkdbNS6yTl
         4KghsNqyZwGGg4tuEDQzJpNEalbQIjm+YDsyOKVpRaF7B5TtYJ6GVwQKwIShHCyP19qm
         AjA0tx7CsRS+UNk4so6JaOrD8elXu/dqSJ8hiuEr4uW7PcvcykCr/+AhLPQ8k5HHiCaI
         v/CpQrj8zrsgmOGBovhgm8uWWCCZRaBoz/Qo66aNT/cPVtJvS1BI3gSs6oM4kym2nP+X
         5cSKsEVX/UrG8o5QV1gsU0XLqNs8Ysk0TiB9E/iFpvSxvfjUprXWFZ67y7cKNXUWjzuj
         yEag==
X-Forwarded-Encrypted: i=1; AFNElJ9chSlP6irDYiVrHTS99HNSC9O2YPxH5AG5E0odgeRWxxH3zC3JYX+d4NTB45S5L3GzMy6kB7xpVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbxj/Wp7hlaWQG3eUiL0Fmso3MofXOWoZ3mAo1z6FIWGQyWiE9
	JNEdEPBSmGK2iegtw7iqhM1dQtq48T8UveOywuBXvjSPHdVxDAoej0lenU2GppQ/MlI=
X-Gm-Gg: AfdE7ckHF1m1ZshLd35Xaqk79BsKKVOFhjB179qS791oHJ+FMh6fWuOaSgO6RZPgZvq
	ijNIZcg+QN3Q+GCE0VSrHYn9PtdSEK+p+Kho67jlJ/qASdWV6d/gvTLxOah9+UwfuIbf5kukrTc
	yA5R/Wr90oWHzehviZJH64HaAkI1DW4EJeQ7fQsfVSakYDpluKNhroulbpiCk66PqB6aVTnDRyY
	4VJ/33VPV1A7nQjt1Zw/t6tdFnxqabLCECFlsOzuNLFMWE4PyZaCYOYgmSD8V0+UD5IZO99cqr3
	Ar+X6lYBKvTXVqxtURUNlDuiBfaORv4+7/YMM87wOg3ObL7lkw9q1l76NTM4yO5tX82EkKNhq/g
	5NZM5EKrXjRJ2t4SEq0J1wvwBhn1XIiKZG1JKPHpma8bu587YM8jUErzcOiXX47Xjwc1qMVOYn6
	bVYSQ6
X-Received: by 2002:a05:6820:f027:b0:6a3:778d:fd3b with SMTP id 006d021491bc7-6a38ba55a41mr6316745eaf.41.1783928709744;
        Mon, 13 Jul 2026 00:45:09 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455b767413dsm3021268fac.3.2026.07.13.00.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:45:08 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:45:03 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Deepak Sikri <deepak.sikri@st.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix an IS_ERR() vs NULL bug in
 spear1340_set_cpu_rate()
Message-ID: <alSXf7y6EzNf9uUY@stanley.mountain>
References: <alFJNUllC3JOKv6z@stanley.mountain>
 <c0800c49-3435-4e89-87b2-21dfa20ae58b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0800c49-3435-4e89-87b2-21dfa20ae58b@oss.qualcomm.com>

On Sun, Jul 12, 2026 at 09:30:16PM +0800, Zhongqiu Han wrote:
> On 7/11/2026 3:34 AM, Dan Carpenter wrote:
> > The clk_get_parent() function doesn't return error pointers, it returns
> > NULL on error.  Update the error checking to match.
> > 
> > Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Nice catch, thanks for the fix.
> 
> Nit: the subject is too generic and can be misread as a cpufreq core
> fix. It is better to scope it to the driver, e.g. "cpufreq: spear: ...".
> 

Oops.  Sorry.

regards,
dan carpenter

