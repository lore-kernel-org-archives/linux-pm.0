Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A8381AEB;
	Sat, 25 Apr 2026 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142872; cv=none; b=idd2iLUs1SnZ89fdM1LTiXs0G2rP0oHKiY7Y3XV8cFCUW7QjI6SYsj8MnAU9LF1DMFvxe+XpYAVBS88p4CR2HFPyVPVW7MBcOdBZtlDnbaPatbRICXD01nAok/Txiq3YNqRPQtqnwRDD6/yNzAJ7sMsbewLFs13XH3Ql2lD2xhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142872; c=relaxed/simple;
	bh=Bmoe41L+XmEK7pymrV2t3RidvsxMvzgK1dUmPuLL43k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxmLM09h033UkAi7aoQlHfDEItUl7aXcfs74j0o+uh0dC9j1OVj94UFDeI3z12Aiydy6QZuc7EINP/xjpXK1ZYt036j5EYnbMEpPNeLKkyllvDw1kcRy7UOvZ2KsPUEWXuZQsOGOz/yKRw7+LfXkGjnWcRCehLdxE5MPsTf78vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9fWlde/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9fWlde/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3B9C2BCB3;
	Sat, 25 Apr 2026 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142872;
	bh=Bmoe41L+XmEK7pymrV2t3RidvsxMvzgK1dUmPuLL43k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=r9fWlde/p4+fnYky7YivaWPDOzRJi2Lb2KrUiNr5lJXeY96ouD7H7WHs11HMWdWz2
	 hwuUT7pDycBbyRJVEMyfn/jYy4u3lzsV54Ac3sVYpfDsCLn6zjwQ2fdrsGfypAh/gh
	 7Q6Nnus93C03/3M4JzfVkTxKoHjUzEia2IXfGcDKKACtu1S0q2BMg7HG4nsDmdgWIz
	 HcaKy+A5g9LGMCSNX5fRzbm5gnKxGW2c1OFUSElQbtk7Tu5WyJuKH6XoGuTPjWU/9s
	 hS74FoOgG8rS05BrSI8HqBkgvsOFl6JfqOhigVBLLZVWbvPuDqvonoQ0uqzwTWegT0
	 40s6HFgjqUfxg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] tools/power turbostat: Fix unrecognized option '-P'
Date: Sat, 25 Apr 2026 14:42:06 -0400
Message-ID: <ce012c966b518c53475ba9a4e979242d7322d819.1777141988.git.len.brown@intel.com>
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

From: David Arcari <darcari@redhat.com>

The '-P' short option (shorthand for --no-perf) is not present in the
optstring of the second call to getopt_long_only(). This results in
the "unrecognized option" error when the tool reaches the main parsing
loop.

Add 'P' to the second getopt_long_only() call to ensure it is
consistently recognized.

Fixes: a0e86c90b83c ("tools/power turbostat: Add --no-perf option")
Signed-off-by: David Arcari <darcari@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bea574d7aa68..d6b4fd17c5f3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11449,7 +11449,7 @@ void cmdline(int argc, char **argv)
 	}
 	optind = 0;
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:N:o:qMST:v", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:N:o:qMPST:v", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
 			parse_add_command(optarg);
-- 
2.45.2

