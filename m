Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A189456E02;
	Wed,  5 Aug 2026 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931877; cv=pass; b=LJTlMXpyW4PAn24I952ECSd5IQ2uDxJoW2LJLTr1DkHThKL95qRoqA7eeSQZx7xnyQhLxalsYia/5ewhZlYdLnbwE+NGrnhlTHWoGSxVHopHunA7I+DRZgQDomaDYJKSpFYAlc9ly+01PfEpgY6N5UMQxIsNIrGw/7tq9BuAYp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931877; c=relaxed/simple;
	bh=DcDgy7aa0cF7AxYJVPIGV9ZtGNLd5Nu4Uv8aRszk62g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2ANMVKdqUUmwfuTjz9CF8swya+PrUHISmtNJX3n+dgVF9vVECGuNr0+H+X7B/30poBoRDEUtZWiLkeP7drPeb0my8hARDxCfxT6FmNbLwfkl9cgAYone3q6Rd7aVhi3UxiZFHUhIss3+U8iv6M1wnbdmP0k83P/lmYyICXn0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=K27wGtT7; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="K27wGtT7"
ARC-Seal: i=1; a=rsa-sha256; t=1785931852; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JHlTa2OeETQU8EIxMwzp6l5RXcbiJZrD4sudY4KenMdqr8oEmqG4KrheLFnwveeHUXscWl8D8y5dCucqxJMM2EvIBS9f75oQRtIz05tCthmYLlBXPjRK5IRpYWrQ46ZAG6lCWb7/7DgYrIw5dp+r34FsGRLjnWuGK4LFwJzvfcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785931852; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AhQ7KXqZNfg0xI1h18oiEpx/CrbWuseHXehXE9G4iYA=; 
	b=jiaK+oj4VsL5ydHoha//yZ6JVqJobNqmkEw5lG0DbKh5nkSwce5BZIyjBt9OyfijfGGE/5wGhRSuc4aPnrNanLQAFeLFIh3jy9QFS6Fpk9XyiR+VU0p+T5q4WuAgBq9/oHYKVwRtaKqq6QQ2H6RqqDm0SOfPRtmD1UtcQUUVZPU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785931852;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AhQ7KXqZNfg0xI1h18oiEpx/CrbWuseHXehXE9G4iYA=;
	b=K27wGtT7gMw8bUh8iOYyDN4taIcY5h8MZFysPlLDM4o4rO4J2DNHleqhs8Ph0VV7
	Jno1y5vMAe/OkcVTskHFRiED5srCC3Ird/suvSPp5RTcgyD0x5ZHYE4oUn7ecWFAO83
	awbrrulNkK9hI9ihNjpFEG83eNdLHsMT09G/GXUg=
Received: by mx.zoho.eu with SMTPS id 17859318500211013.3360191632657;
	Wed, 5 Aug 2026 14:10:50 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cpupower: fix topology array handling
Date: Wed,  5 Aug 2026 12:10:00 +0000
Message-ID: <20260805121040.101007-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805114305.97160-1-ali@iusegentoo.com>
References: <20260803175215.117518-1-ali@iusegentoo.com> <b503143a-4716-4af2-a754-9fcef9eced35@linuxfoundation.org> <20260805114305.97160-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

> but cores is in the installed cpupower.h so I cannot speak for
> out-of-tree users of the library.

That last clause is wrong and I should not have written it without looking
cpupower.h is not installed. install-lib in tools/power/cpupower/Makefile
installs cpufreq.h, cpuidle.h and powercap.h only:

	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
	$(INSTALL_DATA) lib/powercap.h $(DESTDIR)${includedir}/powercap.h

cpupower.h appears in the LIB_HEADERS build variable, which is what I saw,
but that is a build dependency list and not the install list.
get_cpu_topology() and struct cpupower_topology are declared only in that
uninstalled header, so the caveat I attached does not apply.

The rest of the message stands.
