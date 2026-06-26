Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BA36B05E;
	Fri, 26 Jun 2026 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500821; cv=none; b=J7QYWqPPGumQTy3tBu0LM/SBdaOXqnFXhKHHKQK/IFP3mZh+ajX7e4glbvJICbxJl8UQ7aj0WmSh7Gk5JM6DwexPW+wRPOaJLJNHrulF3ei10hz5YzmqvqhpH7kowm6xMsHGshw4wRVifkHjAXLxu0At63ARUFBR2jKfLkNkqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500821; c=relaxed/simple;
	bh=xAacMYXIouJKTQ7pGKcC+MEECBrb8bU72FKEZyjpbtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZU8Jfb3hLsig0zJNimWpqETZC8N3cuAoe3x5iLOihYyKoHtfC8zJmz8uhbGLbSFlOCDXv07men8AfiVMhodcOSBKpmxeG+aYEesv2rms84FwZO+ab7lPcrVcdSrzmqGobRulcejI2hEOS1r8Jaa0ET/1tph34Cpk+KdL80VwNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbSog2+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbSog2+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFB31F000E9;
	Fri, 26 Jun 2026 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782500819;
	bh=rV/AouYgSj7yEVZG31xqjZXnK1Nr28W7HxlGH34po/8=;
	h=From:To:Cc:Subject:Date;
	b=WbSog2+KFyAkZ0afLp+CiUtd6C0vEjq+lLOqrM7Gbhm+rKd+XHybW/5ETkNbPiVe9
	 a6OMHyRkesONAA9SwYskmnwufrDzjmTEzM4CLqxJ/DD36nnj3p0ewu3ixsZ/6DBsaa
	 PKMN4iVJFDBOVsVmftdRHqHjuthqsM8ehAXh/+LKCjYo77XMECridtJWkNzQobjiQv
	 03jb4RrIYPn2VDWlOQFiLemlPAaOud5+X4jBglQWGQHx2Kz6qk/RIAvp0sbs7uFOOC
	 olCDUy2LLWMjbF2FdvoBlm6lAuL3/60tKzh5Lwjae1E5HXyJ6jIe53qprqJXOsDh9s
	 bn/wOGTCmyuXQ==
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
To: Linux PM mailing list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>, Saravana Kannan <saravanak@google.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri@intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Hans de Goede <hansg@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: [CfP] LPC 2026: Power Management and Thermal Control Micro-Conference
Date: Fri, 26 Jun 2026 21:06:53 +0200
Message-ID: <2279717.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

A Power Management and Thermal Control session will be held during this
year=E2=80=99s LPC, as has been the case for the past few years, and it is =
open
for topic submissions.  The submission deadline is August 7th (for all
LPC micro-conferences), but if you submit a topic by July 10th, you will
be eligible for conference pre-registration (please see the LPC web site
at https://lpc.events for details).

The Power Management and Thermal Control micro-conference covers all
things related to managing power and heat. Among other topics, we care
about thermal control infrastructure, CPU and device power-management
mechanisms, energy models, power capping, and power distribution. In
particular, we are interested in improving and extending thermal control
support in the Linux kernel and in utilizing the energy-saving features
of modern hardware.

The overall goal is to facilitate cross-framework and cross-platform
discussions that help improve energy-awareness and thermal control in
Linux.

To submit a topic for this micro-conference, go to the LPC2026 CfP page
at https://lpc.events/event/20/abstracts/, scroll down to the bottom and
click on the "Submit new abstract" button.  When the submission window
opens, select "Power Management and Thermal Control MC" in the "Track"
field.

Please note that topics should not be about work that has already been=20
completed, as is the case for LPC topics in general.

Thank you!




