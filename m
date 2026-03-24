Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4A405ACF;
	Tue, 24 Mar 2026 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366114; cv=none; b=u6dKT53R7t1PhabpZT1iZvqys8pUazELzT1F+ma2HwvSpFoGj/nfGBfv6coJLl32SaysOg40UIFVWHy9Dt9Xa4o95XrQcMherJfauikRMWsbcVq+AYq7/uF/AeHwosW+ycU+pxIUqE7tJ0c+hJGGxMSEMsf+F3HvmQEK6/6BKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366114; c=relaxed/simple;
	bh=Erk0Z+oFBoCIy5qgAtpk3T3fx1eO8EzbAi0XPyAZBSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jS4zIWQ8dYfQvdUOLdcKmWGw/qINFxbbPlUBiu7RVVd90vXade3YWTgQsIPebxlbvWyN+emyVluLFR7LSdIZ4bBcevyGMytc8vF1Dh9uQ8S3mnH9XXeMDzdZWuV4QiOSNPI5sNtywFuYHNtxgpdmsOyRI3p0uu9kDq+dC/dNpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJf/KMX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJf/KMX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DFFC19424;
	Tue, 24 Mar 2026 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366113;
	bh=Erk0Z+oFBoCIy5qgAtpk3T3fx1eO8EzbAi0XPyAZBSY=;
	h=From:To:Cc:Subject:Date:From;
	b=WJf/KMX32RqbCRg5RcFqjpzopDOWVT5A8zoUnRkmt/joDXimHSg9iDNbVxlGxA/WD
	 qCfmrE7/Cw4pfJpkmAeNFEz1oL9fsZvzH/GxWtvMnm25+UUBb+1eA11+YdidajmR2S
	 JNpM5KVF244sngjVQBSoiredigt0EZYzNNFCiLY/dqEnon0JTCTtYQP3tfjuJ5H996
	 5XCcqeroSCsNOjgA+LMeo/R16yaysBOeyZh2gZ+qS2Eeh2yL0ID8GTH7BWTHVqNzWb
	 jCYRQrihvRmSS1HPWf70ftz3lKE3X18Q/yoTvjseYs5cEpSHBaiq/azxCMt707wsRT
	 qoCzKKrh6syQw==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fix for 7.0-rc
Date: Tue, 24 Mar 2026 17:25:53 +0200
Message-Id: <20260324152553.612127-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains one driver fix for v7.0. The details are
in the signed tag. It have been also in linux-next for a week. Please
pull into char-misc-linus when you get a chance.

Thanks,
Georgi

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.0-rc6

for you to fetch changes up to dbbd550d7c8d90d3af9fe8a12a9caff077ddb8e3:

  interconnect: qcom: sm8450: Fix NULL pointer dereference in icc_link_nodes() (2026-03-14 12:53:13 +0200)

----------------------------------------------------------------
interconnect fix for v7.0-rc

This contains one driver fix for the current cycle.

- interconnect: qcom: sm8450: Fix NULL pointer dereference in icc_link_nodes()

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Vladimir Zapolskiy (1):
      interconnect: qcom: sm8450: Fix NULL pointer dereference in icc_link_nodes()

 drivers/interconnect/qcom/sm8450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
