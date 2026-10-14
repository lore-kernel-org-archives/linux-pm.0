Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB9568FC4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999434; cv=none; b=dhI5r9NwefmokWiWF+R28s/JTXu5y/solYKQZXGxsWJG/BxYAJNXggfMipvqdrtjcj6bH2oTMVEeXt21M//Ush2BvbDw5NKxXuzQCp/5D0MiK6oqJckAEK9lHWmv3vjhnWs8WYuDPdW8sUkohge/xP+5A4bVv4gcgtW3gK0uxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999434; c=relaxed/simple;
	bh=1SMkCRdoRBjsVsaziVaYOSodTI9Wuhxzjm5gPl7Eyl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1lk+XFXiDqanAXf2eHkFcM7yYSW5qYz1pNTfeqMIlgQXPTs/XIbf668crGFOMXPg71hJ4hlkY7tY8Z26cypYwu8vBNANi4AXGhYrqEO2fdu2D4KDmCdj0xXZtrs8ZeOdF5QtkD8XlI+DpfrTyJjAAPPcDFlxYyljGoq0Aw3FCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SMnSFhyI; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SMnSFhyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791999423; x=1792258623;
	bh=1SMkCRdoRBjsVsaziVaYOSodTI9Wuhxzjm5gPl7Eyl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SMnSFhyIe/OfLXxkudufl0RBJLr/RdIpESooK5QhQ+EmSj1KDzZ6WDwnRYhbOF4CI
	 mDfNAGpLK+rxN+2vxVSzJo34qmNk93F4fb0MEzgfuWAb7k1cLPvKFAU7bUEBcXT7o0
	 E89mw8C0j1uI4Yv0merA3GiHvFQf94KMarc4jYlTQU8XnoiM7NojmkLc5zGYmG33iD
	 PF0SoqCeSVAXldz3nA1ogy6jeIbQVni33zbo7SrYjtnOahAjA6pxROWk/MLYIoVK2z
	 iOLxYwBK3GSQpLglWw42DfcQC43lDF38+FSXxeuhVSHKtn7irw9ogZ1afa2/e2KNyT
	 pK8OEVgkW3icg==
Date: Wed, 14 Oct 2026 17:36:59 +0000
To: Vladyslav Tymoshchuk <tvlad744@gmail.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Message-ID: <179199941686.68860.2209253288195283916@pm.me>
In-Reply-To: <20261014162025.3733-1-tvlad744@gmail.com>
References: <179163212446.46972.2306254853726299632@pm.me> <20261014162025.3733-1-tvlad744@gmail.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 6a2bf6aea44a9d005d91d109720fda8945066e41
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Vladyslav,

On Wed, 14 Oct 2026 19:20:24 +0300, Vladyslav Tymoshchuk wrote:
> Would you fold this into a v2? I am happy to test it on this board and
> give my Tested-by there.

Yes, and thanks for the second trigger and the numbers.

I ran your quick power cycle on the Yoga Slim 7x (WCN7850) with
v7.3-rc7, ten cycles per module, power on 1 s after the power off and a
scan after each. All of them pass here, with the stock module too, so
this board does not show the failure. It does show the stale state.
Right after the power off, debugfs reads tx_ibs_state=3D2 and
rx_ibs_state=3D1 with the stock module, and 0 and 0 with v1 and with your
version. Your version also builds without warnings (W=3D1) on today's
bluetooth-next.

v2 takes your code, describes the AWAKE trigger next to the WAKING one,
and carries Fixes: 3e4be65eb82c and Cc: stable. The code is yours, so I
will add you as Co-developed-by, which needs your Signed-off-by. Reply
with it and it goes in above mine.

Birk

