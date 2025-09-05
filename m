Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894635FC15;
	Fri,  5 Sep 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080463; cv=none; b=bTCMM0IkIRIqZpUYW9zhLVGoLUiJIc88ngv37O+OBGlQ5XkKNQFca6WQo+vwgTw/va8iISx+R1Me++cwc5HxCdyVJ7KmubUqK0nT3Vgw2U6edxzqbvt8ng/DLkhi4CK3S2JicgWkX13RHV7tmfQFO3Lpc5vE4ssAi+ePLsPyGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080463; c=relaxed/simple;
	bh=Bsw0k/oK1h1Nvfo7P+P+96zY5fjM2tcLk5FWQiu2w/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ra7S1q2tkCQyRm/f51Cvoydj4Rkr9PbLVkGzr/VtMbP4xJ0Uk5LjLAJ7SN0Cowkw7FO50g/TGGoFRLuc79qxa1/GIrKMPCkO4u1xklG1FzPKupLcSSBu9zQadDQATiF1BgZHRhENqSKeRya+L7FpUbRGWzp13eKFkspAjeAj/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojZhWTsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojZhWTsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5781C4CEF5;
	Fri,  5 Sep 2025 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080463;
	bh=Bsw0k/oK1h1Nvfo7P+P+96zY5fjM2tcLk5FWQiu2w/8=;
	h=From:To:Cc:Subject:Date:From;
	b=ojZhWTsnaPbmtaivCKybQdQdh9Z7XBI/VD2Mk4NkJkrYfiTVFp9yKt3n/mOp78Wa1
	 RCAUwOKIHSOYBThTmtLgi5IaabxjqCQsYpjjyGyDF4b5Vm2zgJHpjdjLVR2ZVROb2J
	 jx/ABr9cWUIjnPldRxi217o9J8QETn8NeDv7Dcf5BbEDnHKsH+TAK3FBArMCCbcRXH
	 bUDPzKl9UElyBfVVwqkpGYPXZvOTz9MrHo/dXi3eofyw+tBxcDXe0MGSHuebQ5sNhY
	 /qlPaZMc0ylNggpM2lUKwmCv1p8F6mlNOcEb+FI/9V4FraRqQ7NvbdmgI258VacQ0Q
	 zFGQTF2tWhugQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zihuan Zhang <zhangzihuan@kylinos.cn>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v1 0/3] cpufreq: intel_pstate: A fix,
 a __free()-based simplification, and a follow-up adjustment
Date: Fri, 05 Sep 2025 15:51:11 +0200
Message-ID: <5028967.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series is following up a discussion on a patch submitted by Zihuan Zhang,
and this message in particular:

https://lore.kernel.org/linux-pm/CAJZ5v0gN1T5woSF0tO=TbAh+2-sWzxFjWyDbB7wG2TFCOU01iQ@mail.gmail.com/

The first patch fixes the bug described in the message linked above, the
second one makes a __free()-based simplification based on it, and the
third one makes one more adjustment on top of the two previous patches.

Please see the changelogs for details.

Thanks!



