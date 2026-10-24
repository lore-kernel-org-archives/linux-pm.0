Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792803559;
	b=kwdQ02VDIgLXahym7ftPGwkkr+OX/3AsumkB9148d8NzjU9QsiwaV7XQtvz2rl2t7dU+
	 HMm4XkF+RRKIdnq24HxEGmvS95Aoznj4PV85qMYc+Fjtc0zzMofFj1hxyQwzwR4gqWk8M
	 yqMhurgYuXYW2OlLaIW5uc5d63+dWPeNw+nHmfJJauBRzIdMjuWpo+gJzifoJt3OQHVWm
	 XSUuGL/olj2aCVj3qxz/9iJzdEWLSmR41wt1+lsl0o8QemfcN6kr0+KYUWtjwADra6AFp
	 dUvXImI7z6gRYUnriPnvYubnI0DLVR+U0D752ZaUEvr1+mVqftERkjC1ZbWuqSE4zwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dZo8YGXipFDOPlk5LjrlXEXfuFOOoXy5+FZD35r1Kog=;
	b=E5L3ZMjFB8YZf6bdd0eWDaTVMGQLiKCRxh+0LliQ0BsgYk4lQB/mHhGwreXkhQwCV7KW
	 0HrMzDBPeMJivdfY1cn63evMUHuk3zvua51lfB8uUKNHOP+8FtwDCVCTcNMsfaryAIxCe
	 Z3gHYtwWk19lR35rHTreo1lkqkdqoAUmlzbs76Wj/8cpVzprMTYiSm9r9Fwv9RRPrVg2H
	 PEIiAHA407uJp4iCqe+aA4SHO2xGXW8aetleXszwlVfz2ycHV2vq8A3NfrHiNr+x6eoc5
	 0ex2nOx3sSJWk4j7iwLmtJt+lSPwjKizBB+rVX52/nJyiyPUSHYqyQeQi77e5TCfQiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BvNnJ2qJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC054606A31F
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 00:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC054606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BvNnJ2qJ
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-16079d54c17so2916711c88.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 17:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792803558; cv=none;
        d=google.com; s=arc-20260327;
        b=FqdVTjzd3U16irhHQdfybgbyMBozVcOl/x5ua2/XQUBfrI4Bpwc4GyNonwnWDdvBFX
         CEx0B9mVIqGcil9FJd+KAvjfMVxlV2bgzVAfcqqxsOV7bkC//ONB/DriF86/Zf8gfQBV
         acp759J8R0wWtInPtG586v8JULX/mIEtcA0YCrExbR5/eqwoWZddPIFBw4JgZ8aKUf8c
         t607qQaSLQTGVqSw5i8GDaTluNN+M69KpiJguFscUZBaJWPOz2WDet0y2m7w3x0FVX+c
         ziXgZXKZgmhPHmo+Bmx99YteU6PfjY7LWNIbw9ygoNuGOHw7RLyXECXIBcdpOoWTOHBV
         W/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dZo8YGXipFDOPlk5LjrlXEXfuFOOoXy5+FZD35r1Kog=;
        fh=2oXWq9IkEwItofBSymrBAleU5dFxeoFkq6eg4SEXo8c=;
        b=mj03WRlsNBjPe9N1CK9KPHixOngb7WE+QJPK/OWGWUmVyPSSBVHwGU72XxHjmI/eEh
         seZXyxSvvsKzt1kogk6/FDIjHxyUwyezFP0ITUQySC72Y3rV3g8hzdknC4HPbEUMp+j6
         JUvdndErRN2HLuZdn3chvVy2/7bmDiIOSo0d2AL9vN5bOsfqdAD6eE9yUnhm44lbJkF5
         mZB7nw/aUGrpbHvz5fETF/t4c19RcuTgFMvo4ZHB//kpaiHYKZm7cd/uAKEIUvEHdgCK
         gNp10l7fRo/vvHs75bk2/5MsJ3jZEQ05JtaMB7AoRN7ex983eXl+zA9ythx/BWyZiryV
         OLPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792803558; x=1793408358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dZo8YGXipFDOPlk5LjrlXEXfuFOOoXy5+FZD35r1Kog=;
        b=BvNnJ2qJiKNYx+kMqLstZUfLbZO3SWFMHIFNvg5PlmWaoOBd1ZXExM66HZnXjTCi4S
         unE6rjajRqY8/A7SPEfI+4LBAuyuJiZmoG6Q0Fq7Y+tQ9wmZa108XB9h2/Ng2vW0Xp/b
         AuD3gZTSlSYuSougzvuYb2iXNty1CyVxCSA205hal/Jtbnmth7kFubu1V8Iv8Z9fKKNc
         jNTDfuf7/PVrPtMco3654bq7gxYWtmwWshbc7A+9XOhzjwvfjRy6RUeLptR0GdzXx5k2
         Z19S16Xi3RX+FXqQpE5fkAoh5JaAMd13ZeR4cQZkBBCyl5sEOlwgR5aS2wARVCM7yyxc
         16ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803558; x=1793408358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZo8YGXipFDOPlk5LjrlXEXfuFOOoXy5+FZD35r1Kog=;
        b=khZeptPshGQQJwn13qaTiCRkYYBIE7O9efg7boCJMP3DcYlyaNzpzVrnx0XXlAraFm
         0OEpiGBPIGJQfaxvzqNliHBFe6opRTIq/7z/ygfdA8HMmPMrFCCjmtFcmodukR53DWY6
         bel1nlhRpdgWAFmk5hBJDUq/CrHw2zMW+F5IykrTpvI6dr8gXUloZg9oPaFHpHY15BD+
         d5mC/uDaM7lYEM0FQrBLfQrK+mSBLkKYT/3PX1ulaiPtO4uiunbv97FtZSDXlGgYA5fJ
         eC0VbxtD4uCrcGCOzAQSQ4ESEwdEDIjWFZNASj3ztBz1fSwfhQHSx5V1JZOXZVJRJ9j8
         7O7w==
X-Forwarded-Encrypted: i=1; AKwUvBwUJJ4WiOoQdpBWYGDTTBktjReT3IMG8VlL0rVCbQn7t9guwHLDqlXRy5waHVvqIOb5dswaKnulUQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIsvp1/eNNXal6UmXlEcsqyCVPUDf2yErKzoXqvSg2KBMOon/9v
	r1lZAydJBXxxO7HDqg5MIP9S38aBGoju8p8LI2cDKAfDKA+9DslEuC/EHcCkQI8RdI8EP/zkmv1
	Em/73cn9/14Kf17gqbrjK6opI5bVOP10=
X-Gm-Gg: AYBFou3DrmbkY3rwgFxXNN9PB97CwFOCsG1700U+IzEDifza8y739oz78Je16awYrCY
	GCOeMTLfG6hLhrixK7QdFJeICnrAG6P0QyYK59iz+oOlZeQMy3BW+tCmMXzgq7TpLrimVN84tbg
	PJkXU2oVVVkURv7RyyN4V7n3thxdrOfrMWJmlARxL8OLF/h+ys06TE/NHyK2vBymD2klCNCeLeU
	lFp8VD4z/HI02MSwgJONnWJ3aK8zXDIoz85fR04uc5wnXuezRtFTM3JZEKJNb/jWtctrCg0Kdnp
	8/Hh25uYTNenUWLbOjz9uLB2OWcUgDKXAmV9pagdrlxMso6MaYzFCepbYb6ZLsY9h4xQ3yTHt50
	vrECogrEn6YhUBIpyJ3h0F03egknjPTU1lbiyxEkYXL53valjFwP8jVV7rQLYTfbqoEJu
X-Received: by 2002:a05:7022:ea4a:b0:193:9aa3:4748 with SMTP id
 a92af1059eb24-1992a250624mr874553c88.1.1792803557836; Fri, 23 Oct 2026
 17:59:17 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-3-9ce2133c5659@gmail.com> <e0becea2-c5a1-46d4-932e-50517311fb96@oss.qualcomm.com>
In-Reply-To: <e0becea2-c5a1-46d4-932e-50517311fb96@oss.qualcomm.com>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 24 Oct 2026 07:59:06 +0700
X-Gm-Features: AclHuK805OtpEX04XfOwa7m3QcwJPrF0jSlDAfdHBuylNxB6UZKJYqAFi9tMyjQ
Message-ID: <CAAq9HC7EdA3proF75D9kKa0QFJswV-bFp284u2vUfJi-dcj2_Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: msm8917: Use a shallower cluster
 state to fix unresponsive idle
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:14=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/22/26 11:41 AM, Reza Kurniawan wrote:
> > MSM8917 is a single cluster SoC, so powering down the cluster means
> > powering down the whole system. This causes two problems:
> >
> > 1. The system becomes unresponsive, even to common interrupts. Waking i=
t
> >    requires an interrupt from the MPM (MSM Power Manager) or scheduling
> >    the MPM to wake the system later. Linux currently has no way of doin=
g
> >    the latter, so the cluster may never resume operation.
> >
> > 2. Entering power collapse blanks the screen. When the state is entered
> >    and exited repeatedly, this shows up as visible flicker.
> >
> > Even if MPM scheduling were implemented, the second problem would remai=
n
> > and it wouldn't fix the system being unresponsive at idle.
> >
> > Replace the idle state with PSCI mode 4 (dubbed GDHS downstream), which
> > is less aggressive and can wake up from conventional interrupt sources.
> >
> > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> > ---
>
>
> https://lore.kernel.org/lkml/20261005-s2idle_state-v1-0-3c402c66f388@oss.=
qualcomm.com/
>
> and
>
> https://lore.kernel.org/lkml/20261015-b4-shikra_lpm_addition-v2-0-ac7f1a0=
d5638@oss.qualcomm.com/
>
> are in flight, you may want to integrate/test them locally!

Thanks for the tip!

>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
