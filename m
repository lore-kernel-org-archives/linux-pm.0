Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598532AAA0;
	Tue,  3 Mar 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561753; cv=none; b=qG25flSJObprnneD2gJdx5M5z27bkbNyDcTsDmnGxtADxvrQ/iBlVfFrpz7slfDA6fA5oixH8XLBa329S7tJV4r1Esyhts2oc201tDMrA9rKV1M53CWXPDVjkgBhctIZFZa2qsXhNFi6Lovn8Y6DK8swuSX4t19w4GerXE/dMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561753; c=relaxed/simple;
	bh=+SrioeYUZSxMnEuDGHr6OMW+zO4o7LsPUlakyCy8mh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FusTw7YRocyWtQb2LZ7Dq/Zbm33dn1Jn0cf1tY1NIK6Bet6WDs/PlPHOyk5TQXR6KPy6Q1zZlV+YUrciscs70Pt15TnY9qE6ysnS+dGCqL2thyeVj+E30wxDWo5lVXxdKvqvYQDsaOSLk2/ZayLi6jHo0kPav/kjg8g2QtHSqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTqJRQVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTqJRQVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6501C116C6;
	Tue,  3 Mar 2026 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561753;
	bh=+SrioeYUZSxMnEuDGHr6OMW+zO4o7LsPUlakyCy8mh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MTqJRQVBQWzzKaIobxPPkTrZrY7fJ03gAL6Fr/ATxpY2BklJtb0rvGSjSMX+L7vQF
	 G47y19pvUS2iDLNc/PRnlq+dU7bYdq2p84s28Z6Vn8Y0sx5+4k7xZ7BoJbtD8yms3p
	 ie0se/dsyQ/SSbQNbgvUcK1UDhOka7ff+Y84OWI9DfMBmu47z7u6SAr2pfZRhK2X3+
	 bTSxrTzDFYNsPCsJ778uHnjOr9yMnFjaUmOxdzBqm04EGy8prWuJnjQeXWgWKi96WF
	 q1/q6ap9pGfGjlGdcDS5/rMApGKJ88sME3oTtzzMqyem424wd6saSdAfxHfgH0ppPY
	 25T4UFWeCqC3w==
Message-ID: <3ce56e1d-ab5c-44f1-af09-679e714833a7@kernel.org>
Date: Tue, 3 Mar 2026 11:15:49 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Add support for setting EPP via systemd
 service
To: Jan Kiszka <jan.kiszka@siemens.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <b44f2af7-360b-4f4c-8541-04008ead7dcb@siemens.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <b44f2af7-360b-4f4c-8541-04008ead7dcb@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 23:21, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Extend the systemd service so that it can be used for tuning the Energy
> Performance Preference (EPP) as well. Available options can be read from
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences.
> The desired one can then be set in cpupower-service.conf.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>   - improve commit message
> 

Applied to https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for my next pull request to Rafael.

thanks,
-- Shuah
