Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C169475331;
	Fri, 25 Sep 2026 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325448; cv=none; b=AuMHxsmfOUJ0nIBxNuOrPGDF1dUQh6XNhr41rJnc7txbWVHSeQsCnzkZvfVW8fO43O8GJ2G7k9xGZO3ZwrNbEH1Q/Rg8nlkfK55Y7q6Uc+taQm6NHNpQ+yh93muT8XqttDDqXwAAdbgu0OzEaYVOCbVEGFf5WoF8D236OuYerck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325448; c=relaxed/simple;
	bh=N64bv0zsLKskrb7Wm+gcgQigAg9xa0ydhFjXF5s/S+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldunD+A+ZeRNgnBy8700JWaB9YZIoesOY+sHPL9682V2tOAeWhzQn0DAETp5UIsFrbXsDBxMvFv7TelNYsZ3BZ751odgsQEfB75sj0PADSRmIrrxKYBduTsikzqge6jiE4MYDrOBcxynHroKSZXWUXYOGV2xxFD0fO+cz/ecqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzWYBjGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzWYBjGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B381F00898;
	Fri, 25 Sep 2026 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325443;
	bh=ZJktzqh9KJ9sHet66BxNtg798eGmmdjNUrtExiKFuYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FzWYBjGoh7g4575MdiHDg41pXdLB/rTniU1TqC4n82yygNNTlLmtjWJ6FC1iXsnL0
	 YVqX39spfCEV3tolNj/yKqAxCcOXBUHOLgQXa2PauypEhCx01bhD/63W2Ae+BB5MdH
	 sbZ0jRR6ujpC/Ywb06koQEth3CtLqEJa8ZVKyTv80A7H/Tg2Pqzf3WOe3x1jrhbrTR
	 tZHBz3gu03kQEAIAMnTm0G9TxXqsyxPQsxHQFk/USLkXsZoMPXjFN/jSCoPkhmCKiL
	 UllOFhPPjTq6A6mL++tWdAsFj9rZlpKs/efWE8Zb9Cskn98XD/oOBYB7bZrsdUdTT5
	 9dVLT6o9eZYgw==
Message-ID: <93740a26-4e41-4a5e-8a21-5488688b1734@kernel.org>
Date: Fri, 25 Sep 2026 11:37:17 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das@bp.renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
 <20260925061617.127349-4-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260925061617.127349-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/26 09:16, Biju Das wrote:
> Add the renesas,r9a08g046-tsu compatible string and its default
> (software) calibration constants for RZ/G3L, used when FUSE
> calibration values are missing.
> 
> Signed-off-by: Biju Das<biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
