Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710897;
	b=ulEnEHce0IxHqH4xoM+H2zDisXuUTVvf3g0PTPM13bhsNZj1kbrUp1g85ZWl/meDw+9f
	 1zMd3NFYGsgPDse7DSPoba5/FaC70NVO6FUVjXMU9CyWSsTfLxmx3x6Gd8PgkZ8kbvkG4
	 7UvlK7f7G18Dah9AJNkZLc6y8EQA+WxR0QyIupMgaieQ2aUTZR4TlZdtaTbKEZ1Lmpgr0
	 dLZbRwqeouUGiFgBPWc68lsY24LoRN4rUeYpig4pcHOFSgtFZq7AxsnYiSJbxlF0kltTx
	 jPy1cXxTeTJhQGGH8fp7skId2t8ewA0fiMbcJBWP0aIbwc8R7PrZAdQLS4M1SC5tzwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kq5BwZFlyCx7Ts+tlLob/ycCmrlDmGIBrdYtnLLIhRQ=;
	b=wbIaTFurm/wLwPuRyXa+ks5mn4xIxA+WQscd/uRKa37BR5LdNkCS9XAb12p3J4uxU7NJ
	 dFHOiMYyMQF5v/SNPGrODTp0J+QYj9jSGnl2o9dBJvERv6QbZ85dvfR7ZY+DdIhJgcoYL
	 BV8bBNJYh5grr/ppz6S3re8ZKjqwH4HAAGGRBZ10tqB3qNIz4RtMNBxfb+pTxmVTrjLzV
	 9/zDgCyaZlEIquadVgyiam6DP+eDKJSgrwbyTXO2KYe2VfgBfYIPvfueymWDBNJk4cF0t
	 imkHm09qYQj902nhGAC92xC1u7OtythxbMkPwbd/yF4dBS7SZHo1tLycYP5+0Tjd2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnZtfiJ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33DA606A327;
	Tue,  3 Nov 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnZtfiJ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259AB1F000C1;
	Tue,  3 Nov 2026 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710896;
	bh=kq5BwZFlyCx7Ts+tlLob/ycCmrlDmGIBrdYtnLLIhRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnZtfiJ45MApyCSpJguo0tOn5IzCJqlk3dCFfTSJlW2DkL5NawvtQU95uVhOON2gl
	 jJcFWKMscToJYgxM5g4JYYHTepp3iN9pCQhHLV/xfrDuxhrEeopcy+UqeYiD4sesxl
	 WPmZrlIOPJpKhy9PiwLZZg337q0EQ6KqslCiyXhofnPQtmgBtA/jf0T8A6txLIzw1R
	 /0oDXlM94agtOYLSgivi1jsPgwhDXzkOm2LUnwK8sAVbwOyuL9zDv5BgAYHK1ckJuR
	 7CtQTgsdX5YZvzBVKhPFB0BpQ9R97FEw7mu07A3cp7CGgxOXDxglQ744DH0nzj3Qub
	 NqOcvwsexmNKQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] selftests: target selection fixes for cross and LLVM builds
Date: Tue,  3 Nov 2026 08:01:24 -0500
Message-ID: <20261103130131.4069212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200127.1363472-1-sashal@kernel.org>
References: <20261014200127.1363472-1-sashal@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

Ping on this one. Rafael took 3/5 through his tree. The other four
still apply on 7.4-rc1, and Thomas reviewed 5/5.

KernelCI still can't build prctl on any architecture (the Makefile is
skipped whenever CROSS_COMPILE is set), kexec on powerpc, or size with
clang on arm and on loongarch. Could you pick up 1/5, 2/5, 4/5 and 5/5?

-- 
Thanks,
Sasha
