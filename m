Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76781A5B9E;
	Wed, 17 Jun 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708943; cv=none; b=qRS1F+Hhj7u9QAdv/6LO/5ghnojFSTSISTGys6dYEP56L1frKGrx9r/8PkrA/o9EsuDa5Hqm/5Xm6nnjGS5B8hg0ZLGr/EdKIOwc4WaJk/zzT44Lu4jDn1f3gzpRle8rcSYyh3+kk5Kj83x6ZG3MW2jYxb/Nqt/8EHMp8BqaPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708943; c=relaxed/simple;
	bh=RlNOHlmPM/aS5sBQ7VG2OBOH3yLC8v+e7myxpqAb+3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDUh/D41f8tICPp09uM2THpuEMj3qCwHo1H93PZ1pBY7WVkTD6b4dbPaj9YeQFrwASP1KWKqNXwXxFwMOj0mRZbfAGl6FiGmtn6jR+wIFG62W5ibbvO5Nm+h/7BARWD3KdsQc/lweAR82eB56XdnX1u2oZXMAUdEeBW5tKB85QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lqCcDpsV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lqCcDpsV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92BBE32AB;
	Wed, 17 Jun 2026 08:08:56 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286493F915;
	Wed, 17 Jun 2026 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781708941; bh=RlNOHlmPM/aS5sBQ7VG2OBOH3yLC8v+e7myxpqAb+3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqCcDpsV/LR0BQ9GMICFrEKsO4tbSKUncSYLPoqUkOuohfThz0L1OPI1vQWimfvAA
	 5TFThIOuL9eflj9IBhmsERD/guMB8yTdiJqWF0QFpgV25RMg1CkaayD6BHsUe4m3D2
	 D6HlqBqzXYSQVxQtOOm2W0LPXYBVCjt3npdPAGp4=
Date: Wed, 17 Jun 2026 16:08:49 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v7 00/13] Add support for SCMIv4.0 Powercap Extensions
Message-ID: <ajK4gV9DMWtFxIgX@pluto>
References: <20260617095910.1963578-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095910.1963578-1-philip.radford@arm.com>

On Wed, Jun 17, 2026 at 10:58:57AM +0100, Philip Radford wrote:
> Hi all,
> 
> I will be taking over this series from Cristian and in doing so I have
> addressed a couple of issues raised by the first version and added six
> additional patches since Cristian's original series:

Hi Phil,

please refrain from posting big series like this during the merge window
in the future.

Thanks,
Cristian
