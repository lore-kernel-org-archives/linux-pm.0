Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428720;
	b=nj3G4rLpKmOve3opfBfReo1cvlbIVjHn8nhLtA8jeuNoHcP/tslwcuUOvPTobAom/3vh
	 IzbwMH3ZCgaOQlFt7IQUyBZ1J7lgvF4oZZPZ0bcvCY+KiGTXwRlKLcI/7bok4J2XFz+n1
	 OBmJwYgxK3ZNZjWK6WmRxJrHA6fB+GlfVHMgorILOiidDeEoVoh0puOfnQU7xQBjKGnsC
	 4K2wxzhBHvVbVIEODWmgGyxuI3UnImhlCrYfEm52f7kF6R03JBHGoiKxhIO0DA/6tgE0b
	 dI2WkUTjOqPCdrJv8xqq5kJDqN/wYWYouVZC4kLaMSy95d2YQk+J52uy445YvTxvsqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428720;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kM0+/+TzIM6mjsw2LmPVnA8JrfRrBqAtPu6wTqPDNWU=;
	b=dn3y0JVKAEXH+RtfG+Kgm0CkKKrasu5gRSK4EzUF46AwwZAi9oOKym1ru1UaYe5pRo6T
	 T9s44c6rYKIKeNqvtp0eC/Olsyn7mVr2VG/e9SZkyBKRfjQTDlZW68d0wgLETrpj7tMdK
	 Wv3k4f8XZnMzXpZ60Wwg0WC6/SyfBEIS5q64HMUxWUqOL6Km0w7zZaTSzPQaFrbqDTL4H
	 Wal37GG/oxPoTYthK7Lfdv18LcMyIXPi8vfRx7MTtIktj+I6YiG85m2RDCkR69dGLL093
	 blLBHQLo4G3bKQIwMSsrDcjGuJXA0zk8skJpArVS0X34YqzbdbTYc7yZQ3o90NtuhVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQ0eYHCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99637606A32C
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQ0eYHCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6579C1F000C5;
	Mon, 19 Oct 2026 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428720;
	bh=kM0+/+TzIM6mjsw2LmPVnA8JrfRrBqAtPu6wTqPDNWU=;
	h=From:To:Cc:Subject:Date;
	b=LQ0eYHCgHrfSE7xXM8jtamVoJuFtBRoua8DfiA9LmJ7LvQu+jg1iIK1ttW/SYitAZ
	 6Ip4mi8h3c5zsglrg763fgAXFSC6B8JoFPIlG/KylkN3DDz5p+hyCnVqtkvVcik1n3
	 umTymvo5t71H1Ko41Ji6oYGeuntcWio8BSUiigQC5KoftiOwzfMzUwS0WLJR7jmkbL
	 x4lUE/5NyWgwod3/AOBNK/UWwVgRHEwY+6JbaizWYArfTkZzVHkdIN8VX+q5dvRYoU
	 DZfwWOyqFJGij+lRYD/uiUswT0XxKf+l9XFRhBhmL+P2WZ8pjtyOiwkzSpU18XY7zR
	 V7QoA4g99kGmA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 0/18] x86_energy_perf_policy cleanups
Date: Mon, 19 Oct 2026 12:43:21 -0400
Message-ID: <20261019165156.42592-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
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

This batch is mostly the result of an experiment to see if AI
is good enough to find issues, then fix and document them.

Turned out that AI has its strengths, and its weaknesses,
and figuring out which is which can be tedious.

Bonus: If you find issues in this series,
you can claim you are smarter than AI.  (Andy Shevchenko is:-)

thanks,
Len Brown
Intel Open Source Technology Center

[PATCH 01/18] x86_energy_perf_policy: Create msr_path helper
[PATCH 02/18] x86_energy_perf_policy: Enhance MSR probe
[PATCH 03/18] x86_energy_perf_policy: Prevent unlikely buffer
[PATCH 04/18] x86_energy_perf_policy: Cleanup: Harden with strtol()
[PATCH 05/18] x86_energy_perf_policy: Cleanup: Use snprintf() for
[PATCH 06/18] x86_energy_perf_policy: Fix optarg keyword matching
[PATCH 07/18] x86_energy_perf_policy: Cleanup: Fix potential ratio
[PATCH 08/18] x86_energy_perf_policy: Bound package iteration
[PATCH 09/18] x86_energy_perf_policy: Cleanup: Define HWP window max
[PATCH 10/18] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
[PATCH 11/18] x86_energy_perf_policy: Cleanup: Check fseek() in VM
[PATCH 12/18] x86_energy_perf_policy: Document MSRHEADER
[PATCH 13/18] x86_energy_perf_policy: Cleanup: Drop unused signal.h
[PATCH 14/18] x86_energy_perf_policy: Cleanup: Constify profile name
[PATCH 15/18] x86_energy_perf_policy: Cleanup: Constify HWP strings
[PATCH 16/18] x86_energy_perf_policy: Fix use-after-free in
[PATCH 17/18] x86_energy_perf_policy: Fix write_sysfs() return type
[PATCH 18/18] MAINTAINERS: Add x86_energy_perf_policy
