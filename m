Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BE236A00F;
	Wed,  4 Mar 2026 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619844; cv=none; b=bcEQ7GU9Kp9PQdffR9fHATZDwZ0MIZpQS8LbXLNpT5XtrcvaViIuMp5V6JSosJcHRUexoWgNVWNFKqU6R5sGT3vLmfXgxjss4E28BpaLUL0fO7/cDI7B/0b5HjnasIoAGXkfGdl7YoZHkH3KqgzBeL/aYmLUXV+7W03BMhKNsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619844; c=relaxed/simple;
	bh=tAH5Fh//r0yTs3/fYZ1gphLpXoMSTNidzCwnGpKutrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMzAJYF1DRAwNta2kOMFyJNTBFeGb9I0ccZqlrpFz9qWHuAK+8juBzjGzc3c8n+1MYhqAdwgzlIbx619cP00ddbphdoN/g5OEqEVK4aATSpdpYmHnhTM/YGmMdHU9jNiEIPMFhQCBhdEvNn20Gh7GagBybMxUt179Y8a+ZjQTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE86E339;
	Wed,  4 Mar 2026 02:23:55 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01EEF3F7BD;
	Wed,  4 Mar 2026 02:23:59 -0800 (PST)
Date: Wed, 4 Mar 2026 10:23:50 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: Add print after a successful probe for
 SCMI power domains
Message-ID: <aagINsZj6sgR7pNY@pluto>
References: <20260304101457.7470-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304101457.7470-1-ulf.hansson@linaro.org>

On Wed, Mar 04, 2026 at 11:14:57AM +0100, Ulf Hansson wrote:
> It can be discussed how useful a print is after a successful probe. In the
> SCMI power domain case it's seems valuable, as it let us inform about the
> number of initialized power domains too, which is fetched from firmware.

Hi,

yes indeed we tend to print such 'summary' info at the end of a
successful probe in other SCMI drivers.

LGTM.
Review-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
