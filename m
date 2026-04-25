Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A043947B0;
	Sat, 25 Apr 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142875; cv=none; b=uq9EMAe287ldYhTJ/Ot+C6Cmf9MPG+eI7m3zXvI3ajdheZKEqMS6hzDFr8tWb++bT93QJS2rmbK291odEDcqbmrgnoJPipUvzIb9be+fIB9O6o7FQKoV7IPZ43a587aWG6FDLGw/yllUFgPlzUYIgj86OgWzmEgIjpdQVtnzO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142875; c=relaxed/simple;
	bh=OCrWVqIWEkxa47w5CEaqAQKI+mes/rwBIR1XS3eZgx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht5VMgRFCJqGIQIcKRGxknJTLOpK2aJSCWng4ZVldTgYJVaWWKmv1N3g3gKQeJdTr4sq1ccKRqKYPZ3S8+ocScJkM3YK1mQcQ/lxHBG+o/EwexfAkgaJVncyEkpCzYL88vg2ZlssJKtjbkgioOxnrtPdNav2d2clP92KQTsFfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j13uG9iB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j13uG9iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0DBC2BCB3;
	Sat, 25 Apr 2026 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142875;
	bh=OCrWVqIWEkxa47w5CEaqAQKI+mes/rwBIR1XS3eZgx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=j13uG9iBo2V8AzkqLoWPpBiGFg3pdYe8btl8/mXVqeWyNQ/HIkESkSdASERiU2fbU
	 qu4jVBtqjOk7NC2qlYKJ1soGBrvY+TiD1LTkmG2FDKnKmE47l0vbYUpfltLuR6HbRu
	 asUpgjYXWPqNgag8Zy0z4W0EJwNjRQQ56gzhfIL3CeWc72LypE5MoZKxo+wxMyRWrW
	 InfQKiET9W8fupcJE7gvhbRLFlO6c9aCb8GeWZvOw/oykRkNWYqXv4JZnUqjBR7zZw
	 HuU5875a6nZGcIUKf7hr1WSydjo2y9YoWZ19Ms5A6j1xqVWS8cEE3N8fZS9m6M59mh
	 C9Q0xJbUc3A8w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] tools/power turbostat: Print core_id and apic_id in hex
Date: Sat, 25 Apr 2026 14:42:10 -0400
Message-ID: <da828b6cafc103119b971290d44db5f33af7924e.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

The core_id is based on a mask of the apic_id.
Print them both in hex, rather than decimal,
to make this relationship visibly clear.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 624f54ee1ad8..b27227414dc7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3214,7 +3214,7 @@ int dump_counters(PER_THREAD_PARAMS)
 	}
 
 	if (c && is_cpu_first_thread_in_core(t, c)) {
-		outp += sprintf(outp, "core: %d\n", cpus[t->cpu_id].core_id);
+		outp += sprintf(outp, "core: 0x%x\n", cpus[t->cpu_id].core_id);
 		outp += sprintf(outp, "c3: %016llX\n", c->c3);
 		outp += sprintf(outp, "c6: %016llX\n", c->c6);
 		outp += sprintf(outp, "c7: %016llX\n", c->c7);
@@ -3423,16 +3423,16 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 		if (DO_BIC(BIC_Core)) {
 			if (c)
-				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].core_id);
+				outp += sprintf(outp, "%s0x%x", (printed++ ? delim : ""), cpus[t->cpu_id].core_id);
 			else
 				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_CPU))
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->cpu_id);
 		if (DO_BIC(BIC_APIC))
-			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->apic_id);
+			outp += sprintf(outp, "%s0x%x", (printed++ ? delim : ""), t->apic_id);
 		if (DO_BIC(BIC_X2APIC))
-			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->x2apic_id);
+			outp += sprintf(outp, "%s0x%x", (printed++ ? delim : ""), t->x2apic_id);
 	}
 
 	if (DO_BIC(BIC_Avg_MHz))
-- 
2.45.2

