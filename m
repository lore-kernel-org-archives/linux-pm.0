Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923152;
	b=Rge7GtR5I25mRVHjPMAwQKaSlcQ/vTYjHxNX5YAO8+J4348SKCMKBVzGPdke3qnM/w9v
	 WSOTBodZc+npG1c7xXoHnJ4q7aG4aAKi6y+cL6jLbJgruzqcnlVFiJNQjwXWDVl41tGph
	 3FLNRNIgryb6gOKfksCYW5508ec62V7aGyPhVSdPm5aV5uUqjTE+Jjt1CwCigp7hi1CvD
	 F2K6QTfuL6Gzj36eqwNCHyCo+uXXfX0VxiynfdPI8k2qX/xi5V5OOmh61rvO0aLx1Mo34
	 OkkI37B0kqfSkJ7FqzDc5uTOVshqCkREkoiLd4OK+QLKs89G/H8of2QSZMc5rfUUJ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923152;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U4Jno7SA9gSG3rLqH83/3aHuhwvh4btgkGA+SaR/JKo=;
	b=SkWNpDfiR1iMgQ3KKJq4NHLrcFwx/SsL6Lqz2hCi6XFxygBjEnTTVJo1wO9TBccCCwUV
	 HFVyYsuo26xyXtHTZenfLwMWiNGLDo4GhvEsNvJpZHN5EU/tUEBu6Ejbct+xeNjRhYnvi
	 olbGobsa8Dx+7DTHCF2P4JmXCOq0+eC9JyXFQ7qL05PqzzpvqHto1+6nHZTVEYTKw3lvS
	 AHEEX+D0kJr5qO9yhNcrlWSvU6/6oIZ/zAq9EfbaZ3N7uNMv7R/zyTC9VwHRXLjPshdrf
	 e6KQdYPY+5VlmH2MHVx1jVNY4LdOqXvdGb8g4iZD3FdiFn7vHIVZwWRhdH9QCIJjzZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/dbE2L4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 03185606A338;
	Tue, 17 Nov 2026 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/dbE2L4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1BFFF1F000C4;
	Tue, 17 Nov 2026 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923151;
	bh=U4Jno7SA9gSG3rLqH83/3aHuhwvh4btgkGA+SaR/JKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L/dbE2L4h8i29r0kX1aDp8hJ7oEipmj5Tee1IeQRsekwmTPY540c1h6KxDZhFYaFR
	 fsOmwTpfvYGcKC4byXf9yrVwaNXLk3IbMHuQpWjuIWJkzhwmG+dcJQd9BlzDghUSSF
	 pZ/geOJifziWeJnDpF8Ugh1K9rF2HlmDkc48wG6v1BAx4gffioy7RAnglWBVrmahU5
	 xQjAYuD9Sf43vFE2+eFOcZHuH77GKTaiqGCsJ2hjoE/fY4zclhyu/dWu8w05bNe4c6
	 5+NZH93+wXAvNQz3YCcr0vKLZbgpea+UpxXDEr6RO8eHDvGn8FY86Sb3ifZGhV++9p
	 DbFuUUtYZ213Q==
Date: Tue, 17 Nov 2026 14:45:48 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Andre Draszik <andre.draszik@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v27 05/10] dt-bindings: arm: Document reboot mode magic
Message-ID: <mtqd3j7y333wfuel3j4wddtdtqbtlze6ojtepbxagl5zbfx6wb@fc3i4fny5p6n>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-5-fa4b3ff1359b@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-5-fa4b3ff1359b@oss.qualcomm.com>

On Thu, Oct 29, 2026 at 02:30:59PM +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> 
