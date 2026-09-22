Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0C549373;
	Tue, 22 Sep 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085268; cv=none; b=IcdksoDM2/DK4/t8rKF2aUs7mrnzMHM0uHZ+8HS+vD0UYGrKgKMYfWNjv7H/uZLEfgIjqS2bFm8YJYZiXESBIGN5WrF7IMpG/bi63+D86unz4bmDLzT3fvifAIRnCpMJZD51Cz6Ln/phrTmLlAn3OjES6QVE5ST030A2zNRraEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085268; c=relaxed/simple;
	bh=/Y968tkKCYMv/MhL84T+Z+efM9QuO5rtqXZr1e9p4L4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjQuEaqKORX8fzLgT8rHxlFZOaTwW+Z0CLzzWQiMpTpXRCf4ruajcEQ5WJXG+YIGefsCULZFblNJfAKrDkD4XJX4WtiHwrdL5bWanUzwT/qZZIxFXXBvAmhjSsmsaEJnccQYXZaEO5rA6xB47i/X83+4ieVVO0YrQ+B9KwVo2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMLqKjJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMLqKjJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A281F000FF;
	Tue, 22 Sep 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790085266;
	bh=kMIv7HkKwj9hD+bjxcmy9RE/KqgXTfu+4jimmk8cSAA=;
	h=From:To:Cc:Subject:Date;
	b=CMLqKjJRVnjv25/2WthRi/XtloJJ+9AhvvcQ1GVVrjM04ntXVZjKbHN7Ho6IGbqGK
	 a85XB4x30DyqvDjwhkNZ4OEDUC59mQ4AtP8M3NWp8ie5f3rBiFZQa4RW12gsGHq8Xw
	 5DEc27WVpYRNjtPobtCITfe5d7++41kOg6nXMf+IiqBqFPpxM5TTsvjgdA0On0Smi0
	 xGGvnyhRmmBDGbBqZ/LTvMOrZ/5Kquf1EIyv03eXOhTAhgQ0x41ABhXMJTCajagJde
	 Xx+nmBbU/0dGwwGxiGSwNE2eLcz9h0g0/gaqBdNa0iKJK6ZCDSkzg7WJkGPPiVaW8i
	 l6MEoGt5XEyEw==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fix for 7.3-rc
Date: Tue, 22 Sep 2026 16:54:16 +0300
Message-Id: <20260922135416.1414403-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains a fix for the current cycle. The details are in
the signed tag. Please pull into char-misc-linus.

Thanks,
Georgi

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.3-rc5

for you to fetch changes up to 2cc67425a97eead2e3248b6d5415c13b768ec295:

  Revert "interconnect: qcom: x1e80100: enable QoS configuration" (2026-09-16 15:55:38 +0300)

----------------------------------------------------------------
interconnect fix for v7.3-rc

This contains a revert that resolves a boot failure and instability on
some Snapdragon X Elite machines (based on Hamoa and Purwa).

- Revert "interconnect: qcom: x1e80100: enable QoS configuration"

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Marc Zyngier (1):
      Revert "interconnect: qcom: x1e80100: enable QoS configuration"

 drivers/interconnect/qcom/x1e80100.c | 485 --------
 1 file changed, 485 deletions(-)
