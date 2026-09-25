Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54F47143D;
	Fri, 25 Sep 2026 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325460; cv=none; b=oLAsqxrFAxCAvIo4Vv/hUsSA6SfNyBvxzB44vLLpZ2mVYNIdIODT9/PcL439SnujF78ILX3TjrlMB+l2BXppJmFB63uK6KbhmN3/gVKG2fQouIKFfxR8iq6Uxd0kVjgwFzlaw7JMln0CxBa9DNMQtPz54GKJyHsUOl/p7KjuK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325460; c=relaxed/simple;
	bh=QwwDttcOxwxMoT4paws0jMmgdYGoTebmQWC/q94XMJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzOV0V8a6NAbnRgIg/Z2TbMWgJPsIGMmbv/PZrCjfTlAovJ+tYtI5HODIIe0jbcYCNc25i1pwnXPVQvdWtxWhqthedENRkHoK/IdALAATkHhfHj7sBi981iitBuDkwhbnLxUxGxXL2Dm/vF1q9ASuVX7nkIsfCs4XrLMvIvkXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIpEZqc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIpEZqc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E8B1F000FF;
	Fri, 25 Sep 2026 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325456;
	bh=ExSHE+6Int9fSsye0Kmlm/71V0CgS9+T7vnkNLM+858=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hIpEZqc9Gv+zeMjzxP7xtdVzF5FvQc1CuvUj3H2cWG2PRJK8Up817RiupBCGfVIxg
	 uo1qqGQthS9Bqc3cvttH2Wh9VGARvNOuhvti9uVBGY6ZPTr5CoGh7BdgpjWeF1Gwl1
	 Kgoon+Mre8nYsQ87cTNiNJz/Z3cdf9a5sQToMMw3oNi5McF7cUMmk9eyQwxc46PR++
	 zRIpjmo6gwcRnqUM2EwmdLeqqT286BZbJUhX9dDYrsoOmFddeeE0yRnXT18163VMOx
	 NLAcD45W9nfGkKdqIdOtULDYTCZFj1prA5jrda03OmFulqYyGHC5UrUfDBy3kXzJLS
	 1hJqd/Dx3twmQ==
Message-ID: <fb815a49-ec0a-4f9c-aef9-899df1a8bce6@kernel.org>
Date: Fri, 25 Sep 2026 11:37:31 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] thermal/drivers/renesas/rzg3s: Convert calibration
 defaults to per-SoC match data
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
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
 <20260925061617.127349-3-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260925061617.127349-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/26 09:16, Biju Das wrote:
> Move the default (software) calibration values SW_CALIB0_VAL and
> SW_CALIB1_VAL, used when FUSE values are missing, into a new
> struct rzg3s_thermal_info retrieved via of_device_get_match_data().
> 
> This allows different SoCs sharing this driver to provide their own
> default calibration constants, which is needed as RZ/G3L uses
> different values than RZ/G3S.
> 
> No functional change intended for RZ/G3S.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
