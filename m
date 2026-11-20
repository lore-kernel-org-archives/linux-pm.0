Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795185940;
	b=24iR20n5uBMh2kcusqLmUVGV28aivqoMapl+/Q0lrySwjUGWQHs2Y/6uyCRQp1P91x5V
	 8u3DhMhBx2fbGL7HX4PkR3jJu1HQ2xkaLzDo0Xg9ZeP16WIi0mfzVij83vXxnDNaNCC3N
	 vp5pizUm3ndA8QUB9q2vQ+mtNxS88q4adEV3gjT11hT1YXME8he2pBIsfsxxBb1z4EAgh
	 422BenD3bTCIBZ8QyCXo6JYhFB/I186UBuw8U7uM0XHUsKa8kbluTLnaSJLsV2F9AIEMm
	 oO1Sgy2BRMUyRXewIMdwYIchcAFJcAauEpf47/V0UJCV9ZAwnjbb/9lUap9maC1TQQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ywjMM2WSUvMwVklBf0BM9q3a3U6GByEzCtPnH/AryCs=;
	b=P91a6a9KVZ/INyKne6sqMy5bN+89HDejngNrXicWx3lwJO0lTdTBWrBvSuogD3PfgqX5
	 pdc1QfPp7IlLfHAalmCqjH/ATlgueXT6uFmz2/RsZiBEMYWr9zTqgnDJLE4fVbCFGZZCI
	 H35H9wqm+0L9cogBlIvDiWZsfOBNDlp+uYHvW018PzoVVY3RU226+m54uq3woXe2MIV+W
	 20ahKhydAESVEsqnIHCrkxJuGrFsiE+yGGp9zGzZtLB60/T/gwNk6kYD7OgOcQa/m6lr4
	 VGPufll4SD+iZCfgIfBw0dbDa760K4x0vn9AxdTpNWaR5SrDxhKFzGfpriqzvQ6lj8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=fbtnhUAn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C577606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 14:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C577606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=fbtnhUAn
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c5133831027so147685066b.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:45:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795185938; cv=none;
        d=google.com; s=arc-20260327;
        b=rnRSpBYzBs9bU5nNOAVkBAjgmeDtIFM5sGpLRnh2ixSZh4tubvSIuyqIGjD130h9/h
         ePAsQ+dVAuHlKs4TyFszWdak2vBLj4eEtrpjVfU+IMxWQvJGvgQlC4iHpPi/9lwCukl1
         0ctqr/KGD8dN37XXbLTJhXcFBM8fTTYt9lZCnru0j3YQCZdsomIq/t9AwwqDvbRVV4Ih
         Pk76Pz0y1B8i4CsucY7CrY0XQZ7KXtA4oVqtcqqVyX7cSkrw5QVx50nPo5Hv1h5EqGDT
         q8CIKwLvbrjJgoaIZKfURdXnrpwQMN/6ABJsBIj1oeWRTSBjMmVK7FkAEbhim4YRlTTc
         xLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ywjMM2WSUvMwVklBf0BM9q3a3U6GByEzCtPnH/AryCs=;
        fh=mvhDzXKL/I1xES34n1KxdYzS2NSCfBU1UuZpddadAnI=;
        b=bJ1k0EG5Y+3u+q1uj0S+6zXf63RjGDupPtFXH19Ie6bejJZOqM9pFqhEsZgOtBX0BI
         wF6xIxgzV+lJlmd534MYpDhXjlf+0grWOOvE5CfNYXXGLDptcsSo4Pzk64GYiGcUMV1r
         4phnDFJhgXy1ZU5YvkIqPVopoqNGMVsFtT45QTzgj88L91t5Ra/0E0IJ1cvCz1iwEo9I
         aQOeJlxNuy2mi5E+cEEOaSIltAttpd3bjAr+SQ35oUw64H7p+NVOtC4uJtdNQDRg/Dew
         RCNFPad2p1JtMDqhTHMGzZfisIYyQgbQPeBzuW7yszwvUzoVySo7RC668NALkKIH/KKn
         Dl5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795185938; x=1795790738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywjMM2WSUvMwVklBf0BM9q3a3U6GByEzCtPnH/AryCs=;
        b=fbtnhUAn2Q7RF7sEM4muGNFO7OUAkj4H6OFozkzGoVlzaGZXM89P9TENj18A1YOlpm
         CSZieuRNqUzyjUuLWf9ZjalElDfbAETPcYKBrlaVXcnvSXQ3s4ypJy0XreQ3INSIzLNK
         N4MHIZhc541vfZfHFtU/LF/b4PaAdPICSGesslw0npo5nqRgwDOCrirh/5+/znv+iZhD
         d3LBN15+xtBCE4MJjx/xYtpC9HHHjzOlNlmcRcLJa5lYnZoyQljYJSPYwceEA5JI9nHF
         Hc0rKNNgCxgPr8O6Zc5x+/yy2TRYs0+0Axd+og/Ws6EBzubQQlkstOchd9GYJ5d8rpXH
         URvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185938; x=1795790738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywjMM2WSUvMwVklBf0BM9q3a3U6GByEzCtPnH/AryCs=;
        b=FfyBUjh1qx3xs2Zq1cEkjhTIaMs+r2+e2nfZl7D6EwZeWqhRNNyx2gSpnA5QO06cyI
         LA9EqNIxLoDZjac6lJNrqlLUtT1+GtCCno1BBe0SFfe6qA2wEa80v+47JmJzXFKbtBi7
         nqEivObPXoEceoyT53kBsugzF+XmLEsaxSOvTAYGvpAZ8m4eHgznKszB0LQblI8JOd+P
         UR6mubPe2bBJ6TJ0hP5r3BIPvfnooskufo2VacVdA2Z0sROkII6YVabS3ODpex8tQpxN
         ecAdDXvgfNwzlG4FVbn1mQHNcMALrPU2t/8Cn5Uc3SpiltzWoi54CcPSkmcv40GHNtBm
         gjFg==
X-Forwarded-Encrypted: i=1; AL+hErEwqMLNAfx0QnhynmeWwRkp1qYRCvE+iACLR1iIyZRPGgmsDPY2cF2IVJK0IX1WtTxeA872CjmvEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/03qRk1BQpXZPK3+zG9OuKtR18kW4qhT0vThoNZ8bYRuAiskXa
	c+gEt/MB2KBeTXH/BCQSc2X0NTdG/9mJxXn54DjJNh/oQk06zULciyT16WtMbrW1KqglYY9uD01
	uibX8O/Hd9qDCqgLPT8kAAsztz95F1yhZU3Wcr7ougA==
X-Gm-Gg: AZFdTZfLmtqUQxwBipjQ+zNhMk/139yDJfiPd9pK1HV8JrJwtWr0xLDPliVRfWmUHEx
	UE2b0A3fO0h+8esi5KXdQ4K9RuwYuI2oeWmYhBILueNTAqxuhR7Wiu5zGa5tedE7KriK4xF71cB
	QM9zi8vOGcd865p7S8Y90sCMDh/zILyPiq1C1JX7PpXnbBvAFYH9Fo0qy2TQJh4dHRHi+We1aJp
	LNs2mwM4WEawWSiNVHunUGSI2YwmiooZFgyDH5c9KYjcFWXsmq9TuILnhpXtl3SmD6SN4ITeIEl
	C92cZQvdCxr73IU6/b62ooASeN5UTs/9iFMxs+0iYHXEq2W1/vbN/t7Ri62OOvs6QUaLYSFnvUh
	IiHI1JFRmyG4rTKlntr304DPaZGSNmFPznhpcXkpYGNg2+GEgpEG7ylolVZDFfQmCh5kQGavDCd
	MlkmIGtZ4bs6fvd9ob
X-Received: by 2002:a17:906:4fc4:b0:c51:24a3:208 with SMTP id
 a640c23a62f3a-c513a5da66bmr340053366b.9.1795185938297; Fri, 20 Nov 2026
 06:45:38 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
 <20261109-battery-charge-temp-range-v1-1-a967abd8b80c@flipper.net> <20261119225808.GA1121782-robh@kernel.org>
In-Reply-To: <20261119225808.GA1121782-robh@kernel.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 20 Nov 2026 18:45:26 +0400
X-Gm-Features: AclHuK-7Jyc8TBiMh3SZmeiKuU6wfTaME9iZFCNa2ski4ByTPxfFe688HXmvWSE
Message-ID: <CAKTNdwFc5yam2HjkR4ShsMHJbTs7SesyvNoYQWwaeL5mAN9XMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: battery: Add a charging
 temperature range
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:58=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Nov 09, 2026 at 01:41:48PM +0400, Alexey Charkov wrote:
> > Describe batteries rated for separate charging and discharging
> > temperature ranges, such as 0-45C for charging and -20-60C for
> > discharging, often with a reduced charge current near the ends of the
> > charging range: operating-range-celsius holds a single range, and
> > existing users read it both as the limit for any use of the battery and
> > as the limit for charging.
> >
> > Add charge-temp-range-celsius for the charging range, falling back to
> > operating-range-celsius when absent, and state that
> > operating-range-celsius covers discharging. Add the charge current and
> > voltage to use between alert-celsius and the charging range limits, to
> > describe a reduced charge rate near those limits and none beyond them.
> >
> > A missing half of an alert charge current and voltage pair falls back t=
o
> > the matching constant-charge-* setting. alert-celsius is expected to fu=
lly
> > fall inside charge-temp-range-celsius, but when it does not,
> > charge-temp-range-celsius takes precedence to ensure no charge occurs
> > outside the allowed range.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  .../devicetree/bindings/power/supply/battery.yaml  | 45 ++++++++++++++=
+++++++-
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/battery.yam=
l b/Documentation/devicetree/bindings/power/supply/battery.yaml
> > index 9575ee1491bb..d2f2ed9a01fe 100644
> > --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> > @@ -111,11 +111,21 @@ properties:
> >        for each of the battery capacity lookup table.
> >
> >    operating-range-celsius:
> > -    description: operating temperature range of a battery
> > +    description: operating temperature range of a battery, in which it=
 can be
> > +      discharged. Charging may be further restricted by
> > +      charge-temp-range-celsius.
> >      items:
> >        - description: minimum temperature at which battery can operate
> >        - description: maximum temperature at which battery can operate
> >
> > +  charge-temp-range-celsius:
>
> 'temp' is kind of redundant with 'celsius' and a departure from all the
> other temperature properties here.

Ack, will adjust in v2.

Best regards,
Alexey
