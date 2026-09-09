Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AF45FFAD;
	Wed,  9 Sep 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994320; cv=none; b=UldbIxTtQtrOlWaDPBdgCrVJN6dpCmyE/iNGx/+Gds0VDRi8Xcnth0iFrkhYk0y6ZCcz8v2d0mwAsIcWvfrKOUkkroaTiVh3SVj9hDQGkRGLPN+sxZTJJaIF1ftFPx4o7rsKUE6OSTCO7KJ8xjNsrdeN2CVio+W/fvm7BFe+TW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994320; c=relaxed/simple;
	bh=6oci7WoTTaVGylDjZ5McdHPDGjT65mWQLv8FiHF8cU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YsSL8RBCFZzhST8m+e1kTI/5zJdTR7EPUPAzw1P0PQTmkp9i+fIqHGm5n5x4x4bAy6L4mfG8CuX3ORsnn1CDVsr4EW+ONAwx3IcHEVlRrKC6uDuBEzREAZ52T/pQiuHSOTRuSJaZ4K8QCBOE+gSIqiogOHE/4RAPHZU73/e9gvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5BA1F000FF;
	Wed,  9 Sep 2026 22:51:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 297EE18337B; Thu, 10 Sep 2026 00:51:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Xueqin Luo <luoxueqin@kylinos.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cabarnes@indesign-llc.com, akpm@linux-foundation.org
In-Reply-To: <20260901072954.1953121-1-luoxueqin@kylinos.cn>
References: <20260901072954.1953121-1-luoxueqin@kylinos.cn>
Subject: Re: [PATCH] power: supply: ds2780: Fix ds2780_get_capacity()
 returning raw value
Message-Id: <178899431015.982928.8471941625830558328.b4-ty@b4>
Date: Thu, 10 Sep 2026 00:51:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 01 Sep 2026 15:29:54 +0800, Xueqin Luo wrote:
> ds2780_get_capacity() returns the raw register value instead of 0 on
> success.  The capacity is already stored in *capacity, so the function
> should return 0 to indicate success.

Applied, thanks!

[1/1] power: supply: ds2780: Fix ds2780_get_capacity() returning raw value
      commit: a58cbc8b36ec0cd00d2ba3de7d003de818a27523

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

