Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535482;
	b=ZkrcMtqxyRGzBqjVE/FBLFd6jw1JGrZwrnWYEdErCu5bwZRp2+g5hCL4/Ai0HDP3+4jP
	 ruyDlNdW3ugsOQx9fYYLfdubf6ZxD8VIURaUz6c4MrnClmBlhKfvNEa9+EsLcAJcjWj1o
	 WuO+tjtQNZU9o2LcDV7vL5K+XoclgRzgSnxY/QFJI/xOmwBF/SrEF4O9lrOvg9JsASFSP
	 Y5JGtu7MTa2yn5R9foV/rj/mkoLagZ/0JGNU5I5qL/+mJ5JTRsytPBChTNl0kFjIZg2PC
	 j9x7TwVdkdtEIHfPOryocdl7/7gTkZNb0QhexHnTILPQra2x89PytYVrCYTQ4H4QzSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=SXZ+e0+jBqpwPQt7kEZjUQtapJYDTQfnwe7BFpI7m2U=;
	b=0Ys18D2WRzLD+7W1It0aKWQbWgzot0JUToNYWviJKN71Bi0mTslXLLF0JxMz2LttgEqp
	 sGuUtrVhWcOlAR6OCoTyGqblNHJuKUpLqutRNJbXwICMJHe8ei/FlLNYW4j+vdJv+JC4o
	 Ctg0bzAkqe6aegEfA4SvnI6LTVkmluT9Z4KvJ/eEwtk7G2IsWgnCDShROQo1/3NyReZIi
	 UbwYH7tVUUxgHMpki8QSwBYUENmoZwGeNq7BWxyfmwnm7JhZZPAbnbxYIng2g30dChsju
	 Wd1vYvBBJfa9Ekd9wUJAjbm2l1x78kTYJ6hXfmVMJFcJdTGG1eAkozpDeQSWrutYd0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jclUpM0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD09606A31E;
	Tue, 24 Nov 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jclUpM0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131391F000D1;
	Tue, 24 Nov 2026 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535481;
	bh=SXZ+e0+jBqpwPQt7kEZjUQtapJYDTQfnwe7BFpI7m2U=;
	h=From:To:Cc:Subject:Date;
	b=jclUpM0mYbsuC7uk/b+JwVZ6WCD20SuPPFqqTS3bwqpLVGHofzYpRLwR2KfEAghWD
	 263Mle0WCN4CX15nZvoOUbFXNCx6GhQQ38FrzxKMSbDJBeqrz1IrhiZg+vv18zqD3w
	 C4u1aqQqJyUKnYgh8MSi3x4KU27qrNccoveKboroYeQT7QOIY+p5gbylIGYNuyKAZW
	 9Fovt2Fob0JEEPL+F9MNt2663HU0zfuGJdtDgUUmzmQWuwuiwBYld4QFo5xxF5bAw1
	 GaTWbcimgQ1Sz7RMbGXF231kHmvw0AYVJgrC9RirKEYNU5PKUDZSrZgzBkfPXCVjF9
	 FKhsJvKCiBOnQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] ACPI: fan: Assorted cleanups
Date: Tue, 24 Nov 2026 16:45:10 +0100
Message-ID: <3985766.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi All,

This is a series of assorted ACPI fan driver cleanup.

Thanks!



