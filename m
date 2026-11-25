Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615892;
	b=NcNlQuxQcE9zZc5cVkJkxtlRXHwoEvvmcckra2KagIy0tSsM0a9CDpiMZCtTOeZoETXZ
	 YUvyatrdfrBXOgVN8Kc2EpxUOrA+qJmSKsFAGOpZdGqWRGbMKa9FMDB4oydQGuedgw/un
	 H32TR0EZtWwNvA0cvxYtpEk3ymISDJ6L6+I5Z7pysS3Cfx9o9luVnxI158v50OWvfb5gO
	 drdTNygQCTVVhHuFpyUs4Obfqkm80n+/cpOEyjCX6WL6JplQHspLpWcxktRg46tjs2cE6
	 QuOzMslQLFjWa9rRKKtWrO39aet1FyfWo3vpFxJl4/dCVPjroL+WRWr8daY3jdaYbAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=ryk4aCHSNa5lDsNDsKY/W5EwpCRvpbexMjf4tEo4zEs=;
	b=jbwiqXpeVuBoPIuhRs8SZt0bMwfao9lo+aXSD6jAs7RilFtXz682ABTS5MNJTHHlhVVa
	 3kuq9Q2S+Cb5C1sGGbHIkEjVyzmwllB3GsTqIlIziUt4zwRXm3fYnwoshAg3l1mTavlvs
	 XRBoCd5fftynYSEOHj+Yd3bJOF2Yfsj9CKjg5JDZJO7b1bf3aTN4fsKoD3W/aCeVnCrTc
	 UDcZ2nG638VI7T3UfhVkZMKTQYREqkHqc6FhLLPzhs4JjJs7hV+O8nOBE6wXGlsOAj+Kp
	 kcxjbkfGjFHyoynPWtkcb8oPxv7DnzJNeIHH+2hExZ/i9kmn3Ao6zpO3S4mfzgebEMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qlil5qeR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AE606A33D;
	Wed, 25 Nov 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qlil5qeR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47841F000D2;
	Wed, 25 Nov 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615891;
	bh=ryk4aCHSNa5lDsNDsKY/W5EwpCRvpbexMjf4tEo4zEs=;
	h=From:To:Cc:Subject:Date;
	b=Qlil5qeR3E4j9CcJqz/tbhYDMMjOJha5eJzwKSa4FUzmd/6s/tIPiz0f5OduwjiR3
	 DMNYstCCzhtgrlKZtO91eMeaJkqSrKqXeexvtTOwJeR/mQufek4VhcG91xKeTJgw8t
	 wpU+7a86g4aGBjiexKoRPcYyBsRBEf2Rln4uWmJxVVC7CUZCOsVMxoN6HtSxGnJjwn
	 I56iHmC+i2eKpgfnVGHUBPuJS6XZsk1EVePlO7v6VXPFZyqmTVp+P2D2KzRNoecmV4
	 0VueXLZ2mlhJDEA95ad+6Qsap+qWva/S3ErK67i6Jc4MQ03x6Vx3DKIpKMsbGywmpq
	 V/lYDIeW+O9fg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] ACPI: fan: Assorted cleanups
Date: Wed, 25 Nov 2026 15:01:45 +0100
Message-ID: <2859850.mvXUDI8C0e@rafael.j.wysocki>
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

This is an update of

https://lore.kernel.org/linux-acpi/3985766.kQq0lBPeGt@rafael.j.wysocki/

which is a series of assorted ACPI fan driver cleanup.

Thanks!



