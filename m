Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C6401A2A;
	Thu, 30 Apr 2026 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552117; cv=none; b=eT1HNayFnhLE6pe2vWQCCm1y2phnHPAs90iRLvruMB3KBZnjOCHP+Jo4cmMALY5pbeL035e9DMzYSNibvvGkgrL9x4EbVWAMg6q8+Po9JU6llE02tC/tVSc0yDDn/xyuQsv6so8+3jnEozRVhNT7PjxcQif7xSBS/W+EilDC33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552117; c=relaxed/simple;
	bh=6B0X6HrcdX6z6dBIJfJ7PomqkAZaJ9Jzm+7wSfebQDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cuwPsGpZv73IcZmtKod56wNGacYnlsoe95WLaxFCARcFaK3v2XofhjJjq1+yo6N18q4mFq5R1GNMpOHS4ytciS5YvvsVzw5vVMOxp1Q9AKlflHqNUr4LhdrEq0VH2uCOJYpWXfel9UF89wJR/h2qh21Gbw+bOlV07Kikw23pRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8AWEWWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8AWEWWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3113DC2BCB3;
	Thu, 30 Apr 2026 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777552116;
	bh=6B0X6HrcdX6z6dBIJfJ7PomqkAZaJ9Jzm+7wSfebQDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M8AWEWWWyxV2EuxEvVIMWWA6vnsHj7Sga3jbF6L1GllCvHd97bns6VBGOKnf6w6CY
	 L382QOdzUqjfcGa82LUuLzNbe0MFlmdvusi1gB1c5xcJF15GdIZrN+tpSQHncA+W4f
	 giDu0fjHmNj7JCDBMe+2eFpegxbs0QzS1KTh549z7tq84tBK0+a245Cf6h/anUxadp
	 fkYB4AsFvh5KDNzfvzoz/HM1Fc6T3t/DGYfoBtZKE4bsQ2cLRMQCWbsi3RS3YQsA0a
	 PGBdaSmcFtRAMiq7QqqGTLAmtu/9OkEmJKM3mInyb7xwwVTASf5qe6LbUxulz3gq/f
	 Z2lC5WidB1+mA==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev
In-Reply-To: <20251102230352.914421-3-aurelien@aurel32.net>
References: <20251102230352.914421-3-aurelien@aurel32.net>
Subject: Re: (subset) [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell
 for the SpacemiT P1 chip
Message-Id: <177755211394.2550722.15714399977264400993.b4-ty@b4>
Date: Thu, 30 Apr 2026 13:28:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 03 Nov 2025 00:02:00 +0100, Aurelien Jarno wrote:
> Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.

Applied, thanks!

[2/2] mfd: simple-mfd-i2c: add a reboot cell for the SpacemiT P1 chip
      commit: b84a9ac61080735b615233e1231ddd19f6624869

--
Lee Jones [李琼斯]

