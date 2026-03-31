Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869F3A8725;
	Tue, 31 Mar 2026 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984798; cv=none; b=uAEw+uKBmZYLtai/xF7EF8XCvVGfsPITB/axR8WdgL/RjPrAk98+5BXwXEt5ky9t2zqV99TVqG/dakRQeLoo3C6jSpZES7RR09S1j/arpIik9tXGAevFdSjy3YxDJyh/d6JTkIBsOkjNhFPmrTfMFOQF1+45cK6V5/2HFMnyIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984798; c=relaxed/simple;
	bh=rU4RO+U3Z2ols8gbh2cpjwfApBavXFP/IGvQyvz1oaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MzWVcFjSxuD1WCblYImHuhF4X2vh/e1+oscAbJCCZhUxMly+lHYHWvzkD1fwXed9H2fGJgb6skw5br8cAGqgGmlgJpR3pCT8p/jiwKWISHK/4DyjIbmDp/8gbigXY3G9wX1SJIN4DCxm7VMvVT/BZiVEbPGgIQLDa3VL3pP5jaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSr6ZIne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSr6ZIne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFACC19424;
	Tue, 31 Mar 2026 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984798;
	bh=rU4RO+U3Z2ols8gbh2cpjwfApBavXFP/IGvQyvz1oaw=;
	h=From:To:Cc:Subject:Date:From;
	b=FSr6ZIneTaPY8TRqKVNO7dn8aB6fhvQ9nCgLcTf2V1yx5d2m88CApB1pAQCGNEJzV
	 pJ5mn4dV9PYMcqSxTZ0cbD4LDJ29CNuAZ0KuC36AJ6rxOZXOu5GFSytwMvvGQ/p8Sj
	 ReMfVnfW4XMG2Q2vZRRTBrZV+q4PRwPLLizE+RrP6oZ2M6NTG+G3TkONOSjW4I2yzD
	 INrA2LJrpbROhPFyX1amWvsnfB2GbK8KuETN/CoJ32ghHazVRp3WT7Q7HGAB3l45ZE
	 cuFtPlmW3Cjg25AqXhHk35FElzU5JoYz1GW5yklIT6xDSmwou0oBF7WvvoHohfh+Zp
	 rE6ATmvHp4UJQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 0/4] thermal: core: Simplifications and suspend/resume relocation
Date: Tue, 31 Mar 2026 21:15:54 +0200
Message-ID: <4745677.LvFx2qVVIh@rafael.j.wysocki>
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

This series is intended for 7.1 (it applies on top of linux-next).

It removes a redundant check (patch [1/4]), changes the thermal workqueue
to an unbound and non-freezable one (patch [2/4]), relocates the suspend
and resume of thermal zones closer to the suspend and resume of devices,
respectively (patch [3/4]), and changes the allocation of thermal_class to
static (patch [4/4]).

Thanks!



