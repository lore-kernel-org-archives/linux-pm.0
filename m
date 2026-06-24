Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3922A1BF
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304317; cv=none; b=WeQrYJ4qBU4FnOY/xaqp4rBS1R70hogBzoanlQ54vT0nO8NvhZizqjQ2rayKB65YWs45qWoGABlJO5Hnwx6wztzO/TUWR6sfB8USRpUqiCN5xL7GRYtUGgOss4/oFPfs6WDfvlm6JSyUIDrbMdZLI+Gkz7fsBN7QdmecXl+Zv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304317; c=relaxed/simple;
	bh=msEno2fcYvrkHE9BPSN1njiooPdxcLdwdyC5c6EtgTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbBAgFbSmFQO5JXLIftsaEto9wQpGqwfcsDOSIeZwQnadtIT3aaDAfGiHS7jT7/neyyPRE17fuYGhuV7aEejGnINlgDUwSqBaVZ7KFfKrh21iF24XKkBTRmWoLlDS1tLzBYrJ7iVUEOonBjWZKSHYnsQgZ7Et1XBun/9SozGd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7RXuR8k; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7RXuR8k"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-804e46366d7so9840917b3.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304315; x=1782909115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfglCRldKyGKtWJv5Dc453U1idIPlMCphiiJzvFVkKI=;
        b=r7RXuR8kmMFkcg5y2jByb87BzTeFW4+kEAoThTtyikxCWqaLe7NjzO17TLwR90yu/F
         FoN9MqkhIO/GkxLLZo2y2JkMOTULFecZMnMdVc1aOXzQ3QnVx2pvDhWmiEWW3DxREuyq
         dN7bVqVe643e7Py71wXOQoDyEaCnXurLFYqJSwEP/nIpqFXSTvJpK0YaHEd3l0mfbOnu
         bBrfM824KzA+c8cEegZfvcteeREL2G6EHG5ABxzvBXmxyyaylqua/5WjzEP4EcvtSBFX
         iGa5ustSia/4zFAHih8NulbQDocVMsad/b7UdDJJ+uIPPgFSWijGOwtNF/mlm7tOZstV
         wzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304315; x=1782909115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfglCRldKyGKtWJv5Dc453U1idIPlMCphiiJzvFVkKI=;
        b=GdYoW/7AtsqieXqL3Si03aEEUIjEMDbqiTbJ3JAOGDzJY5TeeC7qK/2NI8QOCPfJxL
         wdnJYqM7g58IWLENq1dZOF9Rc4HDkUxBH1LeUVFndFOwVJBCL5JZHq5UrZYooYVnM8o/
         aewwGiZalikTTjuwRkc4mGG7bXzNN0vQTisPRSdwbnXXMODLmUHi0dpL6hspUvWz18La
         hO2Dja5a9yyjkU8mGy4ORVRApHmMQhp0c35dnpVaCtH3cn6u4v+xJ+D6VEPXoCQEGjUr
         xffUsMzT8PtA2DyTcnKK/yrRkJ7z2cTvCVc5ZL8UZtPXOrIFeVDv4BSBJvProVa3XlZi
         zAiw==
X-Forwarded-Encrypted: i=1; AHgh+RqMzvKc00N/dCQ1pVdWe94chHsg+5H4o7xLCUNLF3npGJvZkpbxhHcO8Eeg/dOUqqWrMS/DSgp5xA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XXnqpresLOwhAamGRbGgME9bu1SgOwTclzxwGjccI4NxZpTP
	O2RN7eh7c6TiVH0Ya/QTQMtA5wV1eDK6unI0Eq/wOk8TmHjQm7NgVLGj
X-Gm-Gg: AfdE7cnn4fQRZH7ov/ExXq/WLqIHcrA+svwldLdLaBBsKiW0ecQbjw8p0K6QxnU0wEz
	4+LKVl/DN4iEnCXmoZ4yMm8bQO3dvrZM0OyCEUPrDyt27KGDzJ1FXGYZKTtx9BUWq6MgTWU2koM
	ar6Djcduv+k/Wz4YZdC3zllxcppW6wrnsIBqHgvspKIn+eobuFuLMTh9vtrxeEDwcuHzqPviQs+
	Dmee6xiz3V0cNQGqDjK7VWrNxfhS32TZWYVRbgiI97NMrYdxt1enIqTKHL/eanCEG9WDW79ItfA
	e7uKAJrbZiw70LKD0BjlF04R/q2eBHtZ9aJ7NV0oAnW6MydVIhLiGUywp3ROv282EW9bZtTUzJZ
	XS16zANoYWPnpkln/sqC5QwC9fTb5jnW14FnVvscKCHVspSRTS6WeG9Nt3CeNbhaXHxvq9qvrda
	T5AAEiXSaXTVjkFPS2fCwL/uRfyQ==
X-Received: by 2002:a05:690c:586:b0:806:b1bb:75c with SMTP id 00721157ae682-806c17738afmr71319057b3.5.1782304315356;
        Wed, 24 Jun 2026 05:31:55 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8da5fbsm57535257b3.30.2026.06.24.05.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:31:55 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: ray.huang@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com
Cc: kprateek.nayak@amd.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] tools/power: amd_pstate_trace: fix help path dependencies
Date: Wed, 24 Jun 2026 14:31:35 +0200
Message-ID: <20260624123135.7193-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_pstate_trace imports Gnuplot and numpy before parsing command-line
options. As a result, even "-h" fails if those optional runtime modules are
not installed.

It also handles "-h" by printing a blank line and exiting. Use the existing
help printer for "-h", and move the numpy import to the path that needs it.
The direct Gnuplot import is unused, so remove it.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
index 875b08655..b1b201b2e 100755
--- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -27,8 +27,6 @@ import re
 import signal
 import sys
 import getopt
-import Gnuplot
-from numpy import *
 from decimal import *
 sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pstate_tracer"))
 import intel_pstate_tracer as ipt
@@ -260,9 +258,6 @@ graph_data_present = False;
 valid1 = False
 valid2 = False
 
-cpu_mask = zeros((MAX_CPUS,), dtype=int)
-
-
 try:
     opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
 except getopt.GetoptError:
@@ -270,7 +265,7 @@ except getopt.GetoptError:
     sys.exit(2)
 for opt, arg in opts:
     if opt == '-h':
-        print()
+        ipt.print_help('amd_pstate')
         sys.exit()
     elif opt in ("-t", "--trace_file"):
         valid1 = True
@@ -291,6 +286,10 @@ if not (valid1 and valid2):
     ipt.print_help('amd_pstate')
     sys.exit()
 
+from numpy import zeros
+
+cpu_mask = zeros((MAX_CPUS,), dtype=int)
+
 if cpu_list:
     for p in re.split("[,]", cpu_list):
         if int(p) < MAX_CPUS :
-- 
2.54.0

