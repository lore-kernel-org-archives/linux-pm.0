Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9530C361
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256863; cv=none; b=npOBdo7I+lBdkQSMENQJsaBNzXXcHi6Qrg+HMNYZhRt9cA20GUpLA4qlMRIlqo+W+jcEAhPvynVQ0iNbcq7r3HWRWkyno6zPtz45fllGV4/DCLYce01mTyHD6fxqIMOhv+FCTQYo19x+7f5ZyzAU04py8zZ9Edidn2IQIeL9lXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256863; c=relaxed/simple;
	bh=4PNANGKrL6wyiWBku1J3+1406jvUKTY1qpyO9Vv8BkQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MVz6lXd7Zo+A0MJ4f4WEZXYgRwc3MlV5Hy44f6vjqizB+IUs6vsIkbijzK1tY0oESof9PHKSwQPz4KrcPeUfE249ASHXOIdBNiL4VxbJpWZDyvhmShn4Qp7JLN/cW4/DwSt435DfGl9qF1sf0hBQY94MCBAnnlXyOoxdzfOFuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=SzXes4Au; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="SzXes4Au"
Date: Wed, 11 Mar 2026 20:20:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773256860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=yqtkHnIrf341gEZ7zROn5gAlNqNqcz45TskoydCYQvk=;
	b=SzXes4Au0pGKQjujlpABb2S1VCABFIUDC9t6UNN9afcgi4rEyejTcI7pgZvlEEcNIvqORo
	5JN7D9prGA/Zba3GR56+S9xfhXISnwpUWTVshMXVXZno1uh4s0E9ym9b/vLcW2ritiw1R/
	3Rehv4p+bg/eDs+UW24GwIeHG1UCUDdkXARifjpLQIKtq7ysJpju3CxQOmR5JkHDCSP2LZ
	GeV2sbuXj5gmMQEDUNbr8mMtKpHg87LAqxxlcgLS+Tr8zgG5LsCLD18FSuh3lpenUH0ozp
	+kv7fr49gNZrJc3Jhhose+dMjM1zXCXFKRdn9bw5t3EWBSIbil3MlKYRidPHNw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] cpupower-info.1: describe the --perf-bias option
Message-ID: <abHAkgiPg8VDpDoV@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-info.1 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-info.1 b/tools/power/cpupower/man/cpupower-info.1
index 340bcd0be7de..a8d5aee4381c 100644
--- a/tools/power/cpupower/man/cpupower-info.1
+++ b/tools/power/cpupower/man/cpupower-info.1
@@ -3,7 +3,7 @@
 cpupower\-info \- Shows processor power related kernel or hardware configurations
 .SH SYNOPSIS
 .ft B
-.B cpupower info [ \-b ]
+.B cpupower info [\fIoptions\fP]
 
 .SH DESCRIPTION
 \fBcpupower info \fP shows kernel configurations or processor hardware
@@ -13,6 +13,13 @@ Some options are platform wide, some affect single cores. By default values
 of core zero are displayed only. cpupower --cpu all cpuinfo will show the
 settings of all cores, see cpupower(1) how to choose specific cores.
 
+.SH "OPTIONS"
+.LP 
+.TP  
+\fB\-b\fR \fB\-\-perf-bias\fR
+Gets the current performance bias value.
+.TP  
+
 .SH "SEE ALSO"
 Options are described in detail in:
 
-- 
2.53.0
