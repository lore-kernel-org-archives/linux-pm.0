Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388D3BD643
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271711; cv=pass; b=IOvOi+zPqg7+wW+inORsrGJb5AQIBXbcHfRNXJHeul0x7Rcb0GTq+d3T8YkK0Ay+iCkdbVHp52fj84WFrQbiR05JEF2ldfR1QtgI9/tFM2hYwAsu3+1S+27T8wLlF00ihXvLAM1nsxY/SyqUrmnZk6HKlBebI9Woh1SFYrbgINc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271711; c=relaxed/simple;
	bh=RwJxTFnJ5CXL7SNwJ3FzpgAg/ebATche5LLJ2ldkVUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6VKqpsWs7OWJIuaHxGw5QUwQz+M0UfKMc1EFe1fvuYOSI7lPApV+xP33bFuxFSJuifOuPMuQzLLy0f8Hj+gi9M1vFfhYqQZako5CGG8NPTMQ9AP8puhdDsKWtWQPM7KKHG3s1/z7x+GXVrupERvRzPeY6Mw8BXwZsaNeLNjI8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iba2jLX7; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iba2jLX7"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2808dbc3so46328101cf.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 00:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784271709; cv=none;
        d=google.com; s=arc-20260327;
        b=e3Wqo8gdQ6a+w38Ewf2Hh0h1HKN6iJfHPcUvcgbdFnRXLpQ9JVFJkkGEitAPUzPJBt
         FK4LZLu7oxLFC0wZvzY18wTOPDYutXnQM/y2z2aKerKsJhqeYJ3iF6o+TelcjdrsGtp8
         tH66aD+rokzIFPrb9W0B+mmZ+qdNYJ5q2rMjdELwo+8HLOOdg6qCi7mXq5tpZl3DtTEj
         XmlfbdlKm+P176MyH9Bs2RnT+910Oz4N73MsmfSbLNNZFx2Crzz9nxGwAPB9BnIwDFHK
         U42eyGN2RJnUAOCMKkutcJhF9cQh0iokfkTDOrXXKbK6aHV2ivJ/KAXWCHroA07fYkaV
         TTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RwJxTFnJ5CXL7SNwJ3FzpgAg/ebATche5LLJ2ldkVUg=;
        fh=mLpbie9/6H3mZzrwUVOl+AZn0E8Y7jhdKjiKOlLBrjA=;
        b=kGMebfbtbGl861UyXjAhj+8REAsWab374fOqsbOrWnQlnTD71yMCvYAEDPgI7/50mL
         mDFKUlh21mEsyb2O4AaukFE7CLV9IZBJawBg6VyzON5tjNrkIJwcJ+Xif9Co+FQuejCq
         oAp//KGaNSAO9ZnBya2x3Bp1VbOPTu/P3YRBjiBJn2iCJ3zrE++RtJ+iOlH8X4t6gra9
         vsRsIds96hrLObLsZgktQc7zxxMbwZ0xytvO2Ad+3qtdOg8ewAcX/ZF3tYIfWzwIMkTQ
         ImtMlc0TwPtsM6dvPj/foKfIAmegU9TYbZ0R5QC82IlQNReuapCRTG/XqB8RPzeeMMJ+
         iwCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271709; x=1784876509; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwJxTFnJ5CXL7SNwJ3FzpgAg/ebATche5LLJ2ldkVUg=;
        b=iba2jLX7sYz11VR5J9XKKR068YRf3KgpbSfXz2vfpqk9bYxorkfkewRxLn8Vk4a28d
         A1EaIoJC9MvOe7a9U4GSEQF+e7rBQen0/PXBwhBXYOsZWDYChqpd3W6Pwhl6iFcmapmn
         1rvXdHzRWbcHxx2TIxveIBBDfGKesF2ztZvUwLfrhJMKDSvFWCoeo5rjTaOwP87iu3hA
         jccK9duHTf0ZSDWBrb2vrmX83zp94HltwaQpAlQZPwzDqf2lEK3IziaRscM5G+zhbId0
         7FpgDnYsBpPWxsZ1zzx724HXo0WUih2xZlrhFR9MOB4C0Edo67UFYHFuU9Blm24+Xib8
         S53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271709; x=1784876509;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RwJxTFnJ5CXL7SNwJ3FzpgAg/ebATche5LLJ2ldkVUg=;
        b=MMxCRbdWz8kdyXlCGIHGYLdukDmWBMllxs4bST81EJYjOVf/ETiNvQOglv9xp6Jf8q
         TDgvXi9MZZQxhwqhOFvGkQrOQcU3DytRBq11eM8FHaY0SYDJuSZkLtjnynxKzXXQSuZh
         a+tCDuk5w6kPIZQhT0Urx6pxwjlJedUarffT+Hv61hKZ/dQ1zDJM+U+miWzhdBLCzrbq
         gtX/N+hsLdnvcECcBU0YVXuRqynOBjuaUou+m5jmGXSBkBvpqkwmhKEWZUg0siB+i9ii
         wQeyPLfmKlEEjqjhQ4p+Ckuog/qzXENIW19TVUsz1m/JgKwj9yIYYldVF/91BrTuFTYO
         HFjQ==
X-Gm-Message-State: AOJu0YyqMcVFVwGlQyJPk0KzUrb32ofN6sgHRl3PZ3GSJFItWEbqLlUn
	h5sactLtxMN6pRe6v02rytS7bJy71a0FW/Kr8QJP81/iWV4RQQkaiiGSjUW3YZqq7p5aHvw6VMB
	V2Osy754tHLsExMKMedqdro7KQqvtn8E=
X-Gm-Gg: AfdE7ckDDtA9olZx9mpngwVkHZzcWgtd8u4CzqJSkPNZqMUs5hO7kVeTjctWS2XrKOD
	sMbBzOtsNVammDtBy6vVJ7wzE4vII+bTKW0B7ROsU782WgLTrVygHY8TrKOgS5gDEUsNflER5Dd
	qb09me/cnomC9rGRERkVIgjNgPCM6waRY1E9e41IPW9LG7uWPC4Ww+wRgetojsn0Ix2jzKbIvFR
	MKWTpPlsHOrrkMHB0lSxywOJ9au/8qC23fbGvOsGMRVvWqe/5ZQTZO/X5XMqAz4
X-Received: by 2002:a05:622a:1307:b0:51c:73f:e3a7 with SMTP id
 d75a77b69052e-5213c9db3f6mr11147141cf.26.1784271708847; Fri, 17 Jul 2026
 00:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716171733.300885-1-akkun11.open@gmail.com>
In-Reply-To: <20260716171733.300885-1-akkun11.open@gmail.com>
From: Akari Tsuyukusa <akkun11.open@gmail.com>
Date: Fri, 17 Jul 2026 16:01:36 +0900
X-Gm-Features: AUfX_mxBhDopugmTygQCr_ewrvNPScsxhXpSrlqnE3VeMGuqzfUam913liCneCI
Message-ID: <CAKr_iV4=TAKGb829nXWBBiPkQHo7dFyhT41K7+Twv=VjaEypyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: mediatek: pwrap: MT6589 + MT6320 support
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Flora Fu <flora.fu@mediatek.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: "open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:MULTIFUNCTION DEVICES (MFD)" <mfd@lists.linux.dev>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

[PATCH 3/3] has a bug, I'll fix in v2.
Please ignore this series for now.

Link: https://sashiko.dev/#/patchset/20260716171733.300885-1-akkun11.open@gmail.com?part=3
