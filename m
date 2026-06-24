Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423326B2CE
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304076; cv=none; b=rDZPOO0iBZuCG/iCii53cbF1q8lmXu2A2rcTWNVKy071bY0HKB1/ET547cMaBrwEdGB/GnNiZS/5gl7k2XLVtZoeCuoh8886PdWt0/J6kupDfXbbo9IEZWBdWn2oPOgq+XnUg49i6n+atb4IX+Ax21yf1mH0zjtgL4kBIQQx2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304076; c=relaxed/simple;
	bh=YYn8mVTTcYIWoMMAkYFeYKlkTCV34Gl2CDeYSuYyTcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljx1hr5ceyLPGbysTqluaXB7Quen/jpz0M6Q/JTkkVpOTY5aShB+x9KnPuxGQP2kfRzPwSnD6lO6uhU9jQjCsgsn99JnkQteToWtoV8Q66c3z5ue+pEL4hFqh92+CQR5GSoW+KJs74E5LLAmJDVBs8/EtuEPn/ZtUThNCW+dywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1bX1bqS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1bX1bqS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b64c8311so12315185e9.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304074; x=1782908874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5CaDsK+4P6z3PRLs/CvELpKeDh2G5owhoOE7oUsOIuo=;
        b=Y1bX1bqStu1ZIqbJV7TqQc7MnTDSZR5VfqmXhKfKVNPaSBZgg8e9/YD/QSlvqeO0DX
         BEBbatw/QuiD/5f526DAaq98xpYLUP5Id70xj0gPFZAZO3VuVtdGoeRo+KRmtTgb8Vsf
         F4cy6SLl4bIFlayIbwaTV0mshFysJfidu5UJ0nZSlDJV4m+4awQrqelHpmfjHAMrjKCp
         +9GkZcEHkb8mEN8ySUaF/4CfOrh6+BC3BmnlEeFuWCFZewtpnJ0B+Gminw1vMnyh94oo
         qbYCfmTQDSrbfRSq9lLryRg0js8WZjv6eHzhzcQiyuIX0W1zAPdusLHBdWYyOJa5Ew2V
         BmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304074; x=1782908874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CaDsK+4P6z3PRLs/CvELpKeDh2G5owhoOE7oUsOIuo=;
        b=JLWLhpt2nsOzsNQjvaFWJx8sezgeU/B7mgQEpYq8wcytlQ4aeQ4AaUrupLuPSjhVwT
         BMAKvV452Q5igXJbt5zhkueMUHmmx7zwIR/INbvAoNdKRnuCoi6yrSDrLSvYV9z7bB+n
         nwlEmfaOxhtuYlGp/EgbVlPV1vMCpbBov6giXHcSUnMXOopkguxbvfTFvhZhxZSlwB/R
         WIQNnQxhHAiqO/u75uNTizbweCIf/DYJhNRy9F9dgVgjG00FkI3IYBM21MxWQ/H9mH01
         htQ9dTDsCkpoRrn5+9B7lMdik4Z+mePGCUiLcOls9yQvIA5PBTxnThPQZFsIxK9gjLzs
         YSag==
X-Forwarded-Encrypted: i=1; AFNElJ+cRNDLGoZOSl45DxjngaU1QH62nkp3eQfIrpujE9sykYn6Ze9/xX4ktyzQBC++1K86kzgGcQMkpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8B93iw7/RDDm1OLc62MhiWJS7ayocEY4MQfJ9eexd34XwyE9y
	xsCs2P7BeKGkfzQLZPqNc3XP9uJz5cYTKlsxYbV06rTinjsLZutPyo4X
X-Gm-Gg: AfdE7cnTU/jqmalgsjlB50c8yzf2JsxVeKpw/vBiPnuMTUdWoywY5yvc8lDgDHdGSQO
	siY8ePnRJlp4cFMYB81mxAuONOSAIDkWTXLloTj2mwQ5uM5nQ4/dt0c+ppahrcNSUXmz/2wYFsq
	7StJ7ucEzPr7iN2PUty8ef+v5tCztUIOHMvWc+jD+4bo74hs9O28pkgVf9kUDXihj2iY2+Bmszt
	guwVWqBBwSu13hBOLcE21KlamLS6Y+olAxKJYDOM4mosHynwzwkbZ40trR+WSPFL+2UWFuNuAOO
	j0NJXucs93EqR1TS5fUTuxGMJxmX+fisiGEIFE3T2XeL+Lwb/PDETwCA3vYiTlP3LUC/ezMMkBT
	UAb4iq/mIsmq8lHrCdfwTa4G1YE7Bw5BpPvzplpoHdWDoB95yxRovb4Kxv67HzDUTIuT95z6b7Z
	8bJF2DsY+QLbq4oGSt/Tlz3zE8KQ==
X-Received: by 2002:a05:600c:4f93:b0:492:455e:a161 with SMTP id 5b1f17b1804b1-4926086d0e8mr44105575e9.20.1782304073202;
        Wed, 24 Jun 2026 05:27:53 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249455302sm373253855e9.15.2026.06.24.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:27:52 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] tools/power: intel_pstate_tracer: avoid optional imports for help
Date: Wed, 24 Jun 2026 14:27:47 +0200
Message-ID: <20260624122747.5418-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pstate_tracer imports Gnuplot and numpy before parsing command-line
options. As a result, even "-h" fails if those optional runtime modules are
not installed.

Move the imports to the paths that need them. This lets the help and
invalid-argument paths describe usage without requiring plotting/data
dependencies. While there, fix a typo in the help text and matching
comments.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 .../intel_pstate_tracer/intel_pstate_tracer.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 38cfbdcde..64001bc80 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -32,8 +32,6 @@ import re
 import signal
 import sys
 import getopt
-import Gnuplot
-from numpy import *
 from decimal import *
 
 __author__ = "Srinivas Pandruvada"
@@ -88,8 +86,8 @@ def print_help(driver_name):
     print('      kbytes: Kilo bytes of memory per CPU to allocate to the trace buffer. Default: 10240')
     print('  Output:')
     print('    If not already present, creates a "results/test_name" folder in the current working directory with:')
-    print('      cpu.csv - comma seperated values file with trace contents and some additional calculations.')
-    print('      cpu???.csv - comma seperated values file for CPU number ???.')
+    print('      cpu.csv - comma separated values file with trace contents and some additional calculations.')
+    print('      cpu???.csv - comma separated values file for CPU number ???.')
     print('      *.png - a variety of PNG format plot files created from the trace contents and the additional calculations.')
     print('  Notes:')
     print('    Avoid the use of _ (underscore) in test names, because in gnuplot it is a subscript directive.')
@@ -295,6 +293,8 @@ def common_all_gnuplot_settings(output_png):
 def common_gnuplot_settings():
     """ common gnuplot settings. """
 
+    import Gnuplot
+
     g_plot = Gnuplot.Gnuplot(persist=1)
 #   The following line is for rigor only. It seems to be assumed for .csv files
     g_plot('set datafile separator \",\"')
@@ -343,7 +343,7 @@ def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _t
     graph_data_present = True;
 
 def split_csv(current_max_cpu, cpu_mask):
-    """ seperate the all csv file into per CPU csv files. """
+    """ separate the main csv file into per CPU csv files. """
 
     if os.path.exists('cpu.csv'):
         for index in range(0, current_max_cpu + 1):
@@ -482,7 +482,7 @@ def read_trace_data(filename, cpu_mask):
             if cpu_int > current_max_cpu:
                 current_max_cpu = cpu_int
 # End of for each trace line loop
-# Now seperate the main overall csv file into per CPU csv files.
+# Now separate the main overall csv file into per CPU csv files.
     split_csv(current_max_cpu, cpu_mask)
 
 def signal_handler(signal, frame):
@@ -508,8 +508,6 @@ if __name__ == "__main__":
     valid1 = False
     valid2 = False
 
-    cpu_mask = zeros((MAX_CPUS,), dtype=int)
-
     try:
         opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
     except getopt.GetoptError:
@@ -538,6 +536,10 @@ if __name__ == "__main__":
         print_help('intel_pstate')
         sys.exit()
 
+    from numpy import zeros
+
+    cpu_mask = zeros((MAX_CPUS,), dtype=int)
+
     if cpu_list:
         for p in re.split("[,]", cpu_list):
             if int(p) < MAX_CPUS :
-- 
2.54.0

