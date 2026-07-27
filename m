Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30140A95F;
	Mon, 27 Jul 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157511; cv=none; b=UTu3+HNnW8iv+hzq4l2Wquq/wPZ/DD+emTIrNr0tSt7Zdzw/zgo8yDof7vc1kj+CkR4tClh7tn55DNE4vBgxqe3zBatSNKdKEUydlbi1So2YG9zbwmGRW71DPIAWzMqbAklbEaAWMGOl+W6X9/oC8uup1TZJi/kSpDBfTMESGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157511; c=relaxed/simple;
	bh=NXNzhGWs5g5rocltNcpUXX2DuyrxUwfBBf2B9E0AG+A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S1PANPVYAnHP3L+G/2DURJZDR07dULocX+kV6K9GqD5qZ+M0sD1+o214zAMvxd82HNd4hnFYk5TSIQvUc1hPDHa1dTNBSGMy55irh6m3hBcfUCwUCsa4sCPbjrlnZlHGnNhIOf11YUt5dMDdL83kUZN8zn1EbbpH1v0Mcs49rVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AEF1F00A3D;
	Mon, 27 Jul 2026 13:05:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 8D0EF18090C; Mon, 27 Jul 2026 15:05:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Jianing Li <m13940358460@163.com>
Cc: Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260727064825.948-1-m13940358460@163.com>
References: <20260727064825.948-1-m13940358460@163.com>
Subject: Re: [PATCH v2] power: supply: max17040: propagate register read
 errors
Message-Id: <178515750656.21558.5278453766547447375.b4-ty@collabora.com>
Date: Mon, 27 Jul 2026 15:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Jul 2026 14:48:25 +0800, Jianing Li wrote:
> max17040_get_vcell() and max17040_get_soc() ignore errors returned by
> regmap_read().  When an I2C transfer fails, the uninitialized register
> value is converted and reported to userspace as a valid voltage or state
> of charge.  The polling worker can also replace the cached state of charge
> with the bogus value and emit a spurious change event.
> 
> Propagate read errors through the power supply get_property callback and
> keep the last valid cached state of charge when polling fails.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17040: propagate register read errors
      commit: 659cc3d8d5ef246263873fce72c8cadeeed073cc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

