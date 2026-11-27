Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=106.10.242.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804963;
	b=jFggjN1gawi0UzgFq9sRNLXTY3CTnNLJDWNhzVFR6e0FzMfBbCWfQLciChN0GP9XSLIe
	 QVutm57jz1/HKRlMC+hdICH8VlT10HkXvWafb7lNPVpX/5oAb+3lnKDXRc/FvPdQy85e4
	 u/7en0LceZGOY/j7nX8OgFNV5jHhUFfkedydy2P9blqa45zFcIcK9imB560UZQjU9fjLW
	 b32tE9h5pxNJV28Ns0T1HkFxh9Waeoh1cBthdpIVkpGgBf/kzySSIBBYe5nPAh77deaIW
	 QPbC27gpVICNG1ewEPW5NY3eO2m6aEyUPvj3yVNNu560KuDAA43qE2VokhW5HaUFyYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804963;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=faDONGWkfAuDNx7cFOlN96ZgR+Ck6XywIVc0ff0uZlQ=;
	b=pUOUMf1rnXpvFg3uogLBm4KeLANOTivyOVk7MXbhSuOA9Xi+KPt88Gg7F/aWqKzlyaA/
	 qaYGzQhgBmoHoB0PwBBBzfw6QRhtE2C0srg77S8b6WPGLVhlDGC980f7M6567MhvPrB11
	 k5KCRyHUEF8MiIKBdbPCiPJCxjakf5jQJ4mRq57RHfccaHdNT8FSxyQBuUUdsMy22X4IA
	 3C5XBMBqJaU3Ln2L86JN0kC10jH56Igqi1F0AnDynr8vLCzauGEHqdb4A+jfUSQPGUkK7
	 Lz7NmTtn2SzakkkjrnlDpOM71WGi2vDU1NJhxI+0OfJilJmRNsjpnUCaFywLzFKHc6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=YClVWdL7;
	arc=none smtp.remote-ip=106.10.242.84
Received: from sonic301-21.consmr.mail.sg3.yahoo.com (sonic301-21.consmr.mail.sg3.yahoo.com [106.10.242.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362960A2605
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 18:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2362960A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=YClVWdL7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795804961; bh=faDONGWkfAuDNx7cFOlN96ZgR+Ck6XywIVc0ff0uZlQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type; b=YClVWdL7Hn/I5dmQ7y8yrFCtifw3ip0YK4mHdd1MymXJfxRpr7/F64kxEU7BxoVS8H/iFGF5Xbk2aOaQAcznjBpHSh/G37krN92ZDY6h+nmp7hgyOgC2PjkoLWNsq1OlaFpUQDP9aK0Ep2I0QJ4i969LjxkDgDmgJNo3cydaIVYmhROR30+IKOumQHrc6/SiaYU/n/17l9VlETp91oKlgqiWWoes3eFutFKlObEU+rqHs0+rncRXR1t7jmZJE4gjvpG8ZJgb9FR1iKbCw+mVmfVrw9Oh1titmygo497ONjLqo8Sv9IC0i3/FsCXE7ITMTK1jAsXXxT22MWduKKaJpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795804961; bh=K4xAHI6e8jdoIkxVMcUseRJumcmRisyuPqzroRQa90H=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XifUCYRe+RWDmyZu4lou6in0MqDBqrIHRq/U9BkGF6IJJrwrLa4c2Ke0P287b8TG7ratbIq+rihkT2FzibrpR1qo21awu1K4aTTN4l9KMLYFV9f4JHJ8587PmCge1aoYgHKrfcjdBDwDqG3PNM05hApbBM3fx4czHDfVzsJJs3oSi3snmGeYELyHnjLmcOtFqeVNgcnlO/In6+lWFTTv61+Avb0Uh4r6COeRJniIUJtwlos3EZYs8i5ZDfcFecqru1I9ecyPzKXRetrNt4aZr3sY87sSOZCS/wo4nNFjKKALkKtgbJu85uvvDgCgZgBAOXbaIScs/uaG9IG58KrUFA==
X-YMail-OSG: yz1Dch4VM1lj_M59J6.2MNSolckKNffvOHSATxmVulkCWd5gKvtnOUEM2HEnPlV
 QDu0_k_Wo3kz1q63k4xclrTGMvtUVlTtv73RZv_JAmAQhcy0Q37GoiDgwrpmHwCat5uRyREtwdlS
 d_Zy2jhRQIiFn7k7nMO7zwbAwjQBMThHyCFzIpPH12JK5uuBwn2IBkoHs46zIwJwZmjJGQhWHQ4E
 c_RIMyZVLFYsVpAvVm85IYCY1DkEVNja0EckyBSIB3kqDr1f.0qSJM_XxmlYFWQD7q3TjgmBbe9b
 Tbp73LJp3SAjJ_rFgbl5dMlLAWlQ0bEHvXJFrvo7jJsJIk.tVMcL_OcomYlYhoBivcVz44vQQ4H4
 QuEzAzV54w4v8AWZ9SCUSSh1S4oFjbasKhwBheDgJ06rhDMJgHyGlMibXc9qenubT9eqcTxWdFdl
 jRQY5KecCFexeBIO3hXS_XVo7IYav9xRv1bgyJwd5FR4i8NLZBJb5BR_lkR.gfsdLcJsJ313_C88
 IshmU9nIG5NC3nVWgpGnKU7mQAYYDIwC26A8WYRi75h6ITA7cLkWITvkLu6ogRkEG9UYgCjGDN.n
 BBF45sriOLwAAkd84Oa4VofKIVmRrmZwIa8Eq.5YgDYqE8ghFRiUPtSAzG302wsGJO12xoTvGaxI
 D5nq1iACMgrohvZLby1LHpRISUgiHBjV6Ai3psoNjKUjY2QvhtnUdcu25Bc9rYrbLYaashfv0Zk0
 ceiDOIG0b1SnOjzrG4z0tnyVb8ckMtSiDrPxSx3.N9tOULqeaSF1eWQ5WYHaR11iJn4v8_nyZ718
 PABr033hWxWirJscO6bdxhzJ..pQL6.5ndxj8jrP.65_KJiUgXfYLh6axLA8cnGCBzIB_d8gPpcR
 zP0XLQmIM9syYjxydaxfRrz6hRsAKXb.8dCFuQdzv_ExLqZoFwPzD9QVeRXZAi2CntSkYSubyoAO
 raITwN_k4isO4u1Eif6XZMa0TzOCyPLQcuNEOTDmgEu5qrU9sODvO92koY1PYK7wuYRfyPXTZdfV
 3MCZutr1GK2YCwhIXuEHtU6RPzekh_Ec6NYEzwX5LcOQd_6VA98nmQysyJ_xzg26ps5M_TcTdOOq
 62.StnZOYdCkWf3wNRVevyQISHEZR5IPZRncYCDaYpdFqKzLu1_GExn7yTKzqo3HiAMrj.csrWCc
 8rjvlo0EqLU7fZbm5re7EhGS6v0vN2l0YS1cb2ulOY0lCO3sLjNneSJX7gWCQna.v3I5WaxAudCC
 IgW3s1FVOxhKt27vTHSIPeA1dLtJZa1vdm8X8KdhYCMgz6FxvGO3_TlhRjMzjs37T.I6goyqEKpz
 KZoYECUzKn8CklZmulBpI5_cAhNoSuN2suz2EiM.NQmI5XlOt2R8aadKM7_AXlrJgOYIqIOzHf4n
 pZV646ybluol_d3WoreqxIKTyOKT_T9enhW6IYrSgXARq581q56l.Nh8jN4Cierg_O3oDAHUtWXt
 zUVgxNy6gjP0LDggh2hspTPwN6wPCf5bRHYqWmcM.bZKF_f2KaGzavJrPbRPXS_AaQbGEGaR7D83
 2a3CDqkql7bHgn3wJgUIbCcxYu_x8AX3T82Rsa0tIYAIOunJeTgvHo986Pkw2iCiLVtTE42qZfT3
 mJcwrCcceZBeI7xYDXo2l3WKxnQhrEL8JXJQCVn0jmU1jELcybuc_zVy8XwoOPGqR9qTJ6yWorEQ
 AuhOcKMgrvtS6L.aGs8ZDNrxj40qIMgffHoZ2ld2OQgpGymWYei7RZtO9xC.NON1Mpk6oe2XCDgz
 Hi7Ad0FFP_4CRPDRklhQGTZwOgEQYuWr.HykrgIByMH2KkDxG_jEs9d0qru2vneESf74iAoVzu.z
 TorxDHLGrtbFsmaaDQEkRqTynfGDZYopUJgtlSaP4bQm8sWAp8sgvw.PJIOkB_XoaEGDvdUy26qD
 xW5wAFiAHv5VMiEO18_6pkb8MVDEQjhRSS1eyFaguOu1iBrzC5maCRoPs17bHnyOLo56UmikHFqC
 IvnZbJ4_4BSmYOWYu9BY4IfQvJUtZN1ZGGpbZH7Wh5AdgPRQOSnzBo8yLltIOfxiotzutQGeEPEA
 vbdGjK0JYZkfIQYRghkYdZwhlpBO0r7PS2P3TO_Zp9GECqCLrgt6dfupgFmqYEFydEMPcwWbXUNO
 46Rs70vU65Q8zgHZyxRF6maRUciGv2B_axv4ntuwZ7NPXTTOGIwjq_0.6Lwm7M_sr7kMezVm9_fn
 OLl5v0Be6P6oshokwUxKmbQpM0fY1r4EYtD9cJjTacTiGmGLXaqD0lQ--
X-Sonic-MF: <venkat.yadlapati@yahoo.com>
X-Sonic-ID: 890b40db-28a4-473a-bd1b-d41a843fdaae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Fri, 27 Nov 2026 18:42:41 +0000
Received: by hermes--production-sg3-5ff9d6888d-5kb5h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e4ab3347475f853fc74f7d143b76b9e6;
          Fri, 27 Nov 2026 18:42:37 +0000 (UTC)
From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: qcom: Don't read back BCMs without an RPMh address
Date: Sat, 28 Nov 2026 00:12:10 +0530
Message-ID: <20261127184218.670679-1-venkat.yadlapati@yahoo.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <8184404e-93f9-42c8-b10c-ccd88c7934cd@oss.qualcomm.com>
References: <20261123-icc-bcm-readback-v2-1-bacee81398e5@yahoo.com> <8184404e-93f9-42c8-b10c-ccd88c7934cd@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 27, 2026 at 12:05:29PM +0100, Konrad Dybcio wrote:
> Well, you made a great case for it being separate!

Thanks. The separate Molokai interconnect driver is out:

https://lore.kernel.org/all/20261128-molokai-icc-v1-0-a5e1754f086d@yahoo.com/

It replaces this patch, so please drop it.

Thanks,
Venkat
