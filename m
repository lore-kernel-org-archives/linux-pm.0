Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A2153561;
	Fri, 28 Jun 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596682; cv=none; b=qJGLUgIVOzZwL0e6WDk+3wDk8rc5oHjg1onomjV2F+Q9TlIPxX89DQs9wtwA+izShVetiuDvDVmvyYmFlX4AqvLBdoH1zNpQ9709ou0mkhivNsOWaMhG3dD1yoioM9A6AxBfSnkoOZRnlXEFvjRMcjYR9xdyKEn0BBm23G5ixac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596682; c=relaxed/simple;
	bh=7kyxnTw/ovYpmPNUHNRxkg99qZBf5rcdJPMsvgfs5a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHMulZac7+gIpRpcg+J/sEgG3Da8lfPgPYGFXblhJ2Ze5sPSpmxYoDMktX0NPKkmnbdLRNJDEpmCp+ETb2hw5zkNWmnkY3N7DOX7YcBygTT435uohSGYZ3ymX699i1oTi1qKx4CSvhgHsQBbu7wInGODECw4PNq01mMYTXe+WOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WQV8+I1U; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WQV8+I1U"
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719596676; bh=7kyxnTw/ovYpmPNUHNRxkg99qZBf5rcdJPMsvgfs5a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WQV8+I1UPMBhDb+9E9g21BxZ124JyoueSz4ZxhQRBEfR/bWxYyiOZ57n6b0EM4wJh
	 AzdQ9ozkANSzO1eEeD3gpzeVNZvaszaOp2iGLfyYJkl28u2QeY76bDkMGmIrUiXtmk
	 4vgQ6ypIh0EvE5TJsO3ON3DILny2nSn6Xn/nTrJxa5IOSXBIrqQDXE8wcu0V23o/ZJ
	 w2DqN0CEEFnXvYDWoa6YJW7408p63s52YbfyJJo1FR/02DBAzwWz+r64CCA3Ubxc+c
	 wRu4bS1S9U/tORNuiyNANLoP/UT5iSZxYpLK43KYtztApFYgznIxtraIb8ALrQp3GR
	 byxaAatTSJaPQ==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 0/3] Updating maintainer and correcting Czech translation in cpupower
Date: Fri, 28 Jun 2024 19:44:15 +0200
Message-ID: <20240628174420.5370-1-danielhejduk@disroot.org>
In-Reply-To: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
References: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Daniel Hejduk (3):
  Updating cpupower's Czech translation maintainer
  Correcting needs work strings and adding new to cpupower's Czech
    translation
  Adding changelog for cpupower

 tools/power/cpupower/ChangeLog |   3 +
 tools/power/cpupower/po/cs.po  | 174 +++++++++++++++++----------------
 2 files changed, 95 insertions(+), 82 deletions(-)
 create mode 100644 tools/power/cpupower/ChangeLog

-- 
2.45.2

