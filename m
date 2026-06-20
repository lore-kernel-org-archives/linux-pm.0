Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4232B640;
	Sat, 20 Jun 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781918312; cv=none; b=XD3eo5kztCd5RdZm/zpUUA+LI+9eqMHWvbPPw93mi6z2i0F2QveLUTab41E/a7KjFvQVgy0y9yrjXrWMoSxBK4ufBWPg6awGTw979qxS9T7NADt8YhLJrM+usJHv0zCAE8FpRhjig9jRRI9yD7R60uPG3+cor61KKPVdJhoyU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781918312; c=relaxed/simple;
	bh=2DQwFU2T+j2hBUyM27HnhXeI08Va+FlH34kCcEhyuh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFEIatYXpgGq/6KH2CjYIa3FDMwJW9y9OVv6Hzi61VUuyPL9z6qu5/XJzgHUPtd9r/GWKx4WoKCC0hkVhCrwQVDcMVmaII15YfgthN04KZepDaM28rx/31y3hoVByg5yArgbXmOmtNQQeOcTFS0yovIiQQGq/VqiwVYvDxnhW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CNnfEP1b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CNnfEP1b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NkgO355oxHbx52T9daCiiOCcvbGcEwWSKsS2xnP61k0=; b=CNnfEP1bIESlW7FQE+dMhMy7o+
	/jqchWG/e45KcBM5SHmzTbv8U7CRVttTIAOMcPuLa5mzTuCka80UPaCkZkZcfwnjzYvBZFqJNp6AB
	MtntCOKOoke2wzKYQ8acP/gZFg99OH/l42JjS/I6KMW/R9f1XqmIIk7u4tkVIrXpeHEQojGBlVWKP
	kI4N6hc5cJRVffWZkNmSBMwNFNitZ04wyBwnqjbZDpYRUKz/ixFQf4A08pR/U8+yfo3YUnMfCPwAk
	UxK1hH8AQ3Z2V5lHuNc+c9v7pcHDfttVhVjmkcdWixxiAVtGphfcUInURMUIdQZU+R5Lr3XIf+G7q
	P7Temlzg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wakLl-0000000375C-3btx;
	Sat, 20 Jun 2026 01:18:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: bd71828: add a terminating table border
Date: Fri, 19 Jun 2026 18:18:21 -0700
Message-ID: <20260620011821.3568674-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a documentation build error by adding a bottom table border:

Documentation/ABI/testing/sysfs-class-power-bd71828:1: ERROR: Malformed table.
No bottom table border found.
============  ===========================================
1             automatic adjustment of input current limit
0             no adjustment of input current limit. This
              helps for more unusual power sources like
              solar modules. [docutils]

Fixes: e92786dd86a2 ("power: supply: bd71828: sysfs for auto input current limitation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org

 Documentation/ABI/testing/sysfs-class-power-bd71828 |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20260619.orig/Documentation/ABI/testing/sysfs-class-power-bd71828
+++ linux-next-20260619/Documentation/ABI/testing/sysfs-class-power-bd71828
@@ -10,3 +10,4 @@ Description:
 		0             no adjustment of input current limit. This
 		              helps for more unusual power sources like
 			      solar modules.
+		============  ===========================================
