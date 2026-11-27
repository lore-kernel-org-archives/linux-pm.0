Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791624;
	b=wkYpCpsJnQw5TMPtoBwoWehHhazSf86tki1xS2KNWLsgGwMHO13iQ+Zqz1ObFDAQIFiB
	 ss0uV1+iJATtXHaXZAL04Kv54j0oMn8ElALOUtwGgjmdyA5uAcraD6+fkluRn74Ss5kXT
	 XYFBPM2OtBlErFME+BGVj1IXJdVW8mI8+RuStAso92FLUCBcoZrRi4t0kt9deSy5RsmYl
	 ampGZaYHFkPNylOPqiLjGhhUtaR9nz3zeG0uQLek89R17Xs5FC0T6DBJoqUHfBS5QOleZ
	 eqDEm5snrSnGjtCIyznT9aOrAAOVapzbyjzaZZpN7fDY/FQTrhsTsiW4cHJoOlBxm3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791624;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=demvX8+oSAAJ1/YYQX4M7jcvAfLYCNywAMVtmipUulA=;
	b=iu0QkpyloVqc3vkGVc61igIn3HS4Kmj/MY6wfG66wO+3bIKtwc+DE890LZ4p/rmkXB9o
	 +svuxP1IC5KT/ZhL8f4YZPPoS3/boXiiWO20IHm2BDMZvAOCVEfqekqUJ+YtfLkUHLV6I
	 spH/QTGZBmrMtAlFKxNAMqr+HEnhXa71Jsh1S18VR46mgFL+KBCszVd/E7yhV5mXOKZZ3
	 9cQIZlNOX0Pk91wlA59vre6AzTQD6565z9uvSqpN106tDMUdSRNm808lwc7YAWp9THkow
	 VW8kJPLyondp1978TkRZc784we45xd/mrHt2Oqyir3nIG1DMIZ0JdEYh9Ki21/NLCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=Kw0lxpAd;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD95606A330;
	Fri, 27 Nov 2026 15:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD95606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=Kw0lxpAd
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: b0eed350-2779-4cf3-b02f-3c286570b151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795791620;
	bh=demvX8+oSAAJ1/YYQX4M7jcvAfLYCNywAMVtmipUulA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kw0lxpAdq5eZaR3rMGzZcYV8EryUBFKZhtt6Pjxnlzc4mQi+7ZfMZhBXOHPmBB0WO
	 AnolNKXrqgACmacOWxojrzJAX3rExqtaapGB39RLTlqYcPivPy3zmlwXevCeDmSkkp
	 F15r3QIiCfCd/onw5wJSayl+1rqOxN1fiU+rEMxdzpJIXA+6AoSD5sY3q/Px4jGwhZ
	 x9ryLp/d6LuGS93hHJlKARHlF5GKpc26GiN50j/e45dKZ1Ll+nwPUC6S1toydOdos1
	 ezAKvmYeCdNmD++0D105lNcc0gk5P/O5k3umpf0WXfDYgxkY2hFTUx2k32g1CP0Zm2
	 I9rjxiyxIHjFw==
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	lukas@wunner.de,
	yu.c.chen@intel.com
Subject: Re: [PATCH] x86/cache: Restore AP cache state while bringing CPUs online on resume
Date: Fri, 27 Nov 2026 16:00:14 +0100
Message-ID: <20261127150014.285304-1-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111123747.49446-1-dev@deq.rocks>
References: <20261111123747.49446-1-dev@deq.rocks>
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

Hi,

gentle ping on this patch. Is there anything you would like me to
change?

Andre
