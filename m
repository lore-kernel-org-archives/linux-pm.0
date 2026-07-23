Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20223369D5D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822608; cv=none; b=uD7tVyWZJa0kjS/6YRLaGsO/HPvIKee/AdLPMFP9WAD9AiZlBxKAh0VxyXvY/lq1UNtZwXzrtJWX6yJi/qHYRyJcZV0HE2O9+bhOHMv8cS6b8JBDd8Am4fAmwQf6gdeKNrKIyT43lqcXkUBhf5aD4NNPCbs+hZ8HPqQ2oJ9b3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822608; c=relaxed/simple;
	bh=VTnbRjkRfnE2uas3pcgZxwwolCVAb6XAOATCiHQXgO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZERhlmwBOWH0Dwz6I9drBaZDQ50Bt6AJ4JNSlA1VyvGonNPvrY83IcHDFsEckDkR2OHTCQoF7it5a43HijHWZaVCHYqspLOY2Ta4ivTWRl58AW8oU99W1nY5FN3TBdHaC0UrN4ewVsdPhFBffBHOgi8aDq+1EmLSrG/TfVe39BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/10HsOz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3xOrwBf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/10HsOz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3xOrwBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784822606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUjkJdrGHF/uTpDAifvyQqEKmF6q4j5F7jAbk0W/44I=;
	b=M/10HsOzCAxKw+rFt9bhpOrxOAQSf9wX94d8+4iFfprfvm6YwH79VgetnjKXh4j/OVsxeW
	mOwZq+PdEauPyR0rJ+24hFHdufd9z/lwW6+pV1xWtmWr109mjzfbsEe3j1UwSUS7SicndU
	x4o9h4qBiSnpURwkE+O96rXdZdyUbdk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-aVCngRtGOGihYoLcxYiERg-1; Thu, 23 Jul 2026 12:03:24 -0400
X-MC-Unique: aVCngRtGOGihYoLcxYiERg-1
X-Mimecast-MFC-AGG-ID: aVCngRtGOGihYoLcxYiERg_1784822604
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-904c1d588bbso13027796d6.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784822604; x=1785427404; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JUjkJdrGHF/uTpDAifvyQqEKmF6q4j5F7jAbk0W/44I=;
        b=G3xOrwBf+4zIzRwXkNPxKVZNrGC4lMkogycr+5KPsUITXoDc0wfLOQ2xS4uOv6k45s
         z03lHN3JmUIaVtksdQiWLt1jPMW9VaAdmBqZsE0GB1DEYqU5b8jUvMDXJmVgOeez6sis
         lEUl+mTd/bde6jZZtrS8Et4kndz0sPmHdLjo7KOGLCunxnPYnwHdKNUA0fx2INfnKCI5
         DgoGZx+qaRpEf5C1OGY9InRy+a8YEv8/iXK/Qh+uF/UnVzlYCKogXPzHPJaMjb5Q9usd
         B6aL4Lr1A+0ZKXmfBfQcPbYYt6OAOyobVszBaLtOoNEO/waIqh6A5T1gX1dIGoLk4G2h
         +nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822604; x=1785427404;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUjkJdrGHF/uTpDAifvyQqEKmF6q4j5F7jAbk0W/44I=;
        b=UsFv7a5xH9mUc5MpExTGixNgH2ALxSvmzEXUM29w1lk/5NtiLHvfqjT5DH3uyKufdY
         fxe1JL31kWaylZCI4Bz6dFcUf9GbfByuW4MCsi81Cwb0cfXMgjTYIQ25sWHO98mENqTG
         b1Od8/WTSld3QjmInr3r16DIRJ6ICUb7couVqYZKpbyWT1xhy+GOrtVrw5P8uteOcvrx
         +9jdxzMuBesaSCdlj3C3eU9Ok7WxuGuqFIiVNJhZD0NguMMjF0susUS8zhpB/K6dUg38
         E3JDqH6G7NxsrZqMoEPpVfVQ91S+Rn4V16IZEAlKTSStY+qnsOggiKxv0SvmqYQeX1K7
         1/Bg==
X-Forwarded-Encrypted: i=1; AHgh+Roft5tne9D03+xTeRiE+O1xw4VlgqE4WN7yW9hSQd+2GabB7c4EEEdIZzeC8s0ATWyMj1jX+nELdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygO6JTNnygCVlmmE0IA8Ura6DNAt6x3RqUrKV77Oo0jQ/wTtt3
	JYfg9uiV+gNmi30gEJxK1pjgCKcoD/DJ3GLJZbIgWdGY8hYG7F4/rR4m18UDTYm9DFD/eCcCFJ4
	TTy6jQY5XgPjYTPcygFk3qV2/k9G+asbY5VKDjcx9E+rH1cQRd5qY3FP/0tNh
X-Gm-Gg: AR+sD131kyJn4ZT8aI8MnLbm9+aGvtrLntBzA9DVzIHxAAJt+WStVwkXiWrB2nc7Hnl
	Bwvs7kumordA5O9c2wNnKdgBrq+d3wNKWqi8+K697XtNy4k/JfHR4+A0EUXew8cztCQgsSkdih8
	VTj3JoMec8cAiiBXxJ8CucRA6jMB3kFkGjUGUhbdLAt6iwEuhz0EnPFj2lDih89I3xM5sxhVzik
	F1OD+T7iLWvbPCRYW4slBQIZM1Nvkx+JQRZKLk5uJYuFVqWrc2fwn5ajHsLrnwvkuB9u7gBiRUI
	UVrX3ura7iJFQsIhaixHyK/ok59DhQkXykTvEFVHorm17nBFnH/a/QqAKc0v1cM8e2EWvqz/1SD
	ZZhjKOlXqk+G6BbyaN9GmYJzZksQkSr/njog=
X-Received: by 2002:a05:6214:4303:b0:8f1:77b7:9bdc with SMTP id 6a1803df08f44-907ccfa7755mr33588116d6.1.1784822603650;
        Thu, 23 Jul 2026 09:03:23 -0700 (PDT)
X-Received: by 2002:a05:6214:4303:b0:8f1:77b7:9bdc with SMTP id 6a1803df08f44-907ccfa7755mr33587566d6.1.1784822603140;
        Thu, 23 Jul 2026 09:03:23 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba672806sm48357536d6.0.2026.07.23.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:03:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:03:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Zhipeng.wang_1@oss.nxp.com
Cc: robh@kernel.org, saravanak@kernel.org, ulfh@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	jindong.yue@nxp.com, xuegang.liu@nxp.com,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/3] clk: imx: imx8qxp: add soft dependency on SCU
 power domain driver
Message-ID: <amI7SFD1bQjkj6Db@redhat.com>
References: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
 <20260723020524.1886806-4-Zhipeng.wang_1@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723020524.1886806-4-Zhipeng.wang_1@oss.nxp.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Thu, Jul 23, 2026 at 11:05:24AM +0900, Zhipeng.wang_1@oss.nxp.com wrote:
> From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> 
> The i.MX8QXP SCU clock driver manually attaches power domains to each
> clock device via of_genpd_add_device() in imx_clk_scu_attach_pd().
> If the SCU power domain provider has not probed yet, the attachment
> fails silently with a pr_warn() and the clock device is registered
> without a power domain.
> 
> When both drivers are built as modules, there is no implicit
> dependency to guarantee load order. Add MODULE_SOFTDEP("pre:
> scu_pd") so that modprobe loads the SCU power domain module
> before the clock module.
> 
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

Long term, it would be nice to fix the probe deferral issues via a
separate series.

