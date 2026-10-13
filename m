Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54D489FC9
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888201; cv=pass; b=prM1/M2SmARHV9Hs7EEhsdH34BZqhl6GPssRMPNyKlDtxH2ABbAdVf2s8npksKth9RjGE1Z/eU73+EOeXGtYB5Xh1+fE7u4H5fMgki/LYgOLv8oLQdmDnjykF9mfanOJvLh9VnSsXY9S+AVMHXR3ue2oAmEm6wqs+uQlrGlnoWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888201; c=relaxed/simple;
	bh=//uOm0VTNuD0y0XaUO/FoU81M1a/Vo/45SryuH3ga2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+cFD/HPMIKNeR4Cqk7ZeigsnkgHTnPI4sqkujJi6+4598YVQ2bCQ5rxeUAi1KVmAJgIkeTGm2JQFWesk9jANrystgki34oGDIr0CGXrWrwxFOmEivpkRrv9wyq3+jAwNuq1+iKqJNfdGz4cLObqyuaWddhZyQjtPi8LxfSfWKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0Y8iMEj; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Y8iMEj"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso510318a12.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 03:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888198; cv=none;
        d=google.com; s=arc-20260327;
        b=kLIvrdkaV1JsQEZefKEXGvrUATbBi326Z2Z73TwoDXiikySW4U66AhW94QkJX3hjYG
         YyZpYHyADm8G+Oh2F+TPRlthg/2CCIFvkbS7baXtfCwiffG1etDE87pI3ghwI+Sm7mFR
         mcaSkknYDbGVCRh6XN0NKLj4twKokmqK8bR79jQ/tjXYf9Uj9DeHlyu0Mp6BDZ9TSd4F
         Jnvrl084nNa14I107F7QgcbJWIsAA9x484jcrj8V8xls89fqbazXCJhbOimUPfcC613J
         AbQeoAEOENYPtbTgpDvNq+KzhMbOH2JwvE323s4IMOIY7T0+BOBDnTJIdz/1NW/kE8Xd
         F6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=//uOm0VTNuD0y0XaUO/FoU81M1a/Vo/45SryuH3ga2c=;
        fh=ypo7ADVrNw9cvDRpZM3M+64tbvI93jMmxwdYVQ74rMk=;
        b=YuazFzAI1Yryh/yujvKjIdDYDJxRQvHasBV0/RobwcF/WMoqV/dWW3Fdx8Z4MDG31l
         GF46AG8gbEdDkdoXphtS3E/MV0L6aCcG7jLZ7izoYi28bqZLzc7v+VTnyszThUhqHlte
         jrjBPqGqvF5ZD5Wfz9J4f8rbAnEUwSpIBM0dPl2sZ1ZEbjjSnhZQ3Eo7q5MwU431VeFb
         3XM+Qpga5/0V34WQhvi5KYkNZJI1Y/6NWVc2udvSG4KhBLZ4c2lygRQiJuNf5OBOUh4m
         HcLoMouUp3/pljP21DryZ0dPd3eJqRqxMOKEL1PLW/28vr4nUhaWqWqzE4Y7ZWGSHZEF
         OhFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888198; x=1792492998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=//uOm0VTNuD0y0XaUO/FoU81M1a/Vo/45SryuH3ga2c=;
        b=B0Y8iMEjKKdAnXuInmCS1ci4yye2fpzcYPsMiPaJxFbazlxDAo2pjSpfBWZGSUyp0b
         e9UFEu4qn1Fjj0qAZpuB2xsfKLE35wtSmIgz+c9B2QrjfUJ78DqOQ4nCG27PSsM2whVE
         HZ7w3FktQwbesviNP6ygSTeieayw4JrYo4ruRlqL2tpEIN2qnWak8DYl9WosRl4LTOao
         GDAaybbfPWxaMbzembdP25VMd10QtgPZSB2mkgp13ct57x1Qeawqv+sQjbU9QpMzCWQB
         ScNA1gqy3nTmu7IhqWy/7A/nRaGEnSRdkEoUFB5XjxW2cY4hFBtwPhoj6N/Hdhp35Ds5
         pkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888198; x=1792492998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//uOm0VTNuD0y0XaUO/FoU81M1a/Vo/45SryuH3ga2c=;
        b=BcWMJy5JYWUqTjX8ZJSlBDcFY9rTo2nF2v8lHLUpMT/7TJhtVGMo5CVymKfv518Suh
         mC6CBwuAWV2FvN7mhjfxoMkabJgWDJKbid3fdr7C3wJaeth1a2CkXzLU0N2NJyKsDW90
         azcnb9JmLQZrSZ+E2e2LmzI8Jpah56o43kbBwx4Kgg6BLr5VMk2C+ap9/P+rmZxPpYnA
         W593uUVZ1epGKvY5jtMpIFnqikjFVyunuh/+O+AJuPenF3Kt4Bn4OSRSczdA9klQsw2+
         Ff8gT0MQlvYv6gFrc8GyuVObA71IezV8ZObju3NBeIqURQ4VNUPUSE9UpjJTIBPDjdh1
         n9fg==
X-Forwarded-Encrypted: i=1; AKwUvBwbW0wnV8G685xORt87KSjI/rlRIAn6DNAptMpP7yyEJARyBy94jaGP8mWOxOMI5ZGsYOEYzo+8Og==@vger.kernel.org
X-Gm-Message-State: AFq9FYLxRUXz62yVNmk+jPOrg32e5AzA/EN/q+PBdRB/5wUKTGgXPV53
	7IVvlFbjNm3I4aPv2GpIJi2G85wx7ye+ELtwFzwHRC9Ek+5ROHT0EK+aNvavWjcST1rmdWYZci6
	HDPNGUTqLvIOy/hOeN8YJbM4R91G/agY=
X-Gm-Gg: AYBFou34r4NDQLGwOOVyk6LJ7BARf8X9DUVGkXyoJozyZT2p/scPMNSk9TEq+/OQXQU
	VK5C3BEM78prfhxhG+daUnYt5fMU30/Ifa8iiteDtdXd4i6st22BN8CKD3Gm/Gmay2nfAOlSaBd
	t+09UT1Uhzs3tnj9r/snjmWVnO9NFbzooLv4apsiCX8U3cndaJIacyHvgiNvmvGQIlp56WNBs6d
	KDOmja8LhNx5AQV6y+xb3Mrclxc8uqwPhQHiYui3XJv6zIyTeBMRPO4Qk3tigHvkn1+CCbd3YTp
	uz+uv4rQ2zUrk5QnbNIPj8aTAwMmKT8LpdVe6iDvbHdjIC6ASg3gtsM=
X-Received: by 2002:a17:907:968b:b0:c2a:c76c:c743 with SMTP id
 a640c23a62f3a-c31aa0b353amr1124595566b.35.1791888197437; Tue, 13 Oct 2026
 03:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791512067.git.zhoubinbin@loongson.cn> <1375bd12403bffc496261953772a45833f9b5a3e.1791512067.git.zhoubinbin@loongson.cn>
 <196b51ef-835e-477f-a46e-575e37bb17e0@oss.qualcomm.com>
In-Reply-To: <196b51ef-835e-477f-a46e-575e37bb17e0@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 13 Oct 2026 18:43:04 +0800
X-Gm-Features: AclHuK_tDCwBdwZoMKnhN-N9F4FyVAhXECtz50Zuv-v7rjKroUjNNoj2cpVB1Do
Message-ID: <CAMpQs4J5yWNsYY7NmWyWDSRuBjD=2HRwjLB0Rh2GnEaXxG1_sg@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] thermal/drivers/loongson2: Use bitfields and
 per-SoC thermal ops
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:50=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 10/9/26 04:58, Binbin Zhou wrote:
> > Replace open-coded masks and shifts with GENMASK()/FIELD_* helpers, and
> > define named constants for the Loongson-2K2000 temperature conversion
> > and trip gate calculations.
> >
> > Split the temperature read and thermal zone ops into Loongson-2K1000 an=
d
> > Loongson-2K2000 variants, and keep the chip-specific trip register
> > callback in the chip data. This prepares the driver for further SoC
> > support.
> >
> > No functional change intended.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
>
> Please use the bitfield directly in the previous patch

Let me reorganize the patch set by splitting this patch into two
parts: the bitfields section will be merged into patch-3, and the
remaining changes will be merged into patch-6 as preparation for
introducing the new SoC.

This seems like a more reasonable approach.
>
>

--
Thanks.
Binbin
