Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3853A1CF9
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826004; cv=none; b=f1RwJJdxKjUWlw3RsNFfvIVFXRUCicJr3WyBEVWgK0HCWAwMBk1ygEzJTuZfoaS0ySNzWUvqcpca/3n4U/7JAxbXm9jwDOC6SuIJP6okddQ7uiB0L68DvGQqB+OCzQPhnM9MEP5K7d16fFdxO1aJ8oE4Ti+UhH2bWyT6aOcPQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826004; c=relaxed/simple;
	bh=6zuW4otYsQmxV1GSq43Ub3OPRifF5zI3RsR5eV4DpSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slJjviOz1xuYBeqK9PNFy/59qsgRrG6nBV6lMYI7pIGODBNEomFF6pl7V8prwYbHGzMQ7pOKwY7zHXhc4wYrdqz2HlLaSWtL+oqeWGWPN168x9IWmEQDGcqRQw7YUY0suaw9CagSIutPuCIFa8XWTYDg0gF1n7a77SVWyqpEjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwwGSH0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwwGSH0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B6FC19425
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826004;
	bh=6zuW4otYsQmxV1GSq43Ub3OPRifF5zI3RsR5eV4DpSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MwwGSH0YEYY03UZlDubBrQdvHDUWyInYieG0BBukjnf1HLe1n6UFSUHHvWIaHc2kJ
	 ZdsfFA2wH0s96859L5P92abKPru1jEe2/pkxqhT25n7e27kdTkH6U4eMhTqU+46eAt
	 fhTD4Wbsk3SufTfVYc8LKGZB4WKvXHg6acyFZwmEkdYCJkE08Ra+uOr/JYCcr2k663
	 +Vp2S42vAPPpO90nux3O0ProJknSS4fRwTmNyckRXQ3nFYrzv1L3h/FZuzflAXoEzy
	 tMSxTrLPPDKdxoliNqidDaG/PD/nDzl3/4Cd+bwqOJJYeXREXsVS35DewOfHoJbSKi
	 CcCW8J/a7NMZw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9382e59c0eso361253966b.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 06:00:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxnQ3rHz6IDXxi97VTBoFWOWU9aw9Q07WbuHym5NYvjlX2bopnV
	Huixj9dppYXzC4nFMLBd5P61H6tem6d5cnDpaBKqX5lXDMVcthjFR8kCu4EYyRp8QxxZ1KZtjmr
	/eMq16gMKILaWMuCJjglrgtiTB2EQYsk=
X-Received: by 2002:a17:906:fd87:b0:b9c:24a7:510c with SMTP id
 a640c23a62f3a-b9d7243f583mr206295566b.1.1775826001812; Fri, 10 Apr 2026
 06:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319140307.441950-1-darcari@redhat.com> <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
In-Reply-To: <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 10 Apr 2026 08:59:50 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmepvPzWDM+6s9YERe27H6pSKbDb62yfpTSs57hWsEmRg@mail.gmail.com>
X-Gm-Features: AQROBzBsCAaH9COe9q_WLlUc12dKfgcO8vAGMHlGl2RjqAH23VCGZa3RT6sZqOA
Message-ID: <CAJvTdKmepvPzWDM+6s9YERe27H6pSKbDb62yfpTSs57hWsEmRg@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Allow execution to continue after
 perf_l2_init() failure
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the patch, David, it is helpful.

I agree that turbostat should do its best to run properly when the
underlying kernel
doesn't have full support, and you found a configuration that I missed.

I'd like to understand how/why your kernel perf support is failing on alder lake
to be sure turbostat is coping the best it can.

If you can identify an upstream kernel version that fails this way,
that would be great.

You can poke with "perf stat" as well, but this will depend on what
.json counter list is compiled into
your version of perf.

probably a first sanity check would be if these commands for the LLC
and the L2 work:

sudo perf stat -e cache-misses sleep 1
sudo perf stat -e L2_REQUEST.ALL sleep 1

Also, with your L2 patch applied, does turbostat still successfully
show the LLC stats?

thanks,
Len Brown, Intel Open Source Technology Center
