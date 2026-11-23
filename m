Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400519;
	b=BM8DqX2snKYg6zyBiVLJMIgE2ri4kFmKdtsyj/1YGPE1F/gxQpjgZP82g+JYtDhmsfkA
	 NEMf38EpOJLNaYGn4vTFjbQlcOpnUTL3SLe2f0LmCH5eR5DtsAMF+5xTuTEVOvA+voaIb
	 O6PoegZDtMru5idqx+ip4kFBcIccINK+2bp/MJssJeoeU0Q1mYGwVKfTqtpzR58kISHDP
	 0ontosgb6Z9x+4ANxDhifkhDFC+anHf8jIhRlQlQexIjtvknHgJgQl+qcRWrsv3oNUN3l
	 BMv9EW/yW4oWKn+Ct4FgzDX5gTfFjPQoB7PynMRzLQMExlvkJHLPxkukMlLN3uGDPqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=7z1Gv8DZqTonL8NQOcCQ3nD5cE9KuQPz8cFsKhy1wzY=;
	b=0C2VPg/8zJC13VzpJlbtU1PfOiRAXdHRSanVyiHGcmhrCLemZyHvm3/Gwu2JoWMfb07V
	 EPg5R9/h8Wn+KG4j1lJ4W8aj8fsfdAZXGlCml0iL0EFLnvMlddASEn+HcdTTaTcWzGnc6
	 mJyf5LlLW3N0LoYHshmay7TPfGYyYbpn42DYp3qja1jwHZC3JOt09ZxZTXADg4LVDlAaF
	 2X02CcE8Bs1ECEZh1DFDZ9kYR2oU6iQnGI7gS21IxVopig7adfu5C8ec5FmYhHuXt0jAA
	 W5qnd8cQQNaSug2pgKcyZ2q0Bi64aG1swoljpJO64ArlxFYCwNPXmlNU/jzMivsXixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHv0Omhg;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC0606A32A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BC0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHv0Omhg
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1460752b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 18:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795400518; x=1796005318; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7z1Gv8DZqTonL8NQOcCQ3nD5cE9KuQPz8cFsKhy1wzY=;
        b=yHv0Omhgz8uWepm7J/4YrQA4APhnXKUUJY3fhjf/LbZ7SaKNPdEn02Ym0b1q/apoOb
         5QEKjfqIsh51rEvbhE+jjyG0Pzh8VjLVan9Hw4hGqe+dDfXUa/IdiyH2aJBqG+NNvr2l
         pyfmQ9KLTN9a1FC+qb4ReEcRVd24C4M2pIPVtMykiIHxAy6QtUhgS/SvC0A6zqH4bYNq
         aV1TaPFrPt2Pior/nRtKwtleJbpebDgws3U1xAvGXLoUFdQEhqYiAkHcnFUmPjOg8uAL
         PUkDeVcUjp2eny49h0Exi16QWNKMwijdZqDMQJ282tBKZaZJFgT4tw476FBNhlHJT6DG
         xa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795400518; x=1796005318;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7z1Gv8DZqTonL8NQOcCQ3nD5cE9KuQPz8cFsKhy1wzY=;
        b=Aatr1PCF2eC1XRkTINqf3bt8oTqd+qVIPNIfRmXHL0NQEZMUju45Ipgtplzzs4504n
         K+g5RTmM/G1g59l8szgGvvLx7dBhL1LdzOW4IFSepX4N6qKnFJUWSdCEGI/a0QezFhYA
         mNDjQPPWZn1Cwc/11UZ+e9Gaws8jVkq0Al4jAT1h/VWmukvOBBiQfiAkBzjoxivOO6qO
         qYXMibq7jgSeFtNtkqNRkQLSZRxjfsHCZC1TRvwu7Rzq6YXdBDuof2npOW/Bfc/RiTxr
         rs6HizpyNMvN9baLs7F1BgK0qUsMc0V4DtWZh3sugIWIy0Eq1c95AiW5Crgh5xzY7YZG
         sC9A==
X-Forwarded-Encrypted: i=1; AL+hErEivwPR+ly1l2T+ewmNgc/7EPtth/T5NLLO2hl+blbOfOOMO02F0qJNkJ77AZkVFv4LShbPTtnoMA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+HkbyjU2gU8zbzyoK5RfYtSK/XFwHTpYmwAlKQzzGcVjbK+ci
	UEPRupSR9kqt3ifhq5WLKnCzlX/WWyowbM7jxla/8PG4Zwq8LJ+AMSAOkSaLaAifxkIoHw==
X-Gm-Gg: AZFdTZemRegj23RY5A9FhWouxR7VHizTVBkovVrSUc54VoyEhk1BWUnYriEhjUhhrDc
	YOi8MjiFSFCbOhK+HNGPBjqYDVYtT8wQSKyX5nvOKv99c/7rrVh1j44SfJB3fMgD61RTla9bwSm
	OX9tzgVLzxzdWZKKy94JGlS/EkiEnKYqSyw3aOv+jPGfOWkTzQlHQ4sjciJJeKIseyAn0vySiTY
	uUZavNqKCTwGRteafJIdjX81muFpdeTixd4rDJNE8G1Q+Zi+VPVczcEGvj3EC0zL2ICkHzf6NS3
	HZAPu2mgkF685ApZDv948yP01OECFxgOVYiikg4Ot7xYTM/16hsc/Vujxp5zUOWF3jE62Ik3fZT
	0KMC4Ngm+ttEcTcNXAxLrbl+vH4veC+eDN2wNiW8VBnEHi8a1UyeoWL0Er/NpxyZTIRVl2aWm4I
	NhFztMyIYguehm+l0d8JvmN+k9aalupbnxL9vebUUfUPKrfa/ZGy2jSR+yJjtBrbjOp+yWaaXNx
	VdqtfJUuYJ7tncPUmPt0zdeU6mjS2VA9ce0bKhL+rexfq9TsZpiG6qPfgzarcFMRF9HgFD9gTDx
	KmToc7PygMr2KYxcgWFihM0D8BCEbVv5BZtO6OWxZ/0JQ0LdjQUc2lGXDaqEEj00ylLb6zNzphd
	+GaX1qFF5SR4qTOhwb92iMMVD
X-Received: by 2002:a05:6a00:181c:b0:8a0:7024:6360 with SMTP id d2e1a72fcca58-8c87b8da4ffmr8880080b3a.19.1795400518398;
        Sun, 22 Nov 2026 18:21:58 -0800 (PST)
Received: from [127.0.1.1] ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm4674426b3a.31.2026.11.22.18.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:21:57 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Rafael J. Wysocki <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Eduardo Valentin <edubezval@gmail.com>, linux-renesas-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Date: Mon, 23 Nov 2026 10:21:46 +0800
Message-ID: <179540050658.417371.12537370024433882605@gmail.com>
In-Reply-To: <20261122140906.GA3898744@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261119062203.GC2300348@ragnatech.se>
 <179508711555.3615492.10674834361832600268@gmail.com>
 <20261119162517.GD2300348@ragnatech.se>
 <179516779969.759914.14349189301325900521@gmail.com>
 <20261122140906.GA3898744@ragnatech.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Niklas,

You are right. I do not have a ready-made reproducer that exercises
rcar_thermal_remove() on the actual driver. The 17-check test exercises
workqueue and shared-IRQ primitives; it does not show the original driver
failing or the patch fixing the race.

I should have made that distinction clearer, rather than suggesting more
thermal-load experiments. I will keep v3 on hold. If I can put together a
test-only instrumentation patch that forces the relevant interleaving in the
driver's removal path, I will share that for review before asking you to run
anything on your board.

Thanks again for offering to help test it.

Yaohan
