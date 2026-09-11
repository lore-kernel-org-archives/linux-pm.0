Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736849E15F;
	Fri, 11 Sep 2026 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107162; cv=none; b=LKWLc3KeUrfaIeDC6yIBT94uTfR81Xa3qBtCtGGdB/egUe7Qk3vjEeHTj1sIFXPIPFPgJRy70bjDL3Udx6ErfDnUeEJLuBw/1X1AODksw0blcWsgXWVGRRCd4QIIpx2mvRhk1MXI1PQU4JuRBImnR9XQxxT+67sN0z3C21/7tYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107162; c=relaxed/simple;
	bh=gnanWk8CcqOwWXHW4Ye8p3oedpjhH4EIzInyWH7wzvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qNqCG6qS5RykXBS22BVOYCG3+KzSECyTWL2lW1X7kLGbP5P05FNhO6my5Aj1LtYm+sZewhYYWq94tFfuJA+7bReHXALi1rimAEMTWMkib/lmRlF6enSKfmfvSX5ZcK1usQo2I+USWcnbywSmm3wrO42vgweW0qDT9yzRIn0ltOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=nMYfwFoW; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="nMYfwFoW"
Received: from localhost ([47.65.179.181])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 68B631Rs070422
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 11 Sep 2026 08:03:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1789106581; bh=gnanWk8CcqOwWXHW4Ye8p3oedpjhH4EIzInyWH7wzvE=;
	h=From:To:Subject:Date;
	b=nMYfwFoWNFn97nrCJ8y4a3+nSKHJUozVXHJPxPD4l3wjvKwua8P4/dSt7Fd60vXal
	 m+OUE5u61P6vSpWmhH7ozEiOujeFPWhfylVEbD2A1cv654whDD330+E0faaUldjK27
	 ksBtL5GVm3CCeNPYKIpHbiRH128RCgLIjNVmsFPc=
From: Dirk Gouders <dirk@gouders.net>
To: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel
 <linux-kernel@vger.kernel.org>
Subject: Question about system halts caused by temperature
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 11 Sep 2026 08:03:00 +0200
Message-ID: <gha4po5nqj.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

just a short question, if I maybe have a test-case that is of interest
to you:

since I own newer hardware (Lenovo L14 Gen 5, AMD Ryzen 7), I suffer
from system halts during system rebuilds (I use Gentoo).

I now found a reliable reproducer (emerging webkit-gtk) and a setting that
helps the system to survive such a build but that setting works with
perhaps very conservative frequencies and from what I read in
https://docs.kernel.org/admin-guide/pm/cpufreq.html, even with
/sys/devices/system/cpu/cpufreq/boost turned on, the kernel aims to try
to not let the system overheat.  Could well be that I misunderstand
that...

Thanks for your time,

Dirk

