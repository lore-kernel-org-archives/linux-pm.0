Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49BA285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355268; cv=none; b=fiblwwQmC+RmfhTnaJ0PnFQstwptW9Y2+AzR0sZGjT+5M9jRkC7BwnXwNDGyXYQeP9ThwLtEZt3PjpnihTiZYPbm4yLsonqlhhx5rhfkOICzjOcNsPTE2ELubNavr6Woz9spgMBWyOOJODP/rD+mykzy7S+T+gjYzxz0aKYbxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355268; c=relaxed/simple;
	bh=uzo2nC2nYl58ycWxJ5IYaR9ImHyR05wBnnFpPzYBzPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GJAa8sehqExZXF+1WBfszXWwWan3g8ZyUNrgcF8jMV+zEApF4Vn8RE96PCbkVYUjfRswE/aa0GfTuGrSmk13ttHU1xKrE0cnAbxWIMF7MDpe+b1JGPPO2Gf510i4LfoBw4bd+hn1yh3EOogXec7YjKmT2cB5IGpgWNKrYby1xDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl1vJ8zu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl1vJ8zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7727EC4CEF7
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355267;
	bh=uzo2nC2nYl58ycWxJ5IYaR9ImHyR05wBnnFpPzYBzPo=;
	h=From:To:Subject:Date:From;
	b=Xl1vJ8zuohtyu0pXwl1njuexkwOPBQcXeYK0d9lU9/0+Yq5+APSWGN/lzhXboXMxd
	 482Ynj8Gcm95m0KHSsjNX6JwlCpHpLMbsGc8iywmBCla27FQ1EUzmcOqBcVp+zoa6V
	 8Kt4gNn3tYKxPcVk09pnoXaPTGfO90njL1hOwDY7Z5AUjKDdVWEGmolim7koOiKc3D
	 Zzv1j//0QIO+XY43kM+z00h9QZRFDMOn2F2fgG7vb1YE7stT04HLhMhyF57ic2uFhN
	 nD7AK4hYDoj0TtIewpPWDB/3MBIL32ZdudaBBmjOOQEfDXjJlxblFz37QXXwqt5Hhw
	 ksStGL3AHW+GQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/23] turbostat v2026.02.14
Date: Tue, 17 Feb 2026 13:03:51 -0600
Message-ID: <20260217190740.666230-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since release 2025.12.02:

        Add L2 statistics columns for recent Intel processors:
                L2MRPS = L2 Cache M-References Per Second
                L2%hit = L2 Cache Hit %

        Sort work and output by cpu# rather than core#

	Minor features and fixes.

Please let me know if you see any troubles with these patches
or in your use of turbostat.

thanks,
Len Brown, Intel Open Source Technology Center
