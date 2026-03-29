Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8618285CB9;
	Sun, 29 Mar 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774776698; cv=none; b=FiPRf6BMOpehRFDPcCqw+N+FT8t63bPvGFsLtG27MjW9MvHykm1w9esk/9JG5Ik+h8iGWLraJ3AP/FBZfynQW2LXMT+ZNnHZgKm760r0+yhLi3RU378SqWj2ERLIoNVzbHDAaSf1OAO4vAUtr7Y0tKRF3fRMpBFjtnCSo0vze9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774776698; c=relaxed/simple;
	bh=cf7EiqAqmNt1++juAAppGpRaFMZbgrO/ch+A1qT1Ils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szVFCZJfSBdXDdHVe16kn6yi3QA8dl0/WSwUN0+il3Y+Kr5DHnFNoYwBqOfidjx5rVxsZ0tlPeUPbnPm7fPvIwzwPMz8FTA81nmjtX/v4CCJjbJwIhxcYUlCrNZM+SLC9w7epVmiUlLrjWDJk5Yrvmg28PQsLXExQMXzu6n3l3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpFKiu8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpFKiu8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16CBC116C6;
	Sun, 29 Mar 2026 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774776697;
	bh=cf7EiqAqmNt1++juAAppGpRaFMZbgrO/ch+A1qT1Ils=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpFKiu8MUA3BE4p3S3RwpI1H7gy/I+ZEXymKIBahgdUsI2H47QFufaskjDC4hMyPP
	 7o4Z+VSaRjk7C/7fe5yBsdeKhZtivfa1oaiaQXWfXqWvy/vwQwU/70712HplnHv8w4
	 Sr9VBZ95rZ2CMVpdHM2TZHRxmaGgRZ1jcKbRJzTC3WtkAQY6UPbUX7v/X8iHD/oUX5
	 PTlIbfHhO6J+9CrXDj0vh35rqCdWCxDngckmybio8OnBTSMu50w7bvfrqYI2XJphV6
	 CFTKCzxAKgZGxOLz0vg2bxvklRnAWnMYirdjGsYBCI1QI9XBAHCeTmIP866lNzBzpx
	 lTd7FIGjFYCXw==
Date: Sun, 29 Mar 2026 11:31:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/2] ARM: dts: st: spear: rename thermal_flags to
 st,thermal-flags
Message-ID: <20260329-starfish-of-eternal-storm-f16de5@quoll>
References: <20260329061523.98346-1-krishnagopi487@gmail.com>
 <20260329061523.98346-3-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329061523.98346-3-krishnagopi487@gmail.com>

On Sun, Mar 29, 2026 at 11:45:20AM +0530, Gopi Krishna Menon wrote:
> st,thermal-flags is a required property in SPEAr Thermal Sensor node,
> which is incorrectly written as thermal_flags in spear13xx.dtsi.
> 
> Rename thermal_flags to st,thermal-flags to fix the property name

Does this have an impact? If yes, then why no fixes? If no, then why
not? How this could ever worked? Maybe this is completely unnecessary.

We already talked about this and I don't get why this change is neeeded
and why we discuss the same problem.

Best regards,
Krzysztof

