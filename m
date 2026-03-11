Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7853A1E72
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272000; cv=none; b=rQ0PUKU4ppnQAl/QVFk8YwVZh89zxoh5yPqhYM8T+pw0LjUsqPLN+8rFin63wmnj3G5BsQHCO3ke1JXwNKtaxu8GXU9LOIGJ0clUAGLjQFEFRw8qJOidacn1/bnV45T+669MEU3hNlrkJgC4nDpNdjKGXRqZSVJxjTybx/cRfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272000; c=relaxed/simple;
	bh=hzvJ+OMQ+TXTpmL2YYiB03e6JXyIRYHhFa6Ikr9Wk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmD44Oh2BSOVMuX1ebuhHUzvrD/KT1veJQwPuw+3p3l/PyqC6maHD3rG39JXcaXxfv9gWViaggSFJvlQipGaJVCbNQu/3cb88Vs3Fo/OjXkjLcMNfxtHT0gkLef0K73rJbFsPSWQzu6vZWNXJOGilPHJfFVNP9s50cXDPgl38UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=N87b//gN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="N87b//gN"
Date: Thu, 12 Mar 2026 00:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773271986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AsVJNOg4g3L74ssFwjLvxD72kGr/krXCtxab+JlRXyE=;
	b=N87b//gNuhzPOMRqRDnxwaYjDO0azjdnYS3DbHSEJ+UNdxtD4jWeWpJ4IvC+d422OZSDT1
	uB6Ce8cdmF7aMt2pqsftYARBPCOGVZtSRBGe5ZoSi8FKnfyZzoZK5mWSUZjD+liILzoFfq
	LLgUfywU+AUZTBF2LL7oxTNrXp+b7FnVeij923Ou0pxQ3hwz/mpcqDtLeuFLj3y5PVFjv6
	9E+3NdDxqxB915pBwykuCM1CfIrZp0ANotbX0y6QT4ayyE8roYjwyWeSRcIf1+PVUbLEAM
	RJyUtzl0BgC/0LNcGqugFLlr3KIBJALLxNzXtAi6DyjST7FYM8jaRqn0LbQ1lg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] cpupower-idle-info.1: fix short option names
Message-ID: <abH7pF9p8KxAsHIE@desktop0a>
References: <abHAZj9xwfDf5JVZ@desktop0a>
 <2d96ad0e-4341-4085-b2ed-1ef23e7b8949@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d96ad0e-4341-4085-b2ed-1ef23e7b8949@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

The cpupower-idle-info(1) man page describes '-f' as the short form of
the '--silent' option and '-e' as the short form of the '--proc' option.
But they are not correct:

$ cpupower idle-info -f
idle-info: invalid option -- 'f'
invalid or unknown argument
$ cpupower idle-info -e
idle-info: invalid option -- 'e'
invalid or unknown argument

The short form of '--silent' is actually '-s' and the short form of
'--proc' is actually 'o':

cpuidle-info.c:
	{"silent", no_argument, NULL, 's'},
	{"proc", no_argument, NULL, 'o'},

Fixes e7d85a934182d5bde1eea865169fbf2e0637a3ed ("cpupower: Add cpupower-idle-info manpage")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
v1 -> v2: improved changelog
v1: https://lore.kernel.org/all/abHAZj9xwfDf5JVZ@desktop0a/

 tools/power/cpupower/man/cpupower-idle-info.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 20b6345c53ad..b2f92aba5f5b 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -11,10 +11,10 @@ A tool which prints out per cpu idle information helpful to developers and inter
 .SH "OPTIONS"
 .LP
 .TP
-\fB\-f\fR \fB\-\-silent\fR
+\fB\-s\fR \fB\-\-silent\fR
 Only print a summary of all available C-states in the system.
 .TP
-\fB\-e\fR \fB\-\-proc\fR
+\fB\-o\fR \fB\-\-proc\fR
 deprecated.
 Prints out idle information in old /proc/acpi/processor/*/power format. This
 interface has been removed from the kernel for quite some time, do not let
-- 
2.53.0
