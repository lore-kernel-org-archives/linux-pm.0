Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DE2D73B5;
	Mon, 29 Jun 2026 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736301; cv=none; b=G5r2hqkOMk9cigZGF8nKOFNkADo1ckMb2AohP8MQJ02io3kFd+E5z+U3aUzJS+fOsnv/aoT3Pbx42zWpywb73NaRKT6cfx+un98Ji06uhgAVlesVDA/+BWaIAvg2JmxJpf5F4znIuwWliEP3Z75vgSKQCyfM4M2WUCQaCg888U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736301; c=relaxed/simple;
	bh=xSqJRiQF6UQLPqSxB5yb9T1RRxnPE505T21EWjuW1pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnBoLdkw4oA/feqD+pQ2r9wCo71qpDZbnUoz40qeyd1awpXN+6EW0TKuzRmZiyLSzQAIYWPyiBEMakx5wmIYOqhF+8VVZlxnwPh1WWwCfblHNgot8WX/cLWdQQlm0AcDPMlWjrqnM5JX6Gm4RgWI8s+jwFkkXUcHa7OVGSrFSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLyKAQ+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLyKAQ+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B9E1F000E9;
	Mon, 29 Jun 2026 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782736300;
	bh=qh0gSZrz2cz9dtXLyAKqFHi3uSC4bc9NZvt+G4Exkec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NLyKAQ+7JrX8LhLLT8YMETOVoXJtkq6nNeXr5QG3yn+41S9uwwofic6+X6DOn6A4U
	 IN6af42AtccgF6ZdFSqNldgcYQtiaiqEWCh45t/qdkNvYR+iOEZvlVwJSaiA+XJfPH
	 HX7So4VrGCyaVi3J/To4vQVD0TKWF6Fj9LDa+8e1c6BJIzmmu95rtDGwhRl9tBlVre
	 qIJxkAdJ0gguvrTOvjCQpQLjuw7BqTxyofD0xlFuu9aVqg7CrEPpaWQdHZl0or/yHH
	 4GFVviH5Et4saseoqZhruWY+rK/blDOUd2RwZ+m8dcp37WldvIHn6gzCbG7JxBKUEm
	 xrJzXpLCMt/ow==
Date: Mon, 29 Jun 2026 14:31:37 +0200
From: Ingo Molnar <mingo@kernel.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
Message-ID: <akJlqeg-G2P7PPgE@gmail.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-3-jgross@suse.com>
 <akJWPnqcbL6RCfYN@gmail.com>
 <c4d745b9-fe6e-4290-9748-8d4d995df781@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4d745b9-fe6e-4290-9748-8d4d995df781@suse.com>


* Jürgen Groß <jgross@suse.com> wrote:

> On 29.06.26 13:25, Ingo Molnar wrote:
> > 
> > * Juergen Gross <jgross@suse.com> wrote:
> > 
> > > The 32-bit MSR interfaces rdmsr_safe() and wrmsr_safe() are planned to
> > > be removed. Use the related 64-bit variants instead.
> > > 
> > > Drop a pointless initializer.
> > 
> > Was the initializer really 'pointless'? IIRC it suppressed a build warning
> > on 32-bit builds, at least in some past iterations of these APIs.
> 
> I don't see the connection to 32-bit builds. Either the uninitialized
> variable is a problem or not. And I don't see why "l" didn't need an initial
> value (it is modified in this function only via a "&=" operation, so some
> bits would still be random in case it is seen not to be set by rdmsr_safe()).
> 
> In reality it should never be a problem, as rdmsr_safe() will always set both
> output variables to a value (0 in case of error, MSR contents else).

So it's not rdmsr_safe() but rdmsr(), but we had this:

  10a5d65856b9 ("x86/process: Convert rdmsr() to rdmsrq() in arch_post_acpi_subsys_init() to address W=1 warning")

Which addressed this W=1 warning:

  arch/x86/kernel/process.c: In function 'arch_post_acpi_subsys_init':
  arch/x86/kernel/process.c:972:17: warning: variable 'hi' set but not used

By the pattern the 'pointless' hi=0 initialization looks similar
and may not be as pointless as it seems. :-)

Thanks,

	Ingo


