Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A737E2E6
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263232; cv=none; b=rlyRvf8079+eYMgyxySSig7xrH4+TQcKK4ibW1mIWO+LQIQvv9hLXbkEfElXMbg/WAsfDGb8xbhS9MMEkeMKnB4KnV6MTT2hy+oWzIdmZUqNKkKoCk/qSxvg2VYLE6Cc+0sKMz00KD09t4SKp8Aj/nUjCbv5XwhfML01zPWF0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263232; c=relaxed/simple;
	bh=w5gAVks6i4eCJL/XLHWcDKk0c+PivOriZ11Uu861GzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaAjuxzwJonNG8/mCUNXPhEvkOFR81KAwGCMXniPHHQm4xmgPjqlhJ7aMEWqJhBOefrMnuhbTOIixROnmlfNp/KsrLsHZT/0xz4E4KYCzy8fMkcesvzQ6LHo2RX2M1Dcr1Ant1np4UsL6x/Q6X5OhaTO1rMUdUizcOUn+uIGwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT3Bb0kP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l9hM7TMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT3Bb0kP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l9hM7TMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774263229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx4+4+l1arorWkWKWlQ/lP/rEQyJg55LIMd4QQKC0Oc=;
	b=iT3Bb0kPWzChvrsuBXrqMxSa2Wy53U2b7NhgzMkBL9eAVcWfKC4FGN5YsfWplSp6cZx7Hk
	mbQDuOid0ATwZE28JGJcodUwCzHYHILFW12d9qwzyKu2ByshLGH9GgfQNKgPDJBQxCECls
	J0O3Nf5lGz3EYibjThPvXAIO1fhAWn4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-2_LPx0UbMMuNIow2wNSgaA-1; Mon, 23 Mar 2026 06:53:48 -0400
X-MC-Unique: 2_LPx0UbMMuNIow2wNSgaA-1
X-Mimecast-MFC-AGG-ID: 2_LPx0UbMMuNIow2wNSgaA_1774263228
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89c4885814dso132573896d6.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774263228; x=1774868028; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx4+4+l1arorWkWKWlQ/lP/rEQyJg55LIMd4QQKC0Oc=;
        b=l9hM7TMK8EYwd2M/K85sY5UDbIbqSUa+RyvyPo7+rVgJxyIAmoK7BWekhtu9vCEr33
         SJYl19IWRt+CS1r1G8O1PxPDXAIe9nozmsXmxkzaX62ciYA+qJefdqWhMsiZafKpzauR
         /Gt44p8KZEiwA07N5kQB+KJRYQ5DnXkie8bNQg16lUeq9umk+3CYlBgruqNXZQmg/7sL
         b/TUKzUrEkypnLqA56BBIp5BzkSrrCIpn4wdL+ZVAYcc8N+IyqsvD8N2kfEO8xl8EY7d
         4dzDN5tY+VJp4jNRuKeLQNY76Kb/0EDav6GQP+Z/3ShiJf40yMfhpPu5N+EQWQQWw7+Q
         6Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263228; x=1774868028;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yx4+4+l1arorWkWKWlQ/lP/rEQyJg55LIMd4QQKC0Oc=;
        b=HW3csvbEUw28Ba7OM2qOIEY6Pm6NMW6y+n2ki0L7wsfO8B7iQChFh9p6B+cSMzywMf
         eMsdrZvVG4VjATAyT4CVeHA8WjsXQOcpO0XbwR0yR4ecq3s1nqy6ryl3QivXsLgRoyxZ
         pwGiuLRXI+GiLCzFuCg9yVxYlwY0tH7yBMY5Bx+DZM3X4yDNEQsI/JMUBDqiDUCWbE9W
         3SKOvGODcKjl3CvyfbH3Qi52C4tkNZccotPkZw3Etc+/0/+9VZt0MdU5z/b3CvMmdWbH
         BxjqiX3VTtv/YKPHfwnRKLeDBBjNNbxopQZzhwm2VIDkPar2vkvsCRimbv07IPE+lAjR
         9Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCUiYzh1892OuOYH/XPAfRHHTMP1r2WFEfUnS1MC0gRHBIVUS3ASNJL+DqN8WCXqAu21mhUVmrKEuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRl9g8aHvPro9DnHjikPphedItxwDj7+UitUVWZMCW0LQZPCIG
	n25aDn9E0rkV+WH+vC28BXH2nqXo0I1AJSaV4LQTKMuu7iU1AhHS67ix/RFJBksOtpXxZ0XQBlh
	spXh/J32d0kEab8kSFng4s9FIIyTbaXQk262UWGDTOTECo/hDsh4p2VzX5Zso
X-Gm-Gg: ATEYQzxwNidcsu1wtZyLEHrrSlCKYh7J9zz+v5z2zri0ZwQJUMco2xjV6DYjr5A4CNP
	eJxcc+jC//q26wb6TShqY0vKMLCvOrPXGxSHE4o+WgCx07QFYaNpFzrGJekmIwAuc0w7D+BtOQZ
	u6ld8LuorgjMDoNqk+Ot3J9yV5u+qnaEIdyP8wYIj2jLqPS+O0r0wDoo5xZGbZEphCArvrh3+sd
	uJtEhGOtqTQ0VO3T+BlexMWCqFp/q8YMY9L1EAFNX5a7++BI257wBobq1QCEmmfLsxgltPFRIT9
	BZK8oIHPn28ir/8ZA1Sgt4fnEjoqIHEZYHW87Rp11K7Kwt++VH0gmmsu6kfEExGAZl35oM9bF2Q
	tlyC/uwJGUG20eiwLjSS+vBB8NDBJJql5567WZVuYyodfRsa2oNtsa7BO
X-Received: by 2002:a05:6214:601b:b0:89c:5f6e:451f with SMTP id 6a1803df08f44-89c85a0fd6fmr173905646d6.26.1774263228105;
        Mon, 23 Mar 2026 03:53:48 -0700 (PDT)
X-Received: by 2002:a05:6214:601b:b0:89c:5f6e:451f with SMTP id 6a1803df08f44-89c85a0fd6fmr173905356d6.26.1774263227651;
        Mon, 23 Mar 2026 03:53:47 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8533573asm85089416d6.24.2026.03.23.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:53:46 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:53:44 -0400
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
Subject: Re: [PATCH 5/9] interconnect: qcom: define OCMEM bus resource
Message-ID: <acEbuBCsF-fxnNpB@redhat.com>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-5-7892b8d5f2ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-msm8974-icc-v1-5-7892b8d5f2ea@oss.qualcomm.com>
User-Agent: Mutt/2.3.0 (2026-01-25)

On Mon, Mar 23, 2026 at 03:17:21AM +0200, Dmitry Baryshkov wrote:
> Some of the platforms (MSM8974, MSM8x26) require voting on the OCMEM
> clock. Add new resource for that clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

