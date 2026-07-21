Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786B19B5A3;
	Tue, 21 Jul 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639051; cv=none; b=s6XwXimKxgyma8oprbSA8oWWhWJQmUVSZOoG2KyIfnGr8mGZwY7BmovV5FInD+wmyR+MiPyTOicZb94hotEeGlO6sbB32FDYZ0J6xJrs/6KwOfn0o/Sj3SRX9icb032Ook+oe6QRw2lsRepWwotK2h3jagtxEDqdmNBEw781o28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639051; c=relaxed/simple;
	bh=/21lq1+712VAZl+qXtv7I+D8Ly91WMHoXi341sZZ5lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED0o+5OYHKlIbgHPkCKynFDfWrfYSW+Q9ZpcgMkTlaQ/nnkovoPjlz4tybyRFlbwgE5ipKtPctTGw0XlalP/JB35bzv06ZD0vi2dMLuvFQ5FX7ggSo3i9dKkl2JCMSGgoTuZFbAmEBn5vVBs6ucTPsE5lQd81er4+sR+KnUMZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QzGIbj+u; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QzGIbj+u"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD682152B;
	Tue, 21 Jul 2026 06:04:04 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE6D3F99C;
	Tue, 21 Jul 2026 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784639048; bh=/21lq1+712VAZl+qXtv7I+D8Ly91WMHoXi341sZZ5lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzGIbj+u1PpiUI0SWsfQLKXRg6S/rtzeyC0f6BEwJhvN2ewm6cy2KihhPt6HWWibO
	 LU/oOPB1cAR6ZQuz7mTkZnEf1lOYBOdfUs12JEQbBk5xpsN8a/qFDLVSBTWGmR3ns3
	 4i9LPfNvwPqQ2IYpPOa233EziMTAV3bF+riueX0o=
Date: Tue, 21 Jul 2026 14:04:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
Message-ID: <al9uRagYJSQPJr7_@J2N7QTR9R3.cambridge.arm.com>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <akfHIH_dZrr5bosu@J2N7QTR9R3>
 <f2d4b312-4a11-425e-8329-33838ed37d15@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d4b312-4a11-425e-8329-33838ed37d15@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 12:29:54PM +0530, Sneh Mankad wrote:
> On 03-Jul-26 7:58 PM, Mark Rutland wrote:
> > On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
> 
> FW permits CPU0 disablement because it functions properly in regular run time.
> But there is an additional hardware constraint in above mentioned platforms, that
> suspend to ram has to be performed via boot CPU / CPU0. Due to this constraint,
> CPU0 is required to be online when suspend to ram is triggered.

The PSCI spec doesn't permit that.

Even if HW has that constraint, it's up to FW to hide that from the OS.

[...]

> > This is a platform-specific property, and it's possible to build a
> > kernel that boots on this platform and/or other platforms.
> 
> Yes, but for that reason the config will only be enabled for SoCs that have this
> constraint, it will remain disabled for other SoCs.

Please re-read what I said. A config option can't help if you have a
single kernel that supports multiple platforms.

> As mentioned above, its not a FW bug. CPU0 is allowed to be disabled
> from FW and HW constraint is for suspend to ram to be performed on
> boot CPU.

Please see my other reply at:

  https://lore.kernel.org/linux-arm-kernel/al9tdvOxYb83zBxd@J2N7QTR9R3.cambridge.arm.com/T/#m872da3cc4ded3386dce92d4bd4bdf9c33d3e2d0b

This is *definitely* a firmware bug.

To be clear, I'm not saying we can't do something to address that, but
let's not pretend that this is compliant with the PSCI spec.

Mark.
