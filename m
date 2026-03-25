Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D93C7DFA
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437923; cv=none; b=dantIpNCNOH6XzWuw4vy+XNgE1O45pFXyD5PqulE/aDbql3Y9WsdIO3bK0cTRiSkZLsrLTprVKnLDm1/wTIdiXEb1ek6BDwYHFSR6aJhS1CjN4yjAdS1ZUZT7CYHhFYTzjsXzHCsW9Qp3kQTfklmk5m50louQOCtoVCWpy7VEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437923; c=relaxed/simple;
	bh=nvWIcM2zPPzvNKvJb0bsDBHCgthGxUlNqNpwZbeKQrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdDbW0unqV139hQyD5+qeBeo8SQq2Vn9SZeHrs7u7vssovMYvtggxePfgKOh+a/6zQeA9MZxjv0+8Jg9o+Ha6DaL67IJtaPnfeQpr5hFQZOLEvGdKWfn9WIjfFXV9MQf+JW/6eyqmXmU9ymmU/LrCk3eRaaqxs5BytOihUT1E+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=W+6fXjp/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="W+6fXjp/"
Date: Wed, 25 Mar 2026 12:25:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774437915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdew8eVGud1wDcubTKQ2A+7PSIH0d5C+e8CKZRhjTKg=;
	b=W+6fXjp/4duUEF7F3g8cUNdeVgpxbFXsxiN8TlfyMOedvqWKQni8otR+10lW9iBC+Lt/tP
	lld90AVX2DFVk012VLe3bW+9PqfqmdgBXaawGTbCTvSNxgf3eaFWxFUu0ME1cJFxDmMdrT
	T7Nkk0jFGrGCOoSGFeEb743SMUWyL8TfdQOsSTuuBo//GmFFf/uheqhr1es0QmoHKv5mML
	06E4t0n7T26Ly19AdcmM4JiehzWSBjGolcBzIh0EvYw/6v0p8AQNJZc33eid89RmUpo16G
	a2vrMBKW1TPqRcmFS/PY8kywBjVEs1LwF7FkcONmL5Aaak3H66+kg2VWwFqlYQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] cpupower-frequency-info.1: use the proper name of
 the --perf option
Message-ID: <acPGEsTIpbPX0uem@desktop0a>
References: <20260324223921.14317-1-io@r-ricci.it>
 <20260324223921.14317-3-io@r-ricci.it>
 <32cdfa7a-765c-4f74-9839-d2e0b01435dc@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32cdfa7a-765c-4f74-9839-d2e0b01435dc@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 2026-03-24 17:06 -0600, Shuah Khan wrote:
> On 3/24/26 16:39, Roberto Ricci wrote:
> > The cpupower-frequency-info(1) man page describes a '--perf' option.
> > Even though this form is accepted by the program, its proper name is
> > '--performance'.
> > 
> > cpufreq-info.c:
> > 	{"performance", no_argument,	 NULL,	 'c'},
> > [...]
> > --- a/tools/power/cpupower/man/cpupower-frequency-info.1
> > +++ b/tools/power/cpupower/man/cpupower-frequency-info.1
> > @@ -53,7 +53,7 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
> >   \fB\-n\fR \fB\-\-no-rounding\fR
> >   Output frequencies and latencies without rounding off values.
> >   .TP
> > -\fB\-c\fR \fB\-\-perf\fR
> > +\fB\-c\fR \fB\-\-performance\fR
> 
> I would keep perf and also add performance since --perf and --performance
> work - it is lot easier to type --perf

--perf would still be accepted by the program, whether or not the man
page mentions it. getopt_long() accepts any abbreviation which is not
ambiguous. While I agree that it would be nice to remind users about
abbreviations, why should the man page suggest an arbitrary one out of
the many accepted? And what about the other options (such as
--governors)? Suggesting an abbreviated long form only for --performance
would be inconsistent. The general convention is to list the one-letter
form and the complete long form. Also, if you want to save typing during
interactive use, you can use -c.
