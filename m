Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F613AC00;
	Fri, 17 Jul 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247282; cv=none; b=HgdPdje9yRZAYF1mJocITTUSVqTpdNS07GRqOYI2hwYhpehUHFVr6B4lwEmg6hQ5HhJlI+4Knm19fq44NHilUungHKCKqSk/PNgodBRXL7Iq6xCFBDsvw7WiBs9xxsRcGHb7YP+YIwMTt8p1HLT7J7+8SBHgELC48j5C4Vs+IqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247282; c=relaxed/simple;
	bh=CFwqJQO1ta6+ptVsHeiLZ/rQADPVCMfNTr1YJLlUhAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F41+2Zs4YSGrUCw7Tn7bDL7hyRNmhSOsgQ1jdP3wutfr+bfP/MspX3ynIUEmo1mFnBTR/U2P+/qqzMPVn0NLJ4O9CuGcRQ0cSOtgpRQmTpxshuW7i0B0PBPGfJLI/gCMwKBXWgfVbIu7C2P9wO4XsAsLeKuW7Lczk/7hhw1LT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQEIkJ/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQEIkJ/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6151F000E9;
	Fri, 17 Jul 2026 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784247280;
	bh=8jgb1Lj/jjjbbAsZsTgqZe2AVm3Aj+u2+c0KvkludQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQEIkJ/lpVoIT2AzB4Ho0l8TKYm6IpULG4Df4o9zJmJehRsFNAWihZ7hGAb8EgPVV
	 W9dhMaKuBYZUi2qH4RVOjB2d4pR39BZJbd3YjaoXIhCuKPPTW+m9jGljIg5ZZj+nUu
	 MF3YccCjRCHBr2/r+sqYh0ymTdGLvaQ0PKtXtjSEBTy98jfovYyy6aOtU31W43kjhV
	 se8qRwZltUuWElH2X8h5FQPLo3LtjWFmUrcW1CA9xV4Vuyw8Vk3OBZMFHtxnUXT/cn
	 kFGXkGnXqrLJXY4rvgfosRlmKwGK1gFgdlpbbRSK/lts+VTLUjPL0hYSpoqAV51EJU
	 IoaJSUf3K6TYQ==
Date: Thu, 16 Jul 2026 19:14:37 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rakesh Kota <rakesh.kota@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, jishnu.prakash@oss.qualcomm.com, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: pmic-glink: Document
 batteryless property
Message-ID: <allz1-dD9V_Ck8LK@baldur>
References: <20260519082526.odmn5dqi2jftwnln@hu-kotarake-hyd.qualcomm.com>
 <20260519-first-wine-bulldog-a6a4c7@quoll>
 <20260521071341.q4efqssppvettaey@hu-kamalw-hyd.qualcomm.com>
 <86f76a81-832d-4ba5-81d5-38b46b7dc0a7@kernel.org>
 <6c595a5f-b979-4e8b-ae77-d28d24700588@oss.qualcomm.com>
 <e07085c5-0fe8-4ea7-8e51-ebe104e7aa2d@kernel.org>
 <82019c2e-6b6e-4edd-91b3-a28ef6eb09eb@oss.qualcomm.com>
 <20260525120139.dyfnm6nwfzuoxd7p@hu-kotarake-hyd.qualcomm.com>
 <20260702113010.zjrk4kr7fpjp6asj@hu-kotarake-hyd.qualcomm.com>
 <dqe3ntmtmjqixp2l5n7qm6zpcwh4sizr7jd5g3cl3tzpvl6tvo@casnjg3orldd>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dqe3ntmtmjqixp2l5n7qm6zpcwh4sizr7jd5g3cl3tzpvl6tvo@casnjg3orldd>

On Thu, Jul 02, 2026 at 02:49:37PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 02, 2026 at 05:00:10PM +0530, Rakesh Kota wrote:
> > On Mon, May 25, 2026 at 05:31:39PM +0530, Rakesh Kota wrote:
> > > On Fri, May 22, 2026 at 11:24:19AM +0200, Konrad Dybcio wrote:
> > > > On 5/21/26 11:58 AM, Krzysztof Kozlowski wrote:
> > > > > On 21/05/2026 10:46, Konrad Dybcio wrote:
> > > > >> On 5/21/26 9:20 AM, Krzysztof Kozlowski wrote:
> > > > >>>> Since firmware does not have a way to dynamically tell if it on a
> > > > >>>> debug-board powered device or a DCIN powered device, We are required to
> > > > >>>> add this new DT property.
> > > > >>>
> > > > >>> Neither debug-board powered device nor battery-less will have
> > > > >>> monitored-battery, thus again, why lack of that property cannot tell you
> > > > >>> what you need?
> > > > >>
> > > > >> A device with a battery will not have a monitored-battery either
> > > > > But why? If for such device property "no battery" is suitable, then for
> > > > > me "monitored-battery" is suitable as well. IOW, if you say that having
> > > > > a property describing batter is not a accurate hardware property here,
> > > > > then neither saying "no battery" is, because no batter is basically some
> > > > > sort of battery (just like empty set is still a set, empty array is
> > > > > still an array).
> > > > 
> > > > The battmgr service running on one of the remoteprocs already has all
> > > > the information about the battery and it also handles all the type-c,
> > > > PD and charger configuration, only letting the OS know about the
> > > > results.
> > > > 
> > > > Hence, unless there's some other hardware at play (e.g. for custom
> > > > 200 W charging), which wasn't fully implemented in the QC firmware,
> > > > there is no reason to describe a battery separately, since the OS
> > > > can't do anything useful with that information
> > > > 
> > > > In some abstract way, perhaps monitored_battery = <&pmic_glink> could
> > > > be thought of as valid (since that's the data source the OS gets to
> > > > see)
> > > 
> > > Should we use monitored-battery = <&pmic_glink>; If so, would it be
> > > incorrect to mark pmic_glink as simple-battery, as that may cause the
> > > schema validation to fail?
> > 
> > Hi @Konrad Dybcio, @Krzysztof Kozlowski , 
> > 
> > Following up on the earlier discussion — is monitored-battery =
> > <&pmic_glink>; a valid pattern? And if so, would marking pmic_glink as
> > simple-battery cause DT schema validation failures?
> 
> I'd say, no, monitored-battery should be pointing to the battery device.
> Please fix this on the firmware side, so that the firmware can report
> having no battery at all.
> 

This won't be fixed in the firmware on my devices.

Regards,
Bjorn

> -- 
> With best wishes
> Dmitry
