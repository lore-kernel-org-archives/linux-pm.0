Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938E27991A
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805088; cv=none; b=CXUCOjV1VSkZ9wUMMUXvnea2L0td06bjpXdtq53xz8f3I67vB197f0tKRK9pdQZ5YGi8dEkfBB5SoA13rT22aJwL4DKycEaVr8GkiCMCcNloZyhAeLfHD8FeEK+etTWY2jQ0BfEDHlYL94MShlBmbaiP2OzVHgMhlPMv9+3myOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805088; c=relaxed/simple;
	bh=uqmFJenA7NvCwu2QwaHJEmPdclY5/2SsSJ0L2gnM1PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbmbO2cz6yKlljH76oCV1Ab7o04ZTjVlj1lz4cOUHCYQNMrkmQkYigy0tzzokhgYO4aw3Spo+dKpiapDCdqMzsQGcVqr9rdXAqGNoJvEltLrTR+kAwGpys1eQrfaYhw0dhyr8nK0O/h/kC6/jVEZCQ2felWSwrPZVc9AnVQqCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS/VE6XN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS/VE6XN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3304C2BC87
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773805088;
	bh=uqmFJenA7NvCwu2QwaHJEmPdclY5/2SsSJ0L2gnM1PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QS/VE6XNMWK641ISU9t4QDTfQr11PbmQRyk2xjFJfjzRAFMxDDNud/Gs0jEbLCqaw
	 UgabrY/xoXHyBwNneU+nr0TIzsdxsvfGrSNpSkB/NHUwnsyUC6iyW3EzEQY3lGjXAh
	 1AOcogq1z3/QUdlmU7mPcNXcMMXVzGav0kW7vAoQZeqgoSX7iZd4mDc62tkYwddhe8
	 G3FYwbFkSLwbawsEbxakvUD+aK0/oPYHgr/W8mz6qYdR8APG1N2/vUn5Y3clSgDvg7
	 8/XJuMgqyfIa64vTh0tcqLq1bpMz0XiYMX47+Qt7uf4CJmKeQld2szSzczlaQ5+JR4
	 9ZMBn4ZyWurJA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso9447075a12.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 20:38:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrAUCq+Eb9jMmGe5lpGY/XFmpJsKGyaSq65Ues1s1XJqk1KTCu
	BIRcxW1+L15okaUpDaNOXEsYahcnXj3Co7tRfgVKzLVCPbBNM3YAVZv5idhW6FPO3R/uFPuytEy
	8JrC8yetMlyYg2imuXV26MBPdvvEsScI=
X-Received: by 2002:a05:6402:268c:b0:667:5336:6b86 with SMTP id
 4fb4d7f45d1cf-667b18806c2mr1263900a12.5.1773805087529; Tue, 17 Mar 2026
 20:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311090035.169539-1-dedekind1@gmail.com> <20260311090035.169539-2-dedekind1@gmail.com>
In-Reply-To: <20260311090035.169539-2-dedekind1@gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 17 Mar 2026 23:37:56 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkxH=ZUPAtYzGQFDSf5hReC1sVO57iaiqTH9L-bbEC_7A@mail.gmail.com>
X-Gm-Features: AaiRm50K2GRno4MzVkY8TZRk_GZaw7s_j2wm_5-J2U9XpxGXMI_sOtlJ-9prNpc
Message-ID: <CAJvTdKkxH=ZUPAtYzGQFDSf5hReC1sVO57iaiqTH9L-bbEC_7A@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools/power turbostat: add missing print_float_value()
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Applied, thanks!

Len Brown, Intel Open Source Technology Center
