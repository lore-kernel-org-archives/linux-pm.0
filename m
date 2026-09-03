Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAB33FE0A;
	Thu,  3 Sep 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451454; cv=none; b=Ezwvps3cOs65FIdiGhJAG2b16Kvh49sLKtpAmR5IS473gblLFntxIgQpENgnxVUeuorWo6d5KPkb8VajoWCzssZUb8rZCqD79ehqdDNo1PViqNeM0SRjMRjz7sW/98BF5FbNtgudFCo8I++S0pj9K3j79a9wly0krBFt/hMrecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451454; c=relaxed/simple;
	bh=VAn1nwqBQOZd+7Jayb8KisNaLUkfMXohuiSqLUrUaDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoacY+qObQj6t2Ym+slhTYMryuwtGRRTRu37MTBYh6dwBqt981JMkHT8Izw+MSayDc70LKvwR5vE7lhBH3Vh/6uKOjjC+VsTRTThIsck4E1joPOjReGsi3+V+DAJWLfKdcHyk+ehFOOdwVIppxEH9X08nrebhzEwxq57fas3B8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOcHz2MR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOcHz2MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A373C1F000E9;
	Thu,  3 Sep 2026 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788451452;
	bh=34B4My/cbYwbtAzKOspc3winfsWdZIxqEygPDUSPYD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dOcHz2MR31TbbywskNQft623blEIeUxWttP2DBiARKBZXIU3JdIijX4vtEnljPQnw
	 CrrRCXGWasXWHIetOo3KsHvcq1lk54maLbm5Xs8jvhaQ0CHmW75Pqr5AAwlDkB1IQW
	 vlbecwzMeDmXvlUI4cHYIC4Id63naNfF+KXS0P7z02RCfVGCV9PdpIM0mRnFo09VzT
	 w6Gkw20lPK+4Op8OK9TesUG2FCQDKPwK3HYsciSbsmg7iqePGlI+51ynazj/pROlbF
	 xxofXU0/FttKpzxDCW+aJRBX5d28HmRPgxCLMuFIw5q0vOLfWhxoyZq8wtJH4kBvgh
	 acEEHHN8vmd0Q==
Date: Thu, 3 Sep 2026 17:04:01 +0100
From: Lee Jones <lee@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, mfd@lists.linux.dev,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Song Xue <quic_songxue@quicinc.com>
Subject: Re: [PATCH v24 00/12] Implement PSCI reboot mode driver for PSCI
 resets
Message-ID: <20260903160401.GV2133376@google.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>

On Mon, 03 Aug 2026, Shivendra Pratap wrote:

> Userspace should be able to initiate device reboots using the various
> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> patch series introduces psci-reboot-mode driver that will induce
> command-based resets to psci driver for executing the device reset.

The more I read through this submission, the more convinced I get that
it does not belong in MFD.  This is a potentially nice "architectural
workaround" if it a) didn't break some of MFD's fundamental "real
devices only" rules, of which cpuidle and reboot-mode certainly are not
and b) didn't require a massive expansion of what the MFD core is
designed to do.  I am more that a little uncomfortable with the 150
lines being added to MFD core support this workaround.

My best suggestion so far would be to base these changes inside
drivers/firmware/psci and use the aux bus to communicate with the
various components.

-- 
Lee Jones
