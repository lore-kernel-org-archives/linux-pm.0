Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896D338595;
	Mon, 18 May 2026 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140077; cv=pass; b=r1lBtnoMqJhDnEWKbWaegShCZ6Qi8dN3eLVQ5MMfKjHe0uj0yqn52g3PTp4PpmTMvhffumSxqhwa39P03F0qH3ppeQfpBOduPBV0X2VdI49GTnPtYZd/ET4myz+5uLXL3ngwu5xtUJAvFfScXXBHqowRTFkveFxhVfy6XcLILDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140077; c=relaxed/simple;
	bh=lWIzp3vvJIeDqLjX4kWSI2PRVdFau1e589Z48c2tOQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=geAThD2r5TTSPHDF5bvnZRLzY6JjPc+3Try7ekh3hwDVHqgjwuuqlVSUABQRN4AodW8sLg+I7EFTCLUpn45JYb7CIjTJvi+1Szz1IuD0fEKdvuS7MPKJNAfYn4P/3heQTesaLDbm1HMYam36WFi2jDXuulBgzP1KqkuUn+mKo2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=QjfH9XXE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="QjfH9XXE"
ARC-Seal: i=1; a=rsa-sha256; t=1779140066; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JMmAAcwFqmJh9/sZfYlGV2zqzBJcxUDx74rZj9A6bF2ugB2HWmjk1YfxYSQdWlxU3dwz8Hdh+0az7E8AGrwcJtgRSyG/wdqZATxS+czR34JA0TvadR0Fc5huWi04jYkeUnk8XUU4w6nzGMFTQSYE+bnB8Lv0zrO+9w1MjiWmq58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779140066; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LTCH9TXT0XwlS0+O4cJ4YYCN2nv8Wvt4VjgkwMncoi8=; 
	b=OcVt8XLN21LDCyPUcPdhu/HjH6jumh9x2HX6CVnHfDN5aMx3u2MOQbbMVK/vckzV9ZUoHmJucgfGFauBjVlMUldWtHAWcUBL7lIv8aGzyqKmCsYI85y9+a+9+k424JnTDuvOEWBHU3t084g7GoDedoxNGuJ9aDovvlHewOYXYE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779140066;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=LTCH9TXT0XwlS0+O4cJ4YYCN2nv8Wvt4VjgkwMncoi8=;
	b=QjfH9XXEUmw7pAubOeefpZLSxI2fsYun5JJPr+xWZRnJQms9WwAoTDkbnGOhxsYi
	/Gdgv7OAtWZ5gKb2bp1Kod3zjpdfwjuKR8ZfGsqBEAQz2bf1dfho5r+Ff3hjHAir7kB
	vQHvZPQeGlSSDZLiAaysemqHqQuLyrc8D1Rnldb0=
Received: by mx.zohomail.com with SMTPS id 1779140064601311.25569361019257;
	Mon, 18 May 2026 14:34:24 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/3] Shrink time spent in copy_data_pages()
Date: Mon, 18 May 2026 17:34:21 -0400
Message-Id: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN2FC2oC/x2NQQqDMBAAvyJ77oKxGmy/UnpYk1X3YAy7obSIf
 2/wODDMHGCswgbP5gDlj5jsqYK7NRBWSgujxMrQtZ1vBzfiKhNrolI9jByUyRiLbFVMGPb8w0i
 FMNPChvOjvw+j6733E9RkVp7le+1e7/P8A5I+oLl+AAAA
X-Change-ID: 20260518-hibernation-decrease-time-in-copy-data-pages-f9435814666b
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>, kernel@collabora.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

This series shrinks the time spent in copy_data_pages(). Patches 1 and 2
are to ease debugging the time spent in that function, while patch 3
does the actual work to allow it to be shorter - based on a module
parameter since it has drawbacks for uncompressed hibernation images.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (3):
      PM: hibernate: Print speed statistics of copy_data_pages()
      PM: hibernate: Add platform_enter hibernation test level
      PM: hibernate: Allow disabling zero page check in copy_data_pages()

 kernel/power/hibernate.c | 13 +++++++++++--
 kernel/power/main.c      |  1 +
 kernel/power/power.h     |  1 +
 kernel/power/snapshot.c  | 42 +++++++++++++++++++++++++++++++-----------
 4 files changed, 44 insertions(+), 13 deletions(-)
---
base-commit: ed46b8c4c78fc332340a084eceeb10d762a9cb6d
change-id: 20260518-hibernation-decrease-time-in-copy-data-pages-f9435814666b

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>

