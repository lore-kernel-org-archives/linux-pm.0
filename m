Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2A1553B8412;
	Thu, 13 Aug 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611733; cv=none; b=lA2+cKIBv5BT5ZJfb5HGhir111qZyGCP+KHUPHvf3F7fHGeLrpAn732tWevz+ycyaCpkMxNLqnFWovcp/2ZpfZHUGu+wWwL9gJxunL8dajVHLcTCSqKpLAA0byX2tgkQ/uqqwEFsjb8iEud/2uOcP/ee7Y2EWHCN5JYz+kUl418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611733; c=relaxed/simple;
	bh=Nd+39zbSz04OcaIPREIPApsh3yAnuqENsgALSyaRRwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uh6ba1vdSrjD+rwz052SQ75SUhOk5XXR38R4RcTmPDc5fNb1CPMxWy4lIzSUtX8TwJhSu2gN0y4owCCfWii9h/9AEkQ2HU5KtdpH/Sco/xCqeHUzqo9qbL5nxcbebhyV6Ji/SLCbPFMAi1XKBqnHAP3AmT22F3D6DjlZ5B5vuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=BVBfyMCe; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="BVBfyMCe"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in freq lookups
Date: Thu, 13 Aug 2026 17:01:43 +0800
Message-ID: <20260813090145.2450-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1786611715;
	bh=iDTBOeDusqfF169uIbOJ5a6uq4uE0XR1n89rkL87AlY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=BVBfyMCeZX2FBv6v/tMcGirW3YV05JeAXowo0if+8mueETwugk0NePje1M0eVonFa
	 SW4lPJzRXs7KvjhDtAHOwu5VYVOLY2cu6acHubXvbkkXrkRvVMhTvS0moMWUzHYnbn
	 G5a93tkKh8G3g37Dp+wGx/bYW+/OmeZezZYMEIgwywZUWpu/Y0YNn0CTFVOVCfp5wv
	 7e4vfbJIJ6ApXxwv7sWR/nUM42FInBls8R/uGQLRPdFgQcEAoyktgNLjyfJevwly49
	 BID/S66T4FJ9lLvSHeEf1A6cJk2GmiQGCvk1EGoRFDlpHyS7BB3KZwoEScR5jLaNgO
	 XdtXPkz4euN+A==

From: Li RongQing <lirongqing@baidu.com>

policy->freq_table is built with duplicate _PSS frequencies dropped, so it
no longer lines up positionally with perf->states[]; the original P-state
index is kept in freq_table[].driver_data. extract_io() and
get_cur_freq_on_cpu() indexed freq_table[] with a perf->states[] index
anyway, which can return the frequency of a wrong P-state.

Changes since v1:
- Reword patch 1: v1 described it as an out-of-bounds read, which is wrong;
  it is an index-mismatch / wrong-result bug, not a memory-safety issue.
- Add patch 2 for get_cur_freq_on_cpu().
- Add Fixes: tags (not exact, but reasonable backport targets).

Li RongQing (2):
  cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()
  cpufreq: acpi-cpufreq: fix P-state index mismatch in
    get_cur_freq_on_cpu()

 drivers/cpufreq/acpi-cpufreq.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.9.4

