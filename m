Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A5269806;
	Wed,  8 Oct 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951392; cv=none; b=QvTnx5rq9nCbqmhDX/Jqi/zFBlnBGTYURw9/r9JV8w9rw63+9UlhIT8YZQUhjEKV2HaTXCQYYEAbicLc673/xm18Iw7RhoKOsoy0RcQz2PIEbiLyoHfk4vFpv13qoX2Ppygj9qf2HgnHNaMYqY9uGkMdRHH4z8giS6QcuCMKVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951392; c=relaxed/simple;
	bh=JaCeS9yb/4x3DkWJYtD+5QobWraJFT35nNBrCckyLpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWmkfqeNEvUOCXE5mIEYHi0ZYdEsIjvlLKyR5N8nC7h3UNaajwVAGKH5z51e9E3svfHfYjVEdw4nf8/HAjz3m/H3B5n7qfXsNaWuyoVR1ZlbKvVKsKsPr06O924QD33d+n9ibiwkHsAnTGR4BCcZ9V6TbfPbaM0GlcDdIg4pb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcr7yamg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcr7yamg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484EAC4CEF4;
	Wed,  8 Oct 2025 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759951392;
	bh=JaCeS9yb/4x3DkWJYtD+5QobWraJFT35nNBrCckyLpY=;
	h=From:To:Cc:Subject:Date:From;
	b=bcr7yamgtgt15W6V5X1W6Ldcf6lvoYveQC97DEvBD4C7UtdXyqU7eokMMu5EkYvQS
	 4OvKOVGSx9W2iNis2Nkv+BSHxqRwbIeC5whhm2pQa9v6oZ4O9LyeRAFFUSd+nuKFMW
	 MunCtTReXqdAExc/P0cTppr9ksySUoZEqZaPCf8rZSB7XMDEGjAoJKuOLXXE4iK/5N
	 v93I2ZKxVWfQql4HkUcJKXQrr1QWPvbPSRY68uvJhUWaX0xhUq+hSj4Kc2HTYK5KLP
	 26RiUoArskqt8UAFHwpv42AzF0Tmh+A3e4DcKMaumt8S2VMpTl65No0z1/diM+3Wa+
	 TEeKxyGEm0u0A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1 0/3] cpufreq: intel_pstate: Simplify the energy model for hybrid
 systems
Date: Wed, 08 Oct 2025 20:54:30 +0200
Message-ID: <5937608.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

I've realized recently that the (artificial) energy model used by intel_pstate
on hybrid platforms without SMT is much more complicated than really necessary,
so I've decided to simplify it.

The new energy model uses less memory and it introduces less overhead into the
scheduler (mostly due to the reduction of the states table size).  This change
in made in patch [3/3] (please see the changelog for the rationale).

The first two patches in the series are preliminary.

Thanks!



