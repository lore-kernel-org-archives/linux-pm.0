Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFE390237
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263390; cv=none; b=L4f8Rb4RLNBMrEr9pYwuQM/2goMxygSFvol7jqg9d7A/hIzBTpv9PpRhStVDig8phi0koVcymjpxy0uysJHUm08EIrKJRqLh6Ag0DJHCg78wCUEFgDGY5+Z4yF9wKzwbpEqLh1Ft+WybcbLLtsVwNRwYO9zXL6Y2DcRgRkPDIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263390; c=relaxed/simple;
	bh=3ND2U9WUVzc8Lv0ev2KT23OqMrD2HAyt6A+/DGBkYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnu/foEB+DuCG0O9BjsKgdM1nupmus+a4Ca/3x5fmCuZ3l9s0lQAWMEP25LPgBPy5aEoDAKgzFmQXUUpaqs2OmUOJm1xUmWOLfczTkmjDTmYCV8d6D6oVj3fJLiJRed9SwdMAzohjXznuIHnPJpkAHIGdAovfxAMmbadN1fgAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hadzqw3/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mtKwJ8zC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hadzqw3/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mtKwJ8zC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774263388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8PnNxrF6RAnd6AXtVYuBoGbmL+cIw2K+KfBdA2DfjA=;
	b=hadzqw3/jjkxgnsb4TvN5BvIIsa7DIv4aNA/NS72r+FbBux1Tu87qFKppTAlqQVBh1yBtn
	kglmFG2SaoaalSFL3WDTVnbj+3fxoEHVBbR2284JOosFURavC/8RsiY3BfCx6CzYW36yhL
	oaeNoduIFfdTekccRbLiiauZ6KpeQvs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-WA0ZgORZMHmBBH5SKmZ1wg-1; Mon, 23 Mar 2026 06:56:27 -0400
X-MC-Unique: WA0ZgORZMHmBBH5SKmZ1wg-1
X-Mimecast-MFC-AGG-ID: WA0ZgORZMHmBBH5SKmZ1wg_1774263387
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093787e2fdso81147881cf.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774263387; x=1774868187; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8PnNxrF6RAnd6AXtVYuBoGbmL+cIw2K+KfBdA2DfjA=;
        b=mtKwJ8zCpj6Mx2dubt0peLG5F57NPvb5+gljLYqVVMi3/1Uy6irt7+j+uQLQcMxyts
         MZ42FU+TeRVJ1B4SF+nF2Itsg8DzL/eLhkjztZ1lA0EGBylHhTrva6WsN82RTAAEIweW
         nrC0BA9bcVUbojAObDBpDjAXpqbdXn7HUSSG+EGdKG4msoyrE+Eq9sMToyA623ReUkdK
         FQSPqRgnzhBcBqskNjrZelch1B6cK6HI0SR/gZGlfoi7KdI+rExLxqhbZsPKCLELBHSu
         rmWRUF2i1i2D0skfg+bD/A7d82O9unkqs8VCAOjXbh+q/X24CVmbUBQtmKsggfem4OFe
         56jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263387; x=1774868187;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8PnNxrF6RAnd6AXtVYuBoGbmL+cIw2K+KfBdA2DfjA=;
        b=MetmP6iL+g5NNhTNlDSM9mUGoDRRKidzcMgdFnrc0Z9H9oxvdCoXYZQ4ZZUStrDuoG
         to8qUu7MA51qX4ekCKwTx/Hj+j6CXaUPcvHC8sC2YTyQTGAGKlGok7WuCiUTi1NpGJ//
         pbikGebt+AUX42i/xACvmzzvOAuc+L9lNwcXwU3QULvV8MEn/h4/NPDy2wOY1eZi0e5+
         96VG+nbSn5pCNbObSppPthLrp+CRihh2kx51VeyN3U23jEwEK6Csds03bBVIHbbBnLRR
         AfikU8SGUdRMUUASKo12mCijKmNnpoq22FvBUvYIrXXYdRteZoZYncCEgAaNY1J9Yu+s
         dycw==
X-Forwarded-Encrypted: i=1; AJvYcCX7PwWl2fAFVSFM8Kt6YeQ64dt/82Qk53JF2wQDMvwpDJwHZ23ATskLRaO6gsNTUw4bwc1wY68WdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFex986I/sp/PhBHaF7OEmy13MfOt7JSl/Z9qeGGM9w/VXUx1
	x2Ia81IQVBeNvxIzj9F396g0wbkhsXu473zufrmLXmIWRUcSUkWau7m/++hpDZjDgR6+vmoYyw2
	C74iJvFgIAr61rlXu4NdU1SYowQK7nI/OufP4F8m0hHveVjmjdTvSnahmv+6G
X-Gm-Gg: ATEYQzyU2Y68rXRixWBusiu2swcQKw/clX44V7AOLhD7TZIGTW9cJqHe0ipbf+FDa/6
	8WbH29c1TbQUvZWyoWQOw8s9aIjeE9gwkZ6GMyWbpZZce6Uj0XNnDvFNd1VNc2xU11qXdVEYNot
	A1tMpxyrBqeUxYDkVWgmecSO8SCy0y+8K6fxWFQpahivLFvxGfahVdsBAVvlCQX+FrosRnundo8
	TnM6/K/r1yzvHVlhxcoP2TRRJHpQPX42hE3bnHzY791TM6nb3Aa7iBTjks8BlPumnQikbXtXR37
	QeVDvBuPUmtGnUwFdC4JX9z/BvzD2tSUZc+moTUL/tRhvzld1sZPpEkLWXpxBaVzeNwE/X3FuLh
	ZZVa1N81va+P3casfX8o9SN9DXQsBSoorJLqJ8TxWZLx5DkcNe5uuPOBv
X-Received: by 2002:a05:622a:1e8b:b0:50b:2d93:97bd with SMTP id d75a77b69052e-50b374268bdmr206504751cf.24.1774263386454;
        Mon, 23 Mar 2026 03:56:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1e8b:b0:50b:2d93:97bd with SMTP id d75a77b69052e-50b374268bdmr206504631cf.24.1774263386125;
        Mon, 23 Mar 2026 03:56:26 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e350b6sm83525921cf.14.2026.03.23.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:56:25 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:56:23 -0400
From: Brian Masney <bmasney@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Masney <masneyb@onstation.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] interconnect: qcom: let platforms declare their
 bugginess
Message-ID: <acEcV9wwfx0UjOQa@redhat.com>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-6-7892b8d5f2ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-msm8974-icc-v1-6-7892b8d5f2ea@oss.qualcomm.com>
User-Agent: Mutt/2.3.0 (2026-01-25)

On Mon, Mar 23, 2026 at 03:17:22AM +0200, Dmitry Baryshkov wrote:
> On MSM8974 programming some of the RPM resources results in the
> "resource does not exist" messages from the firmware. This occurs even
> with the downstream bus driver, which happily ignores the errors. My
> assumption is that these resources existed in the earlier firmware
> revisions but were later switched to be programmed differently (for the
> later platforms corresponding nodes use qos.ap_owned, which prevents
> those resources from being programmed.
> 
> In preparation for conversion of the MSM8974 driver (which doesn't have
> QoS code yet) to the main icc-rpm set of helpers, let the driver declare
> that those -ENXIO errors must be ignored (for now). Later, when the QoS
> programming is sorted out (and more interconnects are added to the DT),
> this quirk might be removed.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

When I wrote the msm8974 icc driver, I spent a fair bit of time trying
to make it so that we didn't have to ignore those errors. As you
mentioned, the downstream msm bus code gives the same errors. That
downstream code was the only reference material that I had access to
when I wrote this driver.

