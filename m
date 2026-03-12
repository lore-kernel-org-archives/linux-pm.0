Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45A3A6EF5;
	Thu, 12 Mar 2026 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292487; cv=none; b=N4YseUn6KPcHQGjfzlXWBOUL2mXHVxGZqRUAnjj7EMKoz4WkmG3r9uXtgmO3nYmnWMbO941TdmnjkGlvNQpeFaZOvaTXi0XRZiQpHWtwKjSLbEVlOM9jW6XjbeYcpEluPJ3CPgv0sBNExX51oXdzsP+OdLvu1W6cCSfxwv4WS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292487; c=relaxed/simple;
	bh=GxTLdT1K0i8HfwVg3GtIBm3TApfYT3ThPizXG8Vv7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERqvGbPmigecsOgZ8zVemX3D20sFEubiqRTkQN4DTwKiWNiUh5YTL2YyQXlo98uU0zBRzWxd7s23TNNpBHyQpyKHw8Ct3yWd5s3ih51/ZR9Zy78LxrHjBeHqO3ec2iq8OCUQksA7lfoLx/TvTiqWmqEpOcCl6oZjgylSTqvfVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=5D3Ubcgm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5D3Ubcgm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xqYLAeN3Aysc0E9AWBtz6kAuwkJM/LO3v+YigKHmvuc=; b=5D3UbcgmRPfXYA9xNzdnhC9LqH
	KwpD3xh0Ki8sJGe9EZbeiV8uYB8YBfXgt/vZNiRR4Tb65eB9kuST/KD7bb62kWLN9+waHCE6ni23h
	Nxf2uO9x6scnYwna2taj6BKVS+qA7XGHj9Bu/WcX93GCcDWM3zSinnNPbKJ7rNNjPQNtfsyD7B+aH
	9cSLRVglWhqolu4klZqOxoaY6l/cuvb9fq3hUrSQ/dzSxFaJlEd2VnKyTy3egit2caEviwKyFmCHL
	Ia9XVYjn/UbWJVVNyLEitZYjpAUQyKd6DPtf/3+uK5YwFo/YgLjXvRJQfbPp6wTG9rVQBy5i4+8Fd
	+S9BkevQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YNg-0000000DLEw-3pgA;
	Thu, 12 Mar 2026 05:14:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] powercap: correct kernel-doc function parameter names
Date: Wed, 11 Mar 2026 22:14:44 -0700
Message-ID: <20260312051444.685136-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function parameter names in kernel-doc comments to
avoid these warnings:

Warning: include/linux/powercap.h:254 function parameter 'name' not
 described in 'powercap_register_control_type'
Warning: include/linux/powercap.h:298 function parameter 'nr_constraints'
 not described in 'powercap_register_zone'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org

 include/linux/powercap.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260311.orig/include/linux/powercap.h
+++ linux-next-20260311/include/linux/powercap.h
@@ -238,7 +238,7 @@ static inline void *powercap_get_zone_da
 *			Advantage of this parameter is that client can embed
 *			this data in its data structures and allocate in a
 *			single call, preventing multiple allocations.
-* @control_type_name:	The Name of this control_type, which will be shown
+* @name:		The Name of this control_type, which will be shown
 *			in the sysfs Interface.
 * @ops:			Callbacks for control type. This parameter is optional.
 *
@@ -277,7 +277,7 @@ int powercap_unregister_control_type(str
 * @name:	A name for this zone.
 * @parent:	A pointer to the parent power zone instance if any or NULL
 * @ops:		Pointer to zone operation callback structure.
-* @no_constraints: Number of constraints for this zone
+* @nr_constraints: Number of constraints for this zone
 * @const_ops:	Pointer to constraint callback structure
 *
 * Register a power zone under a given control type. A power zone must register
