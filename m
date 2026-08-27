Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141B468C22;
	Thu, 27 Aug 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835567; cv=none; b=gEYJYALTGE3+60YeJXgu4YjINsELSifSRKL68rDue/BS7qH3roRYt0TLSWj9HBTxNeJ60U5jD4+NUjbCFEvSE3riLih6I6oJzWAzUjY/PAfglejxv+svHcNxchNEUHUBqUj2MhMWX7KQbuHxZeAZvs30kSdcD4vPcTQy5kA0QaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835567; c=relaxed/simple;
	bh=BtvWV6bld2ba6TREhgL7Z9HI0Ln0mrJ078noHXO8Q4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGSZDgdmvJYi84d5nvgAvLuxtqUC5AjaS0HNYKbqWDovSizKEqaF6V75auRqf1p20RWd1h+/ah95ooMVF9kIHZliIAbw3+x1W4uiAAkVoBP+A3ZvjjXCJW6vvjgAdEa+7SCpA5Q7TpaEtHVoeGoD8NXRGGhQhuhqqzkGLzgF/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iartQjrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iartQjrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9DD1F000E9;
	Thu, 27 Aug 2026 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787835556;
	bh=b+1HOJ3x4l1XMOH28+iaXuruI8JflIZTg9npiF7QHFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iartQjrdAkHCpsnS22R3ITP1AJP0TlXreWVDzCAPlPvtsGdTFLmpEdRPEs3GUrtHo
	 Vz2FFBEYDD3eI6EqVug2asPBzJrWnGp+b9NMUs/cSKVHMwQ3dmOTFCetdcdg3eZA0L
	 R18z5oEqqBZowufsPjG7oyqF0aKukNNsKd6oZ9/pYp2Afb5PuJnavp2gRgxj7VFVa1
	 YCjG8nXky9e8101XTlnHqay55Csvyng3Dr5sjILdntL76RK9UICtEOn46qk8GLiWtw
	 ZCRMb4RoMMAWZKJrX9A1EVYIkjJzo1MU2TfUhFtkupD1DrIhloaB9taSYhmmoaup4N
	 mFFusZiuw3n5w==
Date: Thu, 27 Aug 2026 13:59:06 +0100
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: Re: [PATCH v24 04/12] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
Message-ID: <20260827125906.GJ770273@google.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-4-889281373870@oss.qualcomm.com>
 <CAPx+jO9QE_KG8BbfnMLTebDpGDj7OSpPDtgc9uTBGZCDJeLu_w@mail.gmail.com>
 <CAMRc=Mezpj4A7o00C9hhs97kdA5Q+FZKTLRbDM+fR8qr0xCCqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mezpj4A7o00C9hhs97kdA5Q+FZKTLRbDM+fR8qr0xCCqw@mail.gmail.com>

On Wed, 26 Aug 2026, Bartosz Golaszewski wrote:

> On Fri, 21 Aug 2026 14:59:49 +0200, Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> said:
> > On Mon, Aug 3, 2026 at 11:45 AM Shivendra Pratap
> > <shivendra.pratap@oss.qualcomm.com> wrote:
> >>
> >> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
> >> Currently, both the PSCI core driver and cpuidle-psci-domain bind
> >> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
> >> introduced, would also need to bind in the same way, leading to several
> >> drivers attached to a single device node.
> >>
> >> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and registers
> >> PSCI child cells. As the first user, register cpuidle-psci-domain as a
> >> child cell.
> >
> > I don't think PSCI should be modeled as an MFD device with childrens.
> >
> > Instead, this looks rather like a better fit for the auxiliary
> > bus/driver. Please consider using that instead.
> >
> 
> Hi Uffe!
> 
> Since I was the one to suggest MFD - would you mind providing more arguments
> in favor of your preferred option?
> 
> My reasoning for MFD was that it is indeed a device that provides multiple
> functionalities, of which cpuidle is not really he main one even though it's
> currently the only driver binding to this node.
> 
> In any case, we'd need a "core" driver binding to the psci node and with
> multiple auxiliary devices with their own drivers, we'd end up reimplementing
> MFD.

Ulf could be correct.

MFD is usually reserved for real devices, whereas the aux is a little
more loose.  Please consider it as an option.

-- 
Lee Jones
