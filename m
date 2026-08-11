Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF32DA76C;
	Tue, 11 Aug 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454130; cv=none; b=X5NLCFlISCd48+A9X3cOOPScaU5qevbi9qt+0hRjacsDETzE/QBZ5HP/+7iniTGBrsOxmfGlPAFAC0f9suBkibSgXsfJqY2PSSnJfWVa/a6DMUk+Hy9bLkmN3OTVl2k/blRqPEm4ZFPx57ZMNMxsYgG4h7QjGOhswvBcy6a7CWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454130; c=relaxed/simple;
	bh=SXOPRjZQM4pScckGq9bwaC9u0DfjZxxpMyykPiUOkVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBdR/MG90BgTiLdPlpl8qpdjY0wrLVHlozgofJFLsbRwzI6mHi2v2vYPy2pRvSKy5sXwCOHT9fj/RA93okBylEKPM3GPTdJxCxx72ktXDrmYtArerq6LrYRsKcApJ63NTZrKdbGukTL4YTQfDDgNF9BxyVRwNkYdgz5mAXJT0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vwFDU2Qb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vwFDU2Qb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5DC531A1571;
	Tue, 11 Aug 2026 13:15:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29A4C6033C;
	Tue, 11 Aug 2026 13:15:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CCD311C48B99;
	Tue, 11 Aug 2026 15:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786454124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bRZ82HDbU9IPQlf4+zg2AUoG1aZ0G8Q3MCweZre21Cc=;
	b=vwFDU2Qb0BydCRtfwGSxEc45XXGLOcoghon7XMeZBaAw1V0RrFLeUR3KsDzlZ0WEsmo/Py
	zewYgmvo+Wv8cOTEKxKdHiCbdm0wkNl6ZH2tQ3byHnR4cIF9EtCpIFZQ1wdpAYaSxolrB8
	/VFTpA/9Jo7HY330+d7faArjB7y0GIpNZzXdr7TZ7fuApwDYo1PWF0yF1gCSwUFFmB5VXR
	9SOg3krGngGl3S3+JTHI7ijThdA6FHD1L8Eb9x7OyJlcyIP5dgzi6ShwpIG5+61/RLyFlu
	VZGWAdbhPaKn8xLFrPvNJfV5QV6GKa04mg9X10N27C4EFhun5/IkDvb7lYi7Fg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org,  daniel.lezcano@kernel.org,  bblima@usp.br,
  linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org,  kernel test
 robot <lkp@intel.com>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz Luba
 <lukasz.luba@arm.com>
Subject: Re: [PATCH] thermal/drivers/armada: Fix missing bitfields include
In-Reply-To: <20260811094747.2940616-1-daniel.lezcano@kernel.org> (Daniel
	Lezcano's message of "Tue, 11 Aug 2026 11:47:47 +0200")
References: <20260811094747.2940616-1-daniel.lezcano@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 15:15:21 +0200
Message-ID: <87pkzool1y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


On 11/08/2026 at 11:47:47 +02, Daniel Lezcano <daniel.lezcano@oss.qualcomm.=
com> wrote:

> From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>
> Add the missing include leading to the error:
>
> error: implicit declaration of function =E2=80=98FIELD_GET=E2=80=99 [-Wer=
ror=3Dimplicit-function-declaration]
>   184 |                 if (FIELD_GET(MON_FAULT_STATUS_MASK, val) =3D=3D =
MON_FAULT_LVL1_UPR)
>       |                     ^~~~~~~~~
> cc1: all warnings being treated as errors
>
> Fixes: cbe31d5ce498 ("thermal/drivers/armada: Use bitfield and bitmask ma=
cros")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608082242.drjXuzsN-lkp@i=
ntel.com/
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
