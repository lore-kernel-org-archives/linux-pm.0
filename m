Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793952002;
	b=T1saQuregqKO0DfzKmOnP1ZolGIgHj3u2MrKCBDK+gcZq1vaRQs8M+Ew74S5MLGPUJWd
	 ONGJcSta/x7tpW5ySBKxyA4QkQI64MMePLnDMQVomodRjGJiyRKFuvcVlqX2v3YF0zNox
	 bfJ3JEit650oEJZmp3jhjBHxxoApCrPZdE4vi+CBeC3fO2hqJZcDKpqSbg+O918P9+RKp
	 AZAYKcopy6JsGHjKKRIW7L9VhgEFec9MDZT6G1FIkaUWzoRdaeDTRll98Kmw1gLbq6Yut
	 p6qWU5FpS0sH4762xPOgdky0hzHjhgI09U7Y19dOhyeXZ/08dhQuyVLsotTHjkgfXWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
	b=CCWlS5i3MBmcd3CjESI3C+9m4vtpDpx05OZ2/oJGyM6ZOvSIntDKKaA5+h2ABERdIf5m
	 D05xm9XB7Qzt/ziJJkmDXWH82Xplcb7n+touuUR8xoFFneb4hdfbYS8/T+VZEIwTIXb+7
	 AFQOo67nhBAJIOnK9h7PnVjsc8NQpfgadjypOPDLy2OovrCkHSSGPuyjWQ4We9gX4HTFt
	 o0yWqHZt2uqcTpk/HTDjZ+TYuW07cUPIe5MdDEBv5sZcvX9QOnO+bXqohBghy+rc73+I/
	 KSmwGi6RMsNuYKp2cYvYn8yzRe4zwO2h7KL7w8d51arHo23JEkGSHmihw0ESV5S12gA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZn45ghf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3B608361F
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 08:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D3B608361F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZn45ghf
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b6e8b6d424so84664a12.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 00:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793952000; cv=none;
        d=google.com; s=arc-20260327;
        b=m0bMRK2ZmOH0ZwgEUy+dCTiMQ85JCAnNRC4AHzcR+hTnxxZTvk37jYBINdo2FxCCXl
         iW8BYB2INRPx5TURY8EIgc0FswcTS5ARwKV+CQfG2GSHCOt7lE9myESsVtz7an5o7fAK
         rROlA33jTT27JcW18pLV1vrOFPsHy7pAGWHJMAGqIrc/zGQAH8Fgc3jvuSl14yHEkMu9
         cmyzQ+07BTD8POQEIVQ/uA1jeZg5bISeVzveDvnanHcqStOAK62XpgBfAPCFHHUl9eVX
         NR+sSEnPcKAj8NrFHWt00JXGpvvV7PMgfmQW622DBM1W0Tq072BxBZuH4DTVtk43wGmN
         UhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
        fh=GiIHkrnW/BTiZJOi0exEHJZdV/NjAaP+mmHn2esWqpM=;
        b=AFFp78kchyqNZ0nrNutygGCNs/bvVa1CMt6QyUwNXUnHZNKZ2X6ldrTd6ca63ysrBP
         6TphTegsYtVHVKVD9K6oKsvebCIyZ1RYvzb4Z6ZgRC46Maf2laNrDLtvDg8ROscayyOJ
         ULrpIcYQOD1abtMwKGkVywsZes6oKq8unYFlv1wFqRlLaDpTVYvJMgYmQqdEy8eAp4zo
         XtwoqXgxjE5CI3qnF+1nL7zIUciQIanXCIx10BcENMC1RKEsUAfEwc+YmcgQ47/UIgFf
         wl6Yt7lAT0GOhXpQkz/YEEaD3lt54qm/HW1KZ/P4o2UPMKvFzgtTkf+GOpdjiZXGipMa
         gGPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793952000; x=1794556800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
        b=NZn45ghfBG0ZvdDOyynp1nFEfObT1pcptC1zoQJVefkfah5Cvf4KhBdfAtP45zAtAQ
         UULmHj0hEPtCZn15bvzalYNRj9fhdp3uyVdEClRuRLkVnpOfV9ppeglAAdfxPS28qNaw
         O+q0E4sjEMKTMoFNcQUz67xVF3I/KdEzY8yg+Tpd2afhiQuFsmYUaFLtm5Ti/Cv1nQCD
         bntrz8dBI8l+pN19cS/mEKfoLl4E98jrhkuxDF+X3o30Z7L31Q/ieTJQlTrfBLk9dFV/
         5CptV3jFVboDZT6yTQgUn6wxAwHGSAsVVrnPYMvRpyNWRmRF2c+DpLESNG1RwdqVq9wY
         I3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952000; x=1794556800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
        b=epAbp/g4Rfyyy8TfTwlMct74/Y7KaC8zVI1xGOT+u8sw8Bchyzm4v3yBhIixvqSTeX
         yanjmllc+Pb2w4jP//taiNDwPrfxuqZv5g2vqK1QjILAEh08Js4F/F0YX75zDSaN2Z9M
         XfMjpcArRaqvfZkEWzVzNC/uhNQGaDaM38JScpE+zMTIG9dZZ+CPZH0jYrnHr0Kk5LK2
         BFKc9EhCK6WAsvGDKxNkSJgvy2F91Mr9xLEupRRN0QAxwgQtlUPcINHAjlkelaIs9zoZ
         ri46o4lJcvxCxu3XpaN+jSi9mpVkNo7gU7s8C4ckEmh1NqC9GHq4aawFpJQtPFVcK6Ze
         rK8w==
X-Forwarded-Encrypted: i=1; AKwUvBwuH7uigvKczRNJZJvhZezyQXOMrXVey+Dt0SSErvnR0xQPJQmt/PQc1Tx+Dr1eDqN3CGH8U1zh6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9Lo4EmCV0uvHHU3hCwxGQH+fpgWPnXFczXjrVraP2XxhxykXm
	xRCp4xvBFqgsHyJQDP3TcfUGljfpYb2H/XxZlM3xhx6hfpC4exorFw/DLWjORH3ayoSRAiKkLPv
	ex8n8EK+da3cZnlM/lzyh7NwA4ViKlao=
X-Gm-Gg: AYBFou1rjBTB24aNnh4vBQLX0vCTyNtmb7NP5NeW37+P8wfraayySQNNupDAkZnZv1K
	vNSq1LK5kMYzsjNY1AupFyB4XUI/O5xl1izWtN+K/3RjBQRVc9NGUbukeEE9gzt4G+F98zGt0Ah
	hmI3nYuM19SmqmB/i4w3P/0dLtt1Him2CfaUsG8pBu9LnW33WBKXob2Wkzq4VtKYhCxWnUhTdYM
	E55OzN9frxIhqOyH7u+Yibo96rhFeikNd628VgX4E1S6Z4c8KWq3JskmT3kD5aBkBoV1rwHFM59
	bIMaIQbbUAqYAZky7Fftwf0sjGhyFEc8NDUxna5D77gczDmcLl9VhrkSEQE+nt0U7eIIFqXyn7q
	Fs5bBz+u1ACAxdcvBCm9uXYJh4IeLdi5/G8jRXVwwbHH+ggg7sq7udm/0
X-Received: by 2002:a05:6402:440b:b0:6b5:9849:e335 with SMTP id
 4fb4d7f45d1cf-6b5985927b4mr1117288a12.1.1793952000065; Fri, 06 Nov 2026
 00:00:00 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021105109.199886-1-l.scorcia@gmail.com> <20261103150936.GB792264@google.com>
In-Reply-To: <20261103150936.GB792264@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Fri, 6 Nov 2026 08:59:48 +0100
X-Gm-Features: AclHuK_yxwIK0Nk7bFmyEO_n6HuxXT4AJJgazikzKXrXwadabrKuwJfTV_QGR20
Message-ID: <CAORyz2J_J0dYtg2BMKq9cuzo7U0j-cMQoFXn+2pOTztHz8dS-g@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> How many more Acks do you need now?

Still missing acks for the regulator and pinctrl device. Yesterday I
sent v12 of the series [1], rebased on v7.1-rc4.
Thank you

[1] https://lore.kernel.org/linux-mediatek/20261105194426.1113050-1-l.scorcia@gmail.com/
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
