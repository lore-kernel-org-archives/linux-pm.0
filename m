Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711924908B7;
	Sun, 26 Jul 2026 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785024086; cv=none; b=E83Q9ULCMRc06xSW0rgojA+CNv6yM7MwEp4BmLLNINsDCE0+thMymC8sC2DEvpLfAVIdhwOzKbN5m/ZnomlxH7j00AJX51t81LMe73JpcB1n8ztRwCfikSQEHJ940BC53bKEXMYES/W/Q8c7ULdyfPJgKSU7Uu1RRjjjdw2knf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785024086; c=relaxed/simple;
	bh=rAW35Sh+VVk+8IvRz0dBDmgX8f882O5K789KIRm+ups=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PxWzCjyFiSH9+Mqlcg/WdvXyqvlVKcHwTxFX6wYDdGtZt7r1a5wILzrA/JPfr7XJZ7afRBo9JZj24XNd4+p86i0qc8aHlRl6rUSlJ0VllgeeeAmj4PoyAMQnsa1mPcO9FwHlN3cXvbuCdBTRbCKL0vpwt4qyHH77VQjP9DHWlv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50B81F000E9;
	Sun, 26 Jul 2026 00:01:24 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3B8B81802A1; Sun, 26 Jul 2026 02:01:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Amit Sunil Dhamne <amitsd@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 Kyle Tso <kyletso@google.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
References: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
Subject: Re: (subset) [PATCH v5 0/2] Add support for Battery Status AMS
Message-Id: <178502408322.829727.13725435987030791049.b4-ty@collabora.com>
Date: Sun, 26 Jul 2026 02:01:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 14 Jul 2026 21:10:51 +0000, Amit Sunil Dhamne wrote:
> PD 3.1 v1.8 Spec necessitates a response to Get_Battery_Status request
> from the port partner (see "6.13.2 Applicability of Data Message").
> This patchset adds support to get all the battery type power supplies
> and query them to report the telemetry required to build a Battery
> Status Message. Right now, this submission assumes all the battery type
> power supplies that exist in the system are fixed (meaning cannot be hot
> swapped).
> 
> [...]

Applied, thanks!

[1/2] power: supply: Add helpers to get and put arrays of power supply handles
      commit: 0962125d9001077e91bc90656245f009e3c6c129

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

