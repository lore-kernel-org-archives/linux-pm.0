Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2673EE1E7;
	Thu,  7 May 2026 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157392; cv=none; b=kEF2dBbxlAPpIJnwn12261qH/lKW4jgAiDMlmgk4RKLQjg9D8hs93Q94kue6fyyWOhLZA5aAfM4kdHVjH2ZwT2J7jsatMTevSikzoFsvYYDgIvhpZq0y6a/sEZqMQC70V+Y8ZUa9SDZp9D1yni5Q+xS3g8GTKCbXeqfZ5gaLZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157392; c=relaxed/simple;
	bh=t2FvFDrp9DlGESeahtlxW757S/4S7ucRFLPdAT++9jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtN5lbJ0fvuNI7UeLdEIxGNdj6CYVd2WdTqwlxXv7Em6nqzIVs1X7HcuzErBENUZMs8IIdteKE7Snnp6og/GNdDbGg7kRtGFtcLACKde5GEMsYU5oLE9YPBN003V9YZ8C1RNVUe6jSnEwNI6+f6LQL/QW5gwMocnIaNY5B4ZpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbaIPUDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbaIPUDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA14AC2BCB2;
	Thu,  7 May 2026 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157391;
	bh=t2FvFDrp9DlGESeahtlxW757S/4S7ucRFLPdAT++9jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbaIPUDj0OS761XR87i7NHCbgO2GWpMDxEt2U+gcIXAJHMzPi1ShYY+/e9pCySRhV
	 IoW7OnLi62lBI39TisMHauWHsi/vuKQLPpiw1WPnoUIxaV9Ydv3IXGbx/sNEsUzMWm
	 GrL9n5m3cSGirMLxmrKTaShWhsNbDTXc6BMztrG51ifH8o9avPlQBXBvc+JkKUbXBy
	 yB8EjFpx4+fxJVSExuic9OdthmJkeDdMrjOEHgf7KPSPOqJneapAixgrHXub/unS+v
	 8ZR+F4kEQtBC7GprQTaQeJ6INUPi48HUhbEoH5PQRkQe3et6AlGIaKDZKtPWW+gA57
	 95U+pTy5SHM+Q==
Date: Thu, 7 May 2026 13:36:25 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, cw00.choi@samsung.com,
	Sudeep Holla <sudeep.holla@kernel.org>, kyungmin.park@samsung.com,
	myungjoo.ham@samsung.com, konradybcio@kernel.org,
	andersson@kernel.org, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, jonathanh@nvidia.com,
	thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [RFC V6 1/8] firmware: arm_scmi: Add QCOM Generic Vendor
 Protocol documentation
Message-ID: <20260507-misty-neon-trout-7a3ada@sudeepholla>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <20260507062237.78051-2-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507062237.78051-2-sibi.sankar@oss.qualcomm.com>

On Thu, May 07, 2026 at 11:52:30AM +0530, Sibi Sankar wrote:
> Add QCOM System Control Management Interface (SCMI) Generic Vendor
> Extensions Protocol documentation.
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
> 
> @Sudeep/@Christian, Just moving the series back in RFC mode to get feedback
> on the devfreq part of the series. Will add a lot more documentation in the
> next re-spin, so definitely not ignoring your earlier comments :).
> 

Thanks for letting us know. We must settle the specification first before
moving on to any implementation details. I will therefore skip reviewing this
version, as requested.

-- 
Regards,
Sudeep
