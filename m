Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A97355F44;
	Wed, 22 Apr 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872407; cv=none; b=EufEbiPZqEb40xdGCMAFrLf52trELNvaTjmdtW79FwZQNwPnoPH7iZ0kgtPeEyxYEEwO66NADRHpXs4AeproYVv6w4+ww3e5HaY4EMtGx4zVG+lMQkvCJuXiDZRc7W3r1pcNpiGHupfc+hvOaRKLM7uekWtw8ZEZxmN4SFsxsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872407; c=relaxed/simple;
	bh=POgSdGp98IDS2QQQovV+rrM7a+/A61uuffLzvYpK9ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGTaHejP2Vz7Eay4ZpSebjQhTBv3Y+38lWmDVE7uqvPs+tFoEjwIL31DImfP9OmsjbMNvf3R6Mt0aORsUF/O9US4An9l0tnO2Rw9Ss7mCa8bTJUygdqXEpcp12wNHz44H0Gr38qlouxkLPeI4CqQ7JsvLeY6JIW9zesvzgGiLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu4ctCv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu4ctCv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F32CC2BCB2;
	Wed, 22 Apr 2026 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776872405;
	bh=POgSdGp98IDS2QQQovV+rrM7a+/A61uuffLzvYpK9ZM=;
	h=From:To:Cc:Subject:Date:From;
	b=Hu4ctCv7cxUOPSLYu42OuOV7Klz+aKtyHe2cViz95JNdVC1PIEb15yAtxpKDTS1cs
	 63rkXGyp54muQb9Ou0hG4MJD/26ud1YsqllcAbeZtyrVixvGQyLt0Hbm4/0gWU6agm
	 KLkZ5DOB04B1gsa8UUVDq7CHM6Bbr+ITCSh7jhL/YPHCK95sf89XHPF1W3KzOLGLDS
	 Ej5u9D7JNFrM9SRkMKr6l+nBD7y5U7+eZgCrQo1ph508+1zLtk1i17rfCiA6+qaLv0
	 hrzzIuzc/3RLjBY236lXQy4jS2j8wZsSEU+uVeR9flEXWaOgpRn2Io9dhXzXk5dBEZ
	 mb5k5RtcUS+Qw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 0/2] thermal: core: Simplifications related to governor handling
Date: Wed, 22 Apr 2026 17:35:46 +0200
Message-ID: <2354798.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

These two patches simplify the registration and unregistration of thermal
governors.

They are intended for 7.2.

Thanks!



