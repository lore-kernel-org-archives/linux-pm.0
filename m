Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9C474247;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136011; cv=none; b=bnksZ0p/ndMyzaGFf/WQNTjSozckbWsCqTVI9X5mu6H/0cZ5cN+OunUuheePfynLoKUgEI+YuQzCkshyDKsn+8lWmdKnhUg+u3gs42v01jlzU0chFafNf/zK+rNppy8NENtH4FoGvrh9vvrAchDEVXcuWW26BGxhAkNKnnx61RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136011; c=relaxed/simple;
	bh=636q1zK5gzb5Znehy8dAq3UJdQcGx4R+lQ232/nahpk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=byAvngfRiYH9jiydiqN6n7bbzC4Ttr4hIoCN9m6Ik9H71iPk/MOB2LeXrrPsTDLVBTlvStQ4x5N+iJ3X+HGiRTjm3tZcgOpjvJCdw7XPis8/eFTHL2AnBADS8YuNNuzUpjpeT9nfcEmZTVq/O9lk92E8bn8SnoSPZDI6oZSvTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393611F00899;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 09857182AB9; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260917211309.i.765-kees@kernel.org>
References: <20260917211309.i.765-kees@kernel.org>
Subject: Re: [PATCH] power: supply: qcom_smbx: Remove const from desc
 allocation type
Message-Id: <179113599802.190565.17906994293592743172.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 17 Sep 2026 14:13:10 -0700, Kees Cook wrote:
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "struct power_supply_desc *", but the converted
> allocation type would be "const struct power_supply_desc *", as the size
> was taken from "smb_psy_desc", which is a
> "static const struct power_supply_desc". As there is no general way to
> remove const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_smbx: Remove const from desc allocation type
      commit: 6415ce7204af0e282f32c5ca69953d4224ac49fb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

