Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B15285CA3
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805108; cv=none; b=C0tUiqpRr+W+YATdd4x6y9D88KGt8pt6M5FJAz9O6PXumOtNRRveKybX6+nGC0U4j4Wa57jW2Jahy0cwc8PKf6fZxS440T54z/8BXWjtVUjmzvuo3xznDV+JgBAUlCY1mYtqjzjQrhdcRcY7q67gElVa3ax4bZMGcNZtbmw1fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805108; c=relaxed/simple;
	bh=uqmFJenA7NvCwu2QwaHJEmPdclY5/2SsSJ0L2gnM1PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFdwwLv0FExdjs6ZuveHDl9kSjM8GK38xNDPu9+D3lwzOvqQTMQlqW8oo3kyOFUdQxJ+s9vicLcdeUj6QDfjt7IBIsPkvdfFhi9XjLDUvQlf/VCRAUBHWLG57yRr6paM+oUhya6dvtb3xTGgyHz92J/Q0Nv5cjVZ7q3HM5eRE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncwipEpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncwipEpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA8DC2BC87
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773805108;
	bh=uqmFJenA7NvCwu2QwaHJEmPdclY5/2SsSJ0L2gnM1PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ncwipEpe5Al3sSvZBvOYtVbbKNx6QanVOKmkJXKUEdVTEb9DnClb+wLWZ77tZTfkI
	 EMruJfzfMv/WkqwM7FMMQet99CBMXt0h72hMWmQV/VuRR1v8sY35DZ64StO6kw8UUx
	 43b0McBfAe6wCdSrHclAtT3owV2TFNvT1poZ9FK2l/NRpyL1L33b0SOb+T9f99QcHk
	 dLwJ4/cBTe0bMTsXEcbB0bNJxdJrh7pOrYFF+KBOp7rNq9HYFPbmOyFkH1s22eVmSl
	 XyNu2ij6GPKqv1cXPedOzsgrYV05RultIfmO1odB9uuD7SCMf8mZD8VgpaGH18i9uJ
	 sKVg28kTov9Zw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6644a3029b3so7840203a12.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 20:38:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzTyiBOQrzVk7iXFFKgo0kqzJoYS4Xz4N9c92mzJ8o1Hf8Ttcga
	p0AIQz48nX7qeRK7fIBG3umsr9KKt3JG02JXiKkxuZp8LkvsWxJoLNusPEfzv0YhHZ+vvnQcgNO
	4CaO/sOGW856yxnq7/x9Cifl/uWnjNEc=
X-Received: by 2002:a17:907:3f9a:b0:b97:a2c4:69ef with SMTP id
 a640c23a62f3a-b97f48040b4mr107104766b.18.1773805106739; Tue, 17 Mar 2026
 20:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311090035.169539-1-dedekind1@gmail.com> <20260311090035.169539-3-dedekind1@gmail.com>
In-Reply-To: <20260311090035.169539-3-dedekind1@gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 17 Mar 2026 23:38:15 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkjJuqPK0=T0DhT_0FePK42cqdJ2xTo1TgG-hco8Ecp3Q@mail.gmail.com>
X-Gm-Features: AaiRm51YMts2R8l1XoiNk0ZyVc_S2Sq7Orco4lRuEOPoP3M0JXnx7NAakalZKpc
Message-ID: <CAJvTdKkjJuqPK0=T0DhT_0FePK42cqdJ2xTo1TgG-hco8Ecp3Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] tools/power turbostat: fix incorrect format variable
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Applied, thanks!

Len Brown, Intel Open Source Technology Center
