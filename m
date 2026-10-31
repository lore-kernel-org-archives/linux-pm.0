Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475085;
	b=uq3n/EVhcaJN439HuxJXqJ7scTp8unV67beFDyGB9y7YT5VPi4l7tjRYlWjdb7C9/EDL
	 UQV2pg4mlh597Ry5QXGz2akSScaXt+U3Ts5ElCsrnhsrhN3qFMopk9Ml2HFDJZdsM3Up7
	 vHqiePAvH9VxC76A2C9S+hgqxd+OKkhL/Gd28BCHWp6ba8icv2OFF2kKOmlVHJ3uAuxGb
	 7uzYQ3i11/MMCwUk7/ON3rw5xdUl3tQWk1hJG89rBsgb8mSb/3NQ8eVS3CWzlBApEn8to
	 Q0xLAZy9IlPlpRt5XVoxYoOJC+bd++wCYpx+S55CSW6qA1n411QqTXlpBb9ouqPQYMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475085;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=B/EvEc+3U71IzwH2HcK6Z9ISYDUHNnpY/jZzn50DDTc=;
	b=Ab3sJCCqY7yAtpIg9kNic7A91geGV/5L50dmxRW9/ftAKTRcMtdnDoPOQ57fDNwuNA3T
	 Xl1dA7V6pO6u/SscBFAsCELEalRih0HN0wk4Vp0umXHE1l3JF2+io7rOmhRfnzNdI2yqK
	 3YqqK+Hz3siOpD43B1FFI9qqGFLmng7lLUFAbYPfI6s/rzkBcflpsDQdfRs+KEHKQNGBc
	 c5+ZDb/lXVi7xSaL/fgGo0PtMC/Ac24IljWNtjHOUTcN9TyR1JMHiaL5tp4Z1Wt6hIJ6a
	 paqYqMmIYw9rMVjJ/LWRmjsqE0wsVJTsEHb/3yHZp4VqOO46Y71ECt/xTxMBIF2eytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=mlCMrPQr;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01782606A31A;
	Sat, 31 Oct 2026 19:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01782606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=mlCMrPQr
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jH7PN2C6dz8smx;
	Sat, 31 Oct 2026 20:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793475080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/EvEc+3U71IzwH2HcK6Z9ISYDUHNnpY/jZzn50DDTc=;
	b=mlCMrPQrdwVLrAYK7atgewqZu5SONcKkuZ3Qshhry2MsQ2dGlgH5Gdi1n2sE9nnJ/MdwBt
	+C3L8bk+VCz2lNYFBBNOFNVhcoZmSYZiW+LvIyTYM0nw5FdFkAE0mJxtyuwVvw8ckei33L
	dQ15bwL9n9/8H7SUSO+TntBDyWB4zHSOwGKiRaigun7Czg3Kq9Q3aWpeQj7MhHpLIG8BRu
	W1FMsDoe/HAurJ7cWOFpOKuFKsHHE2rAoNsjpWY+srHl6RzdXAuxMsoJlJBuwpmWFdACht
	USvxNKA9h5APoSmfQnK89aXxSscw+x3GbdY86lR0LvMmu6h0w12PC7nWJNpO4A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Ashton A." <me@ashtonantila.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: processor: thermal: Do not leave a stale limit when not throttling
Date: Sat, 31 Oct 2026 19:31:17 +0000
Message-ID: <20261031193117.3400172-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028-acpi-thermal-stale-limit-v1-1-4b0ab3230f01@ashtonantila.com>
References: <20261028-acpi-thermal-stale-limit-v1-1-4b0ab3230f01@ashtonantila.com>
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
X-Rspamd-Queue-Id: 4jH7PN2C6dz8smx

I ran into the same bug on an ASUS ROG Flow X13 (Ryzen 9 5980HS,
amd-pstate active), whose battery profile turns boost off. I've been
carrying a similar fix since 2026-10-17 and found this patch while
reviewing mine before sending it. After boost came back, every policy
stayed at 3.3 GHz instead of 4.85 GHz until the Processor cooling
devices were moved to 1 and back to 0. With the fix, all 16 policies
return to 4.85 GHz. My copy reads reduction_step(cpu) once into a
local, which I'd suggest if you respin, but it is the same change.

Two additions for the commit message, if you think they help: the
cpufreq core lowers cpuinfo.max_freq in cpufreq_boost_set_sw() as well,
so acpi-cpufreq is affected too, and the thermal core writes state 0 at
zone registration, not only on resume.

Steps above 0 still keep the boost state of when they were set. I'm
looking at recomputing the limit when boost changes and will send that
separately as an RFC series.

Adding linux-pm, which this didn't go to.

Tested-by: Hugo Sales <hugo@hsal.es>
