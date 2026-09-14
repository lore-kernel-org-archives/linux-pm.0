Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AB43CE45
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382443; cv=pass; b=LS8JEKHyEQHwqzEFVNosb8eNZc143LOoKnOv4LmP2oKTlbcI7NXJzYOXUKbb4bH6XtWg6UDyVwwoPNkYain1AiRjQNv4YZaTvb9YbSXuYBHvUUPI8s4tHAriSIHHfom+q7taT4A/K2b25hBPmVVgnpkjrjDbrIpEf/nLL+yrMTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382443; c=relaxed/simple;
	bh=CZXlPdTEAeBHj839T4HU9cpkm6eNyjon46e+njHBZo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJg1sDAEapxDeLeuIkKaPlQR8H5Ylj+yds7vCjaD2YOq1cL6DCvrfqassFDzrL8IBCnShWgI54otExMWS7Z1ZkLeyWCrG+OAK+zn4fedwUgwlfZSVhSVhaKRwdgF53cEXioG1lACji+o6K1yBh+FPt5nOVjyNsjIVcUJ/lKqkP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=e1tsi/ah; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e1tsi/ah"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab2029eso1592365d50.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 03:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789382441; cv=none;
        d=google.com; s=arc-20260327;
        b=Ua6WAPoxIAjGogWzAYy89pHMFFH2cIIdSgWROl2Ryq4k+QkuolbiSmmY1/nE03wYBv
         aW25YP1b3LijaIIaq/XDxxpWuw3zzRnzOnDDSP7JcfQSFkYwKBNZV6H0wuAV6Qt1+zrW
         hXMRY/Mlew8ngOB/2WHcYKmh2qP+0ZRsERn1NOwIOVuDAIu4PqTLXKBMzW4GCuWFNhie
         DyC+8xZPKxp1tXV8C0CGRhFq3BPRSNCGGVAo8vlCF/aLlsUyiLAqf8kY2WN1XIrL0CDA
         aDUbxCGg4FPlDWplobMMq+d0JCCKGMNivBLgwU0Zti0qRaUm8/nfTs9EMAcQyKwW6aM0
         8zyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CZXlPdTEAeBHj839T4HU9cpkm6eNyjon46e+njHBZo4=;
        fh=JiEKhthA7zjAnlaWwuStk4rQ22DfqSqJ+tVo/cUErG0=;
        b=oN7nQ2h7oRNoGCRueAnQBMvLyanQv5mHv0lPEsPbPwfLsZ1KHQ5a/MahdNPGH8UvEe
         IsbTpB/eR2u4Y+XnP3dsxOIhTjwovIH0UVvwpzLFPt9RO0chVuLkey11Os+UjPjVp1lK
         pqKluonsLoS+nU2Ta+P3fkJXTYZAZM1mLLcM6+HwKtDGoTgvZTG4K+GUeeg+E9TbvSZQ
         dcopmVKVpIentp0+/Hsy1pObqRDraUKJnAsrsQ2IztrTG4fR+sgisVXRyxYXYr9USo3O
         px0HoD1ajfbfYlLZnAh392DPLrWqVO3ieojNSETR+hO4FMoz2bphwllXXDPz7847buR4
         fB+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789382441; x=1789987241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZXlPdTEAeBHj839T4HU9cpkm6eNyjon46e+njHBZo4=;
        b=e1tsi/ah4235p451Eyger3ojtmEj/bcXqVdT40mibRJK5AcoqilOqakPl0B+bROf/j
         O1z0NrlB6ocOniBPPZbHxk/+vVtDIL41S2hF89+z9i1Dhgq//EB89Q/wn2dkf+IubXOe
         LXxJOrAtoLmslpWhldoPU25R4MDjJGMUoOcHPrjKes7jSXZCLeLQWwrQNhHghpJiv3gM
         6mCtFghKXPgmreIHQjvojoxs85YpJl9iHTGhH7MSFbn4Kj2Roi2EXvmfylYND6HuCBa/
         63hs/Lv1DomWkWeer9xmJgEKIwN/WvTvXM2BsES07hKwOlX6BtErUnmpxhTUO5AwuYpE
         6drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382441; x=1789987241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZXlPdTEAeBHj839T4HU9cpkm6eNyjon46e+njHBZo4=;
        b=Kt262p6iYP+BWV83QuU3Zy3GqBspO6hxWmSrQuDGiwNm51YjQb6h0yek62Mj3ldT5f
         FY/4S/uCayEkLOXD33A7HDAexcJm0HNGwNWb/nYtYPq1E4+pM0FKPbn+GgHPeXfTW16J
         Cj8leFfv6T5rZriHZ90eTZac/znjhmzx/LeVNCEh+yz640TCTCsm0kcHl7ZpPdQEtae3
         0J4NLyXsRVt2GuEiSMg5EXWaI0faY5izEjP02m0G0tDN0N6zrVTJBkewBfueeJFbhzG7
         7UwnqCYADlY4yX8PWiSMjVTy8LHqwTF9CsuHuu8l2A712cyG7+0IxVkD3Xe/rbw2PCN/
         fJug==
X-Forwarded-Encrypted: i=1; AKwUvBwCEtctR24ACCsANkFW7UOANY2TfhehjcARg4RIziH94gFxoKc4WNYvEvrAUqE4gkjLDa7eL49M5A==@vger.kernel.org
X-Gm-Message-State: AFuF++mTrWldTuXQ+kXpNDQGPzaNvXObc1Op/TJOgge3ZAbA/xi/4new
	91p6JrIhnXv9oMFP1YyJ87nl+EWFRs3YyS6sTrOy7p9bmdfTOGG47HHrsjyrvLRSMmSmHvi4EU8
	vgppHGtYAVZZoikU3apdiS22ObR/5sLA=
X-Gm-Gg: AYBFou3BlW6HP4UAh9yciKWReFBdvcZ20Je8I4Rvg3izZWNOJwVDWVwVnb+H31ofViv
	G/ob5BtgCRCkQOfXlun8R/w0BCtA/I3jDy7bkawoB50LHQdwxGWY1+JnFd+L0Frg03ST80FkeLA
	TaHx4gqIaMYiNQ827NofmjhgaJexWalNmiE9IE4PwPbGVYyCi3oeg3rZ9/g8U5+ziwZA7pwuDEz
	b8oCvFB8UApbuE9C1ZvJL1jFd5ls8qOoxbsaWP60v0Yuit0G1W4jY0gG+noIUc5V2+9YObK2qTn
	I+6lIozBwJWyX6VetVJ6MP3dc1xnYh9Rt2oosP7Mlu/4C9tpHTF+uD4XVDIXYeTdUyoFfITc5C1
	8fM128v+di5iVm3NoMIiC0dju
X-Received: by 2002:a05:690e:144f:b0:671:1bc2:7f83 with SMTP id
 956f58d0204a3-6714e19664emr414645d50.75.1789382441505; Mon, 14 Sep 2026
 03:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-a9-pwr-eth-v1-1-752005131135@amlogic.com>
In-Reply-To: <20260914-a9-pwr-eth-v1-1-752005131135@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 14 Sep 2026 12:40:30 +0200
X-Gm-Features: AcwNN1WaZUZ01X5-U4jB8BOoolJJHZrM3FcxWuEUtBzFbxVHcUoB7XaLZqR-tLg
Message-ID: <CAFBinCCgvMbM5zf8OXFhjNRWjDMTjAVPu_BBJf1GRKp7JPqk=A@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: Keep Amlogic A9 ETH domain always on
To: xianwei.zhao@amlogic.com
Cc: Ulf Hansson <ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Qingpeng Yang <qingpeng.yang@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:56=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Qingpeng Yang <qingpeng.yang@amlogic.com>
>
> Mark the A9 ethernet power domain as always-on since it is required
> for ethernet online wakeup and must not be powered down.
Is "online wakeup" a wake up from suspend?
If so: is the Ethernet controller listed with the "wakeup-source" flag
in .dts{,i}?
I'm wondering if the pmdomain and/or power (wakeup) frameworks in
Linux have other ways of managing this case (e.g. only keeping the
power domain active if needed).


Best regards,
Martin
