Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623D3BE645
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314724; cv=none; b=jjb1aeANgqRW86VxZ5LAYef/V6zK+jcCKFmEbk5fjaHd8oFgD93LlKxbwpWoIhOlkA4AzuKEcU/2CJYMBChpspwnkLsD1CuBFXHWbBZqdorBqvnsHRruQlmVXuv/9tvJQURSrok2bPRQUQC3LO1qzxvE3xJ73cuiL0Ssgw9gI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314724; c=relaxed/simple;
	bh=UhlOztkQYJQhWlcqUi7jynQrh7lydE2Stnb0sQSiEBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caDkbVAnrpQItH46l+EuRbve4eLDg+euHIimyHB8D4+HVDl23/WrOoQDNLJQphLezmyeT5TVXTLIQSaJTDKI08dNKCEsyRqcZRSh2kEEIX0mAXAIw2qYlgtNLBaZ4kglqVecEFop+V+cNNk+/q853/7K10ajJbgGWvHSPhbDVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 12 Mar 2026 20:25:13 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: rafael@kernel.org,
	akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	pavel@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	usama.arif@linux.dev,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RESEND RFC PATCH v3 0/2] mm/swap, PM: hibernate: fix swapoff race and optimize swap reference
Date: Thu, 12 Mar 2026 20:25:09 +0900
Message-Id: <20260312112511.3596781-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, in the uswsusp path, only the swap type value is retrieved at         
lookup time without holding a reference. If swapoff races after the type         
is acquired, subsequent slot allocations operate on a stale swap device.         

Additionally, grabbing and releasing the swap device reference on every          
slot allocation is inefficient across the entire hibernation swap path.          

This patch series addresses these issues:                                        
- Patch 1: Fixes the swapoff race in uswsusp by holding the swap device          
  reference from the point the swap device is looked up.                         
- Patch 2: Removes the overhead of per-slot reference counting in alloc/free     
  paths and cleans up the redundant SWP_WRITEOK check.

While this approach seems reasonable and has passed basic testing, 
I am not entirely familiar with the snapshot codebase. 
Therefore, I am submitting this as an RFC to gather your feedback. 
I plan to update it to a formal patch series based on the comments received.
                                                                                
Changelog:                                                                       
rfc v2 -> rfc v3:
 - Split the single patch into 2 patches (Patch 1: race issue, Patch 2:
   reference optimization) per Chris Li's feedback.          
 - Addressed Chris Li's concern regarding the complexity of releasing
   references on error paths in normal hibernation. Since normal hibernation
   freezes processes (making swapoff impossible), it no longer holds the     
   reference at all. Instead, uswsusp explicitly acquires the reference,        
   simplifying the overall fix.         
 - Removed the SWP_WRITEOK check before allocation, as it is already
   handled during cluster allocation.             
 - Rebased the patch series onto f543926f9d0c3f6dfb354adfe7fbaeedd1277c6b.
 - Change the RFC title and modify commit.        

rfc v1 -> rfc v2:
 - Squashed previous commits into a single patch per Usama Arif's feedback
   regarding git bisectability.       

Links:                                                                           
RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.arif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d
RFC v2: https://lore.kernel.org/linux-mm/20260306024608.1720991-1-youngjun.park@lge.com/

Thanks,                                                                          
Youngjun Park

Youngjun Park (2):
  mm/swap, PM: hibernate: fix swapoff race in uswsusp by getting swap
    reference
  mm/swap: remove redundant swap device reference in alloc/free

 include/linux/swap.h |  3 +-
 kernel/power/swap.c  |  2 +-
 kernel/power/user.c  | 11 +++++--
 mm/swapfile.c        | 78 +++++++++++++++++++++++---------------------
 4 files changed, 52 insertions(+), 42 deletions(-)

-- 
base-commit: f543926f9d0c3f6dfb354adfe7fbaeedd1277c6b (mm-new)

2.34.1

