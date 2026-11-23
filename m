Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467733;
	b=qd4o1C5R19jU3H+T2KhYZmp2Fs0WAXz/nNrugsy82RfuasGXWdbcr1ymDUUTfhIIlfLo
	 jLh3lOV/klo2ExWaDjQ+h1M/d5Gt8sSHhCnhsGlVfmZM2fylhr12xFJi1IljcgADCGjXU
	 OXgLGQKY5S5W8XUpxnId5YrYpxPEsn/pSeJwD7CI0YpaOT1XnAM43YtYOd9C0jpRy/KWe
	 0Ftof+RFjTRPsjCm86aVWMFa/gsHu82TmTmLTkox5cNdOxdO5JTRzUrlHzaBE08KTcH1Q
	 tEeW1IQdag9PZ/Fo07+LV8nQ1Kz5ID1BtAmUjR09uf00VRq/i9xt3w8Nei/L1J8c+kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467733;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=7mbRpKt5qgMfbudS9/dBlgv6EAVjWDxzRq190Nmdkz4=;
	b=QGlczabo5rE0s7vU75hW02uw4Fat4Pfb5lvFdCKYrPRR/9E4EdSYxn+s1t+l2tgEhDf8
	 popUlW7mmvlZDTEpjQwZcxAYpSJAKQhOMAsvdGYDXoZvEktJq6IavY6cZDGzfeWhrMe/Y
	 09fIyhFH0kwRZtNXVMi6w5w0g323JaebX6Qwe2GigUa4hwovb3MtDRKfFkozn8yHTfGED
	 XlQ/2PTpQI+FsxcGhkfbSOYeCYIVm3OJFzXBRq55jsP5xKsioZfC7Cjzgd3FkFANx3reU
	 lh64V+uau9rsvFzpVF8NjGjRB7rNjFiCzBjHH5CeDbJ46+ChPpThVyXsOwRoIDncMUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=FIpJlcjN;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785B606A31E;
	Mon, 23 Nov 2026 21:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8785B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=FIpJlcjN
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7473A1D801AE;
	Mon, 23 Nov 2026 22:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795467724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7mbRpKt5qgMfbudS9/dBlgv6EAVjWDxzRq190Nmdkz4=;
	b=FIpJlcjNirMAc25H6URYKel8maJPcdRfZnHAIRlQgecz/w0ihOPxBpcpNF5rSsd2vOsvCP
	Czzvb+4u1Ut7Eo36m726E8zoBNB4whI9g4tUGRCGjsTv1WN9oW6cdMneeTplrYVzSk2yKc
	hny65V1xQ0MpqopOnfHv/s0jisH8H5ClpH3mnATAvZIDaSLWbx0VrHlsxP1Smi7pxgr0v4
	m5DafjIUsbP0amR/yhzl+W5V1Jl+wiA8MERMhm7aA5uhN5Of6+lpHFxZd6rmqD0yNI/aaq
	57yd58hrtgjKQkpGRNgOO7D71xCqx4J1nTarqYb8zW18PDwgQszQXWu3elBBAA==
From: Michael Auer <mick@yoxcu.de>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Georgi Djakov <djakov@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: qcom: bcm-voter: Clear the ALC vote left by the bootloader
Date: Mon, 23 Nov 2026 22:01:44 +0100
Message-ID: <20261123210146.1465862-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b11d2e6b-8802-4450-8eb1-7984034d5c4e@oss.qualcomm.com>
References: <20261120122152.198114-1-mick@yoxcu.de> <6e30e65c-3fa7-409c-90da-2740f7bf0a24@yoxcu.de> <b11d2e6b-8802-4450-8eb1-7984034d5c4e@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Konrad,

> I was hoping you would test my suggestion before sending it out..

I did run it: the numbers in the commit message are from your code on
the OnePlus 6. What I only saw after the review is that just the
active-only write had an effect.

> My agent suggests that changing this to use rpmh_write_batch() as
> these aren't cached and should achieve the desired outcome, please
> explore that

For sleep and wake, rpmh_write_batch() also only queues the request,
on ctrlr->batch_cache, until rpmh_flush(). It skips the sleep == wake
check, but qcom_icc_bcm_voter_commit() calls rpmh_invalidate() on
every commit, and that frees the whole batch_cache.

I tried it on the OnePlus 6, with all three ALC votes sent through
rpmh_write_batch() and a debug print in rpmh.c: both ALC batches were
queued at probe and freed by rpmh_invalidate() 2 ms later, at the
first icc commit. They never reached rpmh_flush(), and after suspend
the vote was still the active-only (12, 0), as with v2. So ALC would
have to be added to the wake and sleep batches of every commit.

Also, a (0, 0) wake vote that reaches the hardware would turn ALC off
after the first resume.

rpmh_invalidate() does not touch the rpmh_write() cache, so I tested a
smaller change: active-only (12, 0) and sleep (0, 0) with rpmh_write(),
and no wake write. The active write also sets the cached wake value,
so the sleep and wake values differ and rpmh_flush() programs both.

On the OnePlus 6 the rpmh cache now has ALC at sleep (0, 0) and wake
(12, 0), and rpmh_flush() no longer skips it. The APPS DRV vote reads
(12, 0) after boot and again after 16 suspends. In a 25 minute suspend
test the SoC was in CX collapse for 86 % of the suspended time, the
same as with v2.

If that is what you meant, I will send it as v3.

Thanks,
Michael
