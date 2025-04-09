Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3BD2561D4;
	Wed,  9 Apr 2025 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197638; cv=none; b=MFHRhg0Xs1BeWZR2k6gyRMcFUxIK6nc/G2P3yVt7RRbXNQR76lxXq2fU6GmHFdUCSEGB/Bkq0vV6jGD+22wiYpyPf0hQsxBYSd0wM30HtocCIM6W2flpVvFjtN3igRLxviRzVV2QNdsxJhei3bA2rIrcG6JofNXnPBRt9+3uc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197638; c=relaxed/simple;
	bh=y3jfMYgltx3euKVNpKcOJ0QozvB4NPTKTamIbAx0bIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFtTsgWqkZkFfwFgsGg5v9vtvJjxkcrPRrGRYK9wCEvzLsOWtNFFDBS1rkELPPPaFzJwvIVlEFQCaLW6BIebBk4gyufbc8FCO3qvwCCHOMP/+1kBjUjXCUIvFWGLskOUFMN0aDAsDqjkTA4BLSAza+EzDIqSEb7im8Oi4pVtl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548221595;
	Wed,  9 Apr 2025 04:20:36 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202F63F694;
	Wed,  9 Apr 2025 04:20:33 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:20:31 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
Message-ID: <20250409-merry-gay-lemur-8288cf@sudeepholla>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
 <0558b7f7-8c69-4664-afc6-bae4fdc6f071@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0558b7f7-8c69-4664-afc6-bae4fdc6f071@web.de>

On Tue, Apr 08, 2025 at 09:23:35PM +0200, Markus Elfring wrote:
> > This series fixes potential NULL pointer dereferences in scmi_cpufreq_get_rate()
> > and scpi_cpufreq_get_rate() when cpufreq_cpu_get_raw() returns NULL.
> >
> > Henry Martin (2):
> >   cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
> >   cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
> 
> Can any other summary phrase variants become more desirable accordingly?
> 

This is meaningless, sorry can't parse. Ignoring it as others in the
community are doing already.

-- 
Regards,
Sudeep
