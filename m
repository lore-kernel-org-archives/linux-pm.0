Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955289;
	b=a2yza6Bthmov8qLRSDDazVsYg8/AVE+B9w3EqbPhujSdIujOW9KcngF1qCOQCKZHsDdX
	 FfpWU6Tpjiwo0XVoEBpyubHHi48XdkzSXx+N7FmDIVJBn9jMMDgoMsZDmBrlRDoPjEUCk
	 /u1cD1p9VcI4vsljZwa0cJ4FiVoVurmQI05hAc1TffSxEwk6dACWodF8TQPHY7DUkjrJq
	 K/0sUvIwz0d3cZJMcHAh5xgYTOJIsz9gF/zYU30CXWD0PtwMx2EZFJsdfwaZYxXQu5IBM
	 T+iMHXp88jXYiqAvDJsHUCFbO68PPzG/Nvc+npepvnseTFk5dPWqXtgRjn1wskxanBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955289;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=k8zF43mIns+8zEDRRffV7DY3yvSKsxnAizK8HjEE27Q=;
	b=1DpED+2VG0lPu50lCuy6Qp29uZ7LCWq4T03p+iw1b7ytrNmEZM6VsYsuVX7RZEZK1LSm
	 dGBSRgb6BiUQ593uFqx9ckbVAJNXQTYHFm5iF9OQPFEmVuHdhFQGurpu9Ulwf0lOdGOFu
	 JQyjz/neQp5OVb+SnOkmDtHgYmjQtku7oxZnw4Txk3hVEaK/G+eItrgOltF0DnHiPoLOn
	 sKma73hr+6WLRAiwYt5T/e7rhvJ2aJrnUzd/MrRkA0sSy4sHo/tfZhu/egTCbGfYS4eUg
	 ZrADV/NWJffxFeXwSqda/0XIBVBgRqvntYePLyKwLs6DFsbPig9KZ60HE7JZ8ScBz4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sverdlin.org;
	spf=pass smtp.mailfrom=sverdlin.org;
	dkim=pass header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=rCJOHU7l;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=Mqkqmao+;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DB606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 040DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=rCJOHU7l;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=Mqkqmao+
DKIM-Signature: a=rsa-sha256; b=rCJOHU7lbbHLruFIsMUQa8wjDMxuF/FoTcJzOOvjskDc7W8cg2OEzOMvcfXInGpfxRfnjbTmciON0ZQLRqVGweVLoIn9NwPoVTusytvLD3bjiyNW3fMgxfRcQZEGjdIT+Cys9Jj2xp0G9KgxXtIZXiN/1tKfisU23G/9ZIbKZqNTkg2MOo3FYhktxBwOu4rYq4y/EXzeAMf+ax4DeQaRrcJjk3nXBxetlTvROEcqEXs+JyCpyRSZpdGAmGI+3um9IshpuiTz3zpyPLbObmi+9sh2J2Js8YyL1VQWJKrsS8of2UitJztbF/VjOXKBejmkAw2eUIEqvBxarWW1v/D4Vg==; s=purelymail1; d=sverdlin.org; v=1; bh=k8zF43mIns+8zEDRRffV7DY3yvSKsxnAizK8HjEE27Q=; h=Received:Message-ID:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=Mqkqmao+KKtBnHFFrr50faPe+FAxgu37V08wpEDeAbMO5xi5oLs5HjOwuqMwwysTRywY38/qqZ8dM932q/FmHanM20DyaVHgqjz78xZlgRFsH4i6u0MI1THUmMdQwDPngEmO2h230ij2JNDtabCd8KlgcChTJp2FMpse/1Zu2pu3lpx4fMo1oQntm6fdZvFmnV2eIUXdUoBhwYxT5smC3k5fhpiAdQqaPN5ICk28dwWEnGECdEWOHcAVYvjT2t+dj3WqYWspgWGh6755qnyAUJlIP31DXXC3YiDevTZB/c8BT5vfUL63+Hps0VHsEtojabSwCr2SQRGssEIeQ25kQg==; s=purelymail1; d=purelymail.com; v=1; bh=k8zF43mIns+8zEDRRffV7DY3yvSKsxnAizK8HjEE27Q=; h=Feedback-ID:Received:Message-ID:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -294462679;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Nov 2026 22:41:24 +0000 (UTC)
Message-ID: <a11b490c84234b7c37d314e3cfa93434566e221e.camel@sverdlin.org>
Subject: Re: [PATCH 1/6] dt-bindings: opp: h6: Add A133 operating points
From: Alexander Sverdlin <alex@sverdlin.org>
To: rajanyadav0307@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Tue, 17 Nov 2026 23:41:12 +0100
In-Reply-To: <20261104-a133-series-v1-1-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
	 <20261104-a133-series-v1-1-58217cb33a87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Rajan!

On Wed, 2026-11-04 at 22:40 -0600, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
>=20
> The vendor BSP for the A100/A133 family (sun50iw10) selects the CPU
> speed grade from four efuse fields and the die revision: the speed bin
> (SID offset 0x1c, which also holds the ICPU current), the chip marking
> ID (0x00), a value programmed at production that the BSP calls PCPU
> (0x20) and a bin extension bit (0x28). It knows 11 grades, a0-a6 and
> b0-b3. The A100 operating points describe only three speed bins, taken
> from 0x1c.
>=20
> Add allwinner,sun50i-a133-operating-points for this. In its tables the
> N of opp-microvolt-speedN is the vendor grade: 0-5 are a0-a5 (a6 has
> the same OPPs and voltages as a5) and 6-9 are b0-b3. The four cells are
> named, with the speed bin first. The meaning of the PCPU field is not
> documented; the name follows the vendor BSP.
>=20
> Indices 0-2 are the vendor grades a0-a2, which have the voltages of the
> three A100 speed bins. So allwinner,sun50i-a100-operating-points is a
> valid fallback: software that knows only the A100 compatible reads the
> first cell, selects one of speed0-2 with the A100 rule and gets the
> OPPs and voltages of the A100 table today, with 1008 instead of
> 1080 MHz. That is the A100 selection, not the vendor's; the new
> compatible adds the vendor's. The binding requires indices 0-2 to stay
> usable this way.
>=20
> The new compatible is SoC specific, like the root compatible
> allwinner,sun50i-a133; the A100 compatible stays as it is for existing
> DTBs. The schema now also limits the other compatibles to the single
> unnamed cell that all in-tree users have.
>=20
> Claude Code (Anthropic) drafted this change and its message from the
> vendor BSP sources (field layout and numbers only, no code copied); I
> reviewed it and checked it with dt_binding_check and dtbs_check.
>=20
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

Ran dtbs_check on it,

Tested-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0.../opp/allwinner,sun50i-h6-operating-points.yaml=C2=A0 | 94 ++++++=
++++++++++++++--
> =C2=A01 file changed, 86 insertions(+), 8 deletions(-)
