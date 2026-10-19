Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3C3A7193;
	Mon, 19 Oct 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393327; cv=none; b=dZg8Is2DUA2987e8lfxNdf24pg2a+kmkB6+Nj0ecx5PLI2KYJwJuNJ5FnkFfE6vlWX0blvwGLFYh4C7KkMX9bJLgp8217MWNJRO+SMV+S9s0OFfaWxGCImBtde2T68DR78Fsf67Uo82HZiLlnbzi1NjppsEQT7yHmz5dCmO86EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393327; c=relaxed/simple;
	bh=IWJHYQT5csf1bfxQNDgJxGfQE4utAXU++e6Y38iDegs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2D8a3Udmi32XasK3Xqvdyz5xj4kjMgy9AJ+JeiPiK0coXJpAohbL2vFOR+FxLvwLHNpaljFfwApSJZwnPfgc+QTLZqR1BeKdALW2QaY/tiJS3FW9nOj3JnlEAVIFTerg/aDHffrOSTUVf06TFzVn/yrHj7PeLG6rZ+nUnqvlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=D86rDiSK; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="D86rDiSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1792393322; x=1792998122;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=jFT100uFamP5A1+7t6kGUO077SA2VYn6gbrf7ueKwUk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D86rDiSK53/c8EqF8EV5bBNI94+AELUVcujuucYh5wfEs+ixHbLXss3b+tzBjeTe
	 kYN3GlLqrJExRRCGqBV0KZse0JE8KHQ4J3+Zz2U7J8iL6yxrBsFxQ/hqTMUDJZBVE
	 jHdlgoCMkto4deqgXphL/KSe2MXAGduckHVTq5GnlsdYTiGHFyLFxXcxBV0eNTEQo
	 Kl2eD09nZ8J3oy9Gg9duy6LleEGmuUn1asCYmtXrKEFREGOem0mOIDcyYwbZwhbco
	 I72c/CMH4jyWjhPhmH0aekMvPfhv1oO29D2sbBs01MYVLOAY7xMpSIJPyEeMcuzLE
	 GExRgoyuG+bbydOYXw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mzydy-1wMrLN0CZi-0130v9; Mon, 19
 Oct 2026 08:56:07 +0200
Message-ID: <40a18909-4a96-4bfd-924a-c62658f26de9@oldschoolsolutions.biz>
Date: Mon, 19 Oct 2026 08:56:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: implement sync_state support
To: Brian Masney <bmasney@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Xuyang Dong <dongxuyang@eswincomputing.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cUfu78x5LyhcERPtQ6iwVQ5kI6C3XoSd1pBuP6ROLgNSa4/agon
 FvZ0YKQO6mfr/Sg7+0bu9OskZeYf2YuUxDfo6uq8TiQWFoLDehyThCJYfmz+gVN4Cse07aN
 28sr3qdO9jnKUq57QZ30FZG6Nex4llIVlER07gNrWsUKGLTDGzzzBTP8oAE4PFTQhn+eywg
 lVcgRDQMkot7htJGzZY+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3BQIcOkyU9E=;1VRc6H53xJxw7cN2b6FIjo5a0yq
 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
 ZCqqQJCvVFkXzZtIM8iD9KEKA3R+jmnWdFXTQ==

Hi there,

On 6/26/26 18:32, Brian Masney wrote:
> The existing support for disabling unused clks runs in the late initcall
> stage, and it has been known for a long time that this is broken since
> it runs too early in the boot up process. It doesn't work for kernel
> modules, and it also doesn't work if all of the consumers haven't fully
> probed yet. Folks have long recommended to boot certain platforms with
> clk_ignore_unused to work around issues with disabling unused clks.
>
> This series fixes this by adding support for sync_state to the clk
> subsystem.
>
> Changes in v3:
> - Allow multiple sync_state callbacks in the driver core via a new
>    helper dev_add_sync_state(). This allows dropping changes to the QC
>    drivers that already have a sync_state callback since everything can
>    coexist without changes. This also makes it so that this can coexist
>    with the pmdomain subsystem.
> - Only show "clk: Not disabling unused clocks" message once.
> - Add Tested-by from Neil and Xuyang
> - Link to v2: https://lore.kernel.org/linux-clk/20260616-clk-sync-state-=
v2-0-15f82c64d95c@redhat.com/
>
> Changes in v2:
> - Split out clk-cbf-8996.c into it's own patch, and don't call
>    qcom_cc_sync_state().
> - Clarify comment above call to dev_set_drv_sync_state() about
>    the -EBUSY.
> - Added Tested-by from Jens
> - Link to v1: https://lore.kernel.org/r/20260603-clk-sync-state-v1-0-457=
120eed200@redhat.com
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> Brian Masney (4):
>        driver: core: introduce dev_add_sync_state()
>        pmdomain: core: migrate to dev_add_sync_state()
>        driver: core: remove dev_set_drv_sync_state()
>        clk: implement sync_state support
>
>   drivers/base/base.h     |  7 +++++
>   drivers/base/core.c     | 29 ++++++++++++++++++
>   drivers/clk/clk.c       | 78 ++++++++++++++++++++++++++++++++++++++++-=
=2D-------
>   drivers/pmdomain/core.c |  4 +--
>   include/linux/clk.h     | 14 +++++++++
>   include/linux/device.h  | 21 +++++++------
>   6 files changed, 127 insertions(+), 26 deletions(-)
> ---
> base-commit: 6c94b38b83a04c43ea49004275f0391404051093
> change-id: 20260626-clk-sync-state-ad008829a689
>
> Best regards,

Tested the whole series on several sc8280xp and x1 devices. Appears to=20
work well.

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

with best regards

Jens

