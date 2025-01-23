Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295329B0;
	Thu, 23 Jan 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633058; cv=none; b=daTiv0TJ3x3lG5dYrPjjZ4qaxFnUHJ9elB2UlYPWCp8tjEi+x0+DlL+5d5bioYz7ydr7nGvmb957pEWM7EFzLVvzz85RckhJ4N6uBwg3t+Fxz9t/+9BK1qMyzrZYgrs7NNdZjpcIbmsc8+4I4ToLB4+s4SYy3lmV0Blu2qd3Qd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633058; c=relaxed/simple;
	bh=Z0YMqjQ3iKkT4FKUmBnKW/YHyfcbNoZMTcDHKBllIIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL4U4ASNK7wblgyfGqAbCrHk7qMg+ADUhANkaBcM8RKV9IeL4I/cXvKYYHoLHQlT69tvBMIPUCpdTmo7wcZo/VLU46WKDsES44z9c/gWxY0e6miiWKCHY4LbNpROjiwUWCfdUCRJLzlKgxbU1IMVa6m6BSy3MAfAWYZh/WfQU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F3E01063;
	Thu, 23 Jan 2025 03:51:23 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D7733F5A1;
	Thu, 23 Jan 2025 03:50:53 -0800 (PST)
Date: Thu, 23 Jan 2025 11:50:51 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/33] cpufreq: vexpress: Stop setting
 cpufreq_driver->attr field
Message-ID: <Z5ItGzX0_flX3RfU@bogus>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
 <62b1f43c0fe1fcedfeaedee9e7d8f18953bfe36c.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b1f43c0fe1fcedfeaedee9e7d8f18953bfe36c.1737631669.git.viresh.kumar@linaro.org>

On Thu, Jan 23, 2025 at 05:06:06PM +0530, Viresh Kumar wrote:
> The cpufreq core handles this for basic attributes now, the driver can skip
> setting them.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
