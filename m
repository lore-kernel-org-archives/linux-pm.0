Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795263091;
	b=Tsp4vUcieBAKIbIyyHb0ksiI7iGSj7SPdyhzw1o/wfs19CuMjE6pLpnafHgerlOvQlQv
	 XLoM2v5lYRWzNFuV3xLb6M4MsVy5BNiwIGMt4M86kigq37QYrOlNWEbD8jKYL89gfnUN9
	 DzhICphgD3aElxLNlSUU2D7lSvXb2GfBXXDaQdtlynNckiehM9z5Sw2tcKpuNXiEPKLJ2
	 HdH1Mm9XJlasxrN7wlhj5lQeQyG/8tU7dPKGqCPuAceZJ1NUcMM5QcTc3QlMLkmP+eSAN
	 F1od8+AVgOIdWZSv+9V6OramyyTBthGf4Vo3Z5x8Qk6d+SqDmqGi58/o6eJ61A0rgow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uEZb922kTk9cPdYuJdRQn/n68pwJkacBa3uckuCCVJY=;
	b=ZKweplHO5/IC5SlcnBsR1Hs36Pj6qNd45mO6TfjmRFHgUsE9slBjZAOmWybv4hfdb3aZ
	 lZ5ecGwDoXx+xkbNCbwma403M8p+ofW3JremvK3B4qXgLpFL0H9KkH6zza7CeE31lF1tE
	 7S6/h6ioydyVyi5LJiKqElJm0oOpKeOyWYXEdm7uEbEkFZYE1U1SAwtnMcZNeuZ/yZawl
	 qz4zfroqFyI4y41QHivrsn3AtJq0r+PtXankSMEHnnMktGWzCfT8sabbDQF4mTW59HYjP
	 ZPpJG/sv/DGf4cMrb73jcAGMtkqlsAXv61bAsYpArHbt8e7bCNGL/syFpTKa6iAe8HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nztTc+aL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EA606A320
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 12:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E98EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nztTc+aL
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67db5e13b0cso1631332d50.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 04:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795263090; cv=none;
        d=google.com; s=arc-20260327;
        b=sMBAainNrMl1LyXBxcVahc15sLChtLT+uqX95+LZaMckXCy1gw3Qep/hzD05lZXUiR
         ipMVskL1Gbk07vpTNdrSvNxtNaH4x+rnFXKWGOieUyR2xvD51s19q4FIth+qE9RK0iQm
         n25FrwV7UWcZNRwWnZSG+4CZF5Ll9zKCNrGmcCpP7HxBLho+hhLpni5Y5zI6BDFMhnFi
         F92Lmqw3fNcxh/rUhEi5ccCjFMjkQKeHvQ5ZlBWec01gVI74OscCBYC/Dr6ncnpWKYgt
         vqibFtgdfQOnvbM1LTN+YP8JO6Blp5KZmszlqmLRVX4ssFllC+Us1K/yuE5kXgZjU85Q
         uEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uEZb922kTk9cPdYuJdRQn/n68pwJkacBa3uckuCCVJY=;
        fh=BS8CDDdeQAndegpzixt1TApwAeSFj75t1Ag+2JTXV9g=;
        b=gRE13gx1hzmTEngiXDP8a3R+EJuuN+kBHm+J3vA6fScR7v4hMT+0RS++0/f8M6QLCP
         DMYKJZe63UXnuqa+gnRj7LsjQN3MznrUSag4oODSeyu/hB6O924nsfbsYozFYwqppYXw
         Mhko+bP6vRsokq7iLss5Z484VTAoOONE1WMisoXSs4vZ903FFqNyiZ8TxYdJq/ff8o43
         yz9cmWJSIIjLYpCrL2kfthZDENefbms9gPOWAeCK1WE14s7lANuMIC0wjhfOCfMx1a2f
         1WqQaiLErxcNBMzb9HGXLv/5vVIJ/23zGF+WYGAHHCQRYF5gna7XeGhXgK8WW6o7YN7E
         PHdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795263090; x=1795867890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uEZb922kTk9cPdYuJdRQn/n68pwJkacBa3uckuCCVJY=;
        b=nztTc+aL9u5WDXTPuo6C4enyM26FqftJYOIkjzZ8zL45kb9P4tzDdoVVY8ZgKp+InE
         R4VXhrgBRNRjU6Xc8iyYWd9Q5m6+4b/dPVK+jqkLC8VGYOr5VkCheS9rvztn46i+39hN
         yN0JJbe0ltAJQVCstH/8bfbxpsEQd6GmSqm2nOFZcLY4VsBZLzg/Ja3IZ9n8tmmAOdY4
         D/zXqn7pVbtXd/IWAufNzpWa970fGrxojsKUqlXLVd+5txEvabkLaVx/KRMxqbeOU7VG
         OkCOZ1sgZVziPAEWqct+UR15HwSFX+s2v445FeWnsLS/vxFe/ilpesRoFhzm3NYt1EOm
         uiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795263090; x=1795867890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEZb922kTk9cPdYuJdRQn/n68pwJkacBa3uckuCCVJY=;
        b=Og3KstcX55zRzpuTi95f4RQRgaF8HBN+Kp7/waNtNGvccZXQe34jt4ho8hMuTWMBvp
         9HzmmeyAOHY8eXLeIA5IaHxmpC2UQSKqW7mscVuMoWPYgLebdnfvUBJd3zG35up+rFTG
         EPFxrZ1t91MUSi5qMTAyLqAOR/iNQSGFDDN6rflgItyNRJTI5mIInkUrk+WbGEAGlA/D
         6hOJi/pCMEKedGEaKl/HQrFQmSBi1+aJoGlA72xDyRb0am4d78uCCoJ4JJKK4tXU22m0
         d0qzfZ4C7jAIX24WJ0z09HIC6PzZVgq0WOMHgwD5WrJVYWLeHj1Pxj2pMoYzFmeVsTwV
         z4Sw==
X-Forwarded-Encrypted: i=1; AL+hErHjJ8XfMKZunVKYZSmY5FLjys/hIkrQQnuojllqS8kJKTApugGknCc3K3QSt6GeH0QvcLOHqZAVGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HBiyCko2bdyfZj9elYa6m2kbpesDgXLa4ysuwdKrKp97COgNz
	+jexo0Ae24PSUhotTBn5js3rO4kvLTDbACUQYWbKLttbAMPN5oEk1wK4ZJVBOFtXTBEisN3pZzN
	dZXxFDMGRfId4Lf/egYXz5tyD9OHAsv0=
X-Gm-Gg: AZFdTZfwir5cYuf4mXJIYQY+uq2vitB8Kdbe635vYnCX231ETxeTkiADEns67AJ3Y3j
	jNIfNahsxyvnKFhY2UyteUaWBmrKYbfdqesrJSQtv9LntgHNyul0Thym7MAmjYZIw8QFepxyM5k
	kj9q+A/shRpLPnZG8mXDQykBwzyaLIOCBSlF4kcr80HhKunoeFCHCPjneh/wBq5zbi8yilvMYka
	fHexQSSaGwkfc5dSGsZ1QEbJs+SDmlkJANIW6QARgJiodW7pHLIZP/PticAFuTZZCWpRcQr9eDU
	NYfZwfQfEfYYMLcV4owtLtTFWj9a7EB3NBD8KOG8FAL/gQbTRuJ0BXW+Pm2/mbW1HsHT9TH9gjk
	XAsT74gRNlDFkLL8C00/2yfBKjIum4Lc3HVVxT9q6J5ogQbOp2rLLkYpti80xLscRMggLDq7EBT
	2FsLar73ncM9xKk/5iI1OlU1skYw==
X-Received: by 2002:a05:690c:61c4:b0:8b3:5fd6:a544 with SMTP id
 00721157ae682-8b52047e1c1mr19674487b3.58.1795263089936; Sat, 21 Nov 2026
 04:11:29 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
 <20261121-m3-cpufreq-opp-v1-4-42a0c07c48a4@gmail.com> <CANpmGNvd3Bnv58BQX3UcX5eOip5Q0DfmPhvPp_9DGRQQUWOqQg@mail.gmail.com>
In-Reply-To: <CANpmGNvd3Bnv58BQX3UcX5eOip5Q0DfmPhvPp_9DGRQQUWOqQg@mail.gmail.com>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Sat, 21 Nov 2026 23:11:18 +1100
X-Gm-Features: Aa3M54osrg6doytRUFLjK8s5YltogEr6ZngrwFO8UHAiCYiFQIm7-VCyERe-Cqo
Message-ID: <CANpmGNtfmk8QODQf9x7nkVSr8F+=8Hfh8GbKjCOnxvw3PXCTFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: apple: t6031: Add CPU frequency scaling
 and OPPs
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yureka Lilian <yureka@cyberchaos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
On Sat, Nov 21, 2026 at 10:52=E2=80=AFPM Michael Reeves
<michael.reeves077@gmail.com> wrote:
> Oops, I accidentally forgot the capacity-dmips-mhz for these ones.
> It's just 1024 like all the others. Can you apply that when picking
> this up, or would you prefer I send v2?

To fix this and add proper T6032 die1 support (as suggested by Janne
in response to the cover) I will be sending a v2 shortly.

Thanks,
Michael
