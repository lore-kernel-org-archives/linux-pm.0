Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8538B7A1
	for <linux-pm@vger.kernel.org>; Sun,  7 Jun 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830391; cv=none; b=IKN13LSTcAp9s0LjylV4+VxbOYtFghXEDSXxr3R3cv4hCkkjfxyAwmdx0hFfS2n6GEsHOwKmW0XOHILDVYZqYU2VYu/MPDy8fu2AQzG6ycnyV7Bt++HSdJUu+Sq9Xr5IpHKnVQndgtcddx8fcE+mb/84Z5FxUXwvUZttazNUQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830391; c=relaxed/simple;
	bh=9n4iO9VgRTGZwsOkpr6hqey7LOXePB379ZbrIQuvA+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaOhYC04WDVImq9NO0qhQ3NQyKg7sb8foDsHEM+4XT/mAC4MIpinPINMo2kz40ss9NyQZKObHArA92YuG+PQi4URXwLjq/hMfGLDKEZC2cGj/8rKH9EZ5vaQppUXsWTgpDz7fmz5p/8vKfdDQix9p6ONqK5AavuiSxKIgBG0l1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3irkbsb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3irkbsb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so3383297a91.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780830388; x=1781435188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSHKcQcPLYJJJW+spAIjHqERoe3xOlP4fC68/c2Zs+4=;
        b=C3irkbsbPHz8Wv97rhAowSLGtsJTV3I4qHnEsuf0FSms8YCy+YIm2G3CzLgWlNRhdk
         jF70sygzcRN6MkIxPs5NHzQmucjfe0YtJBOlGDWIMQ86BWcIz0lZjaEJbnw8lZbZWcn4
         fF0KruxEoModhWc8ieW5LQEfWi2+nO42vmC6PKmvo1QqAoWJqeO1xinyqzF9QTHAgxLW
         ABavEYyVig/2ujkNfK19XFnAW6xf1qxTR5WzJlIH4eukR3UrGJamAsad9JwZJne7K/rM
         Jj2H0CShMmS/olCQ/DLrEkPncz8J2vTw7abgmBROhRSmIo3iEv9MFkBp6Z2cbzRuzFWo
         7sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780830388; x=1781435188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSHKcQcPLYJJJW+spAIjHqERoe3xOlP4fC68/c2Zs+4=;
        b=ZPYud4cMqBXS7fIPklEyBPW0nCKFjlL8iPySvFiQIOwr7+zdzpDDC4ndo2kQBjbZcO
         Zhm/D1ofgkrudEbLxwJPjTTJPIgtOCEZSRx9gq0o6zPz52B7ItG3jsPwAct8chwOh2vs
         kVPl8VTjMUL+UZE4F8XJIyDe/Pm0x+z9Hs0Uy02FiHMlNTu8tWokcjO+lXtwWdHvFCOM
         Or3AkVDZsxlFSB2vXo2BSfx5qfrMLPWUGYSPMfvQHhHzXrWOSbZ0ZfKpq3PRXz1KBHe6
         jG41WZjZP8Q9ZWCsFkgA1WW9eAitBZy12pcV6WVeIgxCNjdmSyKSucCXFpixNmpu1Edx
         s0iA==
X-Forwarded-Encrypted: i=1; AFNElJ/RsNrQ/5wiXWtqyL30hnO5tFIMEvpYp1ttKoqzN71m5Yuv+omf4B6cFOIwXVLLZfnD0oAnR2y4ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuEzfyt730UxZmNaq2AcUZfBxpb5Nj6cUUs8s7nsSUSv8QAf/
	6uhCIDQVdr7ViT3shZuS4o+GHTk6q7onwrRr3AfxKrlbhnK81gaBL/VcPo527/ngkpc=
X-Gm-Gg: Acq92OFyhZtDTq9G95EyIOuhjC9lFh0pc/aPCw9HivIwfHY3/0tNa/yKp0fg2FUWBi/
	OfJBwN8xl1oFPVdf7wQovjVheZZBa+ioUQDzky/wHnnb1QokyEk92tFmTPqv9WfbnD9Xlk0AwOR
	ZDfxF+gILx0HdFvoQBn/7bTO2R+LaTf3nfZQeT3z5X99Zzv3YjwA8ZPdO/97pY5L30PdHIoHzHE
	uV3BSSKhdx//nyj5D3L5otAj/xdgJ4U4EIsd4NHtTtkxFsHE7w0+alqAFZqxvxtiFzmWThj+U5a
	765uEBATcnIKH+urTuN6bIMrBSabMJzxE4C+ID25El2IqZgj+QWI9CXNkRzLlBWgnWMW81KyRdM
	RTBDRwUi7SwlIEtu+B+r8HBggsUp7zJoBqVWLjDLxHrabKEPkU9W4KWh3ZXTuR47tBnOEu43zId
	DNOOH+DD5O+4Fo6e7o2AJTvkgziFrcCEcmKigXjIJZVHxAHfyYa/3VcxIek+25YrzIzmFV1WocU
	0OXgbrgfwore63C2CVpR6xwBWH7EmOUz1HVdwKTJTAA1/zBJp9whgvHjbvp53vCPpHCPEF0fVuT
	H/Wfb5v/3k7Ac5MvIyHE+eU=
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr11781488a91.8.1780830388267;
        Sun, 07 Jun 2026 04:06:28 -0700 (PDT)
Received: from debian13.localdomain ([129.126.14.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm12357969a91.10.2026.06.07.04.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:06:27 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: rafael@kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Fix kernel-doc comment for add_rtree_block()
Date: Sun,  7 Jun 2026 19:05:55 +0800
Message-ID: <20260607110555.53248-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment for add_rtree_block() was missing @param
descriptions for all four of its parameters (zone, gfp_mask,
safe_needed, ca), causing build-time warnings (make W=1)

kernel/power/snapshot.c:469: warning: Function parameter or
  member 'zone' not described in 'add_rtree_block'
kernel/power/snapshot.c:469: warning: Function parameter or
  member 'gfp_mask' not described in 'add_rtree_block'
kernel/power/snapshot.c:469: warning: Function parameter or
  member 'safe_needed' not described in 'add_rtree_block'
kernel/power/snapshot.c:469: warning: Function parameter or
  member 'ca' not described in 'add_rtree_block'

Add the missing @param tags, reusing the wording from the
neighbouring alloc_rtree_node() for the shared parameters.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 kernel/power/snapshot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index a564650734dc..cd582be86412 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -459,9 +459,13 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 }
 
 /**
- * add_rtree_block - Add a new leave node to the radix tree.
+ * add_rtree_block - Add a new leaf node to the radix tree of a memory zone.
+ * @zone: The memory zone's radix tree bitmap to extend with a new leaf block.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only)
+ * @ca: Pointer to a linked list of pages ("a chain") to allocate from
  *
- * The leave nodes need to be allocated in order to keep the leaves
+ * The leaf nodes need to be allocated in order to keep the leaves
  * linked list in order. This is guaranteed by the zone->blocks
  * counter.
  */
-- 
2.47.3

