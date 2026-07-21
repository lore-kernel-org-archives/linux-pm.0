Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56213769F7;
	Tue, 21 Jul 2026 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642000; cv=none; b=HWJiF03jF4I7nzQzPHtSXyP+oER19vE6bPeZNvgpTnkHB1S19WqYMdVd9MXbnHNk08KvDKLGIVD56bXnL96ZdA8JOP2NYO+5ptQYh9MdjkLxLg86JGycaZvAJ9hSIr8YgqFVuU3pfL4RYc6eQH3/nZ+ybqad9weLq1oeB90XvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642000; c=relaxed/simple;
	bh=+udyjfrGMyD9vH3/wLeIvE01TbNr7hJTnn0awv3Cat0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM55bl6fYykJYn9c20+d7wh0LWbhIpIm7Ll0lvWDfzOoeuPUkk2VqJh/J5M11vgIPRh5W0U5iqzpF2r9LrmVgtb3Kxj0EERreamPvIRNyv8HJVaPj365OJmI63B/f9XBl9EOpufosL88XfrQQ7lx4/tL8fc6jAjssQsNe7o36lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxHQZAOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxHQZAOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DEB1F00A3A;
	Tue, 21 Jul 2026 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641998;
	bh=Mt8faBpMB1IIl9+TZM5ARhnba5LkjGMQeGNB0pc/k+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IxHQZAOPNrAexzugCNFJxfW8YmvcPLCPNy38A7L9/Y+4Avd91FbCMriUf8SHT9K+v
	 wKoQP3TkufZuP+MOv8VbGzsdrAROCacst+2UvFQUbbx7TrEgsVcQ12de91xlzkaNfP
	 UWCBhAyXEccVfIyAF8gocZHBLz0vqID+vLqooy8AgxWH1RVLXQxOTWFRUPxJiBpX47
	 2Sq2MmJ9TKNZUg2m1eC7DBS1VEq+mFAqLgjvFHGm+8XgTvU/mF7WNCa87f7bM1Nykx
	 Fv9HoIOx4O/YGkgZWPfGLIflKljmkz8Ab7NhhS3WF6mefnWzPb3tgxOitXq5qOkCTi
	 KtV9RyP+GC1iw==
Date: Tue, 21 Jul 2026 14:53:14 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
Message-ID: <20260721-wandering-romantic-buffalo-ebbc4f@sudeepholla>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <akfHIH_dZrr5bosu@J2N7QTR9R3>
 <f2d4b312-4a11-425e-8329-33838ed37d15@oss.qualcomm.com>
 <al9uRagYJSQPJr7_@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9uRagYJSQPJr7_@J2N7QTR9R3.cambridge.arm.com>

On Tue, Jul 21, 2026 at 02:04:05PM +0100, Mark Rutland wrote:
> On Tue, Jul 21, 2026 at 12:29:54PM +0530, Sneh Mankad wrote:
> > On 03-Jul-26 7:58 PM, Mark Rutland wrote:
> > > On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
> > 
> > FW permits CPU0 disablement because it functions properly in regular run time.
> > But there is an additional hardware constraint in above mentioned platforms, that
> > suspend to ram has to be performed via boot CPU / CPU0. Due to this constraint,
> > CPU0 is required to be online when suspend to ram is triggered.
> 
> The PSCI spec doesn't permit that.
> 
> Even if HW has that constraint, it's up to FW to hide that from the OS.
> 
> [...]
> 
> > > This is a platform-specific property, and it's possible to build a
> > > kernel that boots on this platform and/or other platforms.
> > 
> > Yes, but for that reason the config will only be enabled for SoCs that have this
> > constraint, it will remain disabled for other SoCs.
> 
> Please re-read what I said. A config option can't help if you have a
> single kernel that supports multiple platforms.
> 

+1

> > As mentioned above, its not a FW bug. CPU0 is allowed to be disabled
> > from FW and HW constraint is for suspend to ram to be performed on
> > boot CPU.
> 
> Please see my other reply at:
> 
>   https://lore.kernel.org/linux-arm-kernel/al9tdvOxYb83zBxd@J2N7QTR9R3.cambridge.arm.com/T/#m872da3cc4ded3386dce92d4bd4bdf9c33d3e2d0b
> 
> This is *definitely* a firmware bug.
> 
> To be clear, I'm not saying we can't do something to address that, but
> let's not pretend that this is compliant with the PSCI spec.
>

+1

Just curious if CPU_OFF on this CPU0 returns DENIED or just proceeds and
ends up with cpu and/or system hang ?

-- 
Regards,
Sudeep
