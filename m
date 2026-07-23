Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5B396B68;
	Thu, 23 Jul 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829292; cv=none; b=maGiFcA+jIYRm+fHmzs1QlPTlCvOXqzofXBM31LFl4CcopQI992S6E+0sgnwBeomNASIBSXxL7ortq7ys+niVGCYCxQWfzL3bwpkOWCQyQL+GHGMm7575VsuX21CDC7dalU77cgUzA7THx9A7iFM7W/f/0Kj7P6XD5vHGSD7dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829292; c=relaxed/simple;
	bh=4HgACGrFInHbGQzg75GMMOTedzoqj60aSoXWkFd1/1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U856TEbC8qSEZxkwWJYnELtUHVVz5vCjArBjSKJokguKpbWATQ4J0qsD3S1l6bMEtizDuF1m8fXyMb7oQIVkeVQPNyaAV3/u/+HdDW0goBGf36KWiMlVw6DeizzSc0T4EVPu6kWveQCSxLFEMTTfiucbWj9Pv0B95oSwZk5AT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7477B1F000E9;
	Thu, 23 Jul 2026 17:54:47 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:54:44 -0500
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
Message-ID: <amJTpv7FY3uh8KcX@baldur>
References: <20260521071341.q4efqssppvettaey@hu-kamalw-hyd.qualcomm.com>
 <86f76a81-832d-4ba5-81d5-38b46b7dc0a7@kernel.org>
 <6c595a5f-b979-4e8b-ae77-d28d24700588@oss.qualcomm.com>
 <e07085c5-0fe8-4ea7-8e51-ebe104e7aa2d@kernel.org>
 <82019c2e-6b6e-4edd-91b3-a28ef6eb09eb@oss.qualcomm.com>
 <20260525120139.dyfnm6nwfzuoxd7p@hu-kotarake-hyd.qualcomm.com>
 <20260702113010.zjrk4kr7fpjp6asj@hu-kotarake-hyd.qualcomm.com>
 <dqe3ntmtmjqixp2l5n7qm6zpcwh4sizr7jd5g3cl3tzpvl6tvo@casnjg3orldd>
 <allz1-dD9V_Ck8LK@baldur>
 <gnmx5m5dt5676oox5cypzg26vbwtmzhzkh4bhyq6z27kwi2bf3@z24ov6esgtx4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gnmx5m5dt5676oox5cypzg26vbwtmzhzkh4bhyq6z27kwi2bf3@z24ov6esgtx4>

On Wed, Jul 22, 2026 at 04:59:32PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 16, 2026 at 07:14:37PM -0500, Bjorn Andersson wrote:
> > On Thu, Jul 02, 2026 at 02:49:37PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jul 02, 2026 at 05:00:10PM +0530, Rakesh Kota wrote:
> > > > On Mon, May 25, 2026 at 05:31:39PM +0530, Rakesh Kota wrote:
> > > > > On Fri, May 22, 2026 at 11:24:19AM +0200, Konrad Dybcio wrote:
> > > > > > On 5/21/26 11:58 AM, Krzysztof Kozlowski wrote:
> > > > > > > On 21/05/2026 10:46, Konrad Dybcio wrote:
> > > > > > >> On 5/21/26 9:20 AM, Krzysztof Kozlowski wrote:
> > > > > > >>>> Since firmware does not have a way to dynamically tell if it on a
> > > > > > >>>> debug-board powered device or a DCIN powered device, We are required to
> > > > > > >>>> add this new DT property.
> > > > > > >>>
> > > > > > >>> Neither debug-board powered device nor battery-less will have
> > > > > > >>> monitored-battery, thus again, why lack of that property cannot tell you
> > > > > > >>> what you need?
> > > > > > >>
> > > > > > >> A device with a battery will not have a monitored-battery either
> > > > > > > But why? If for such device property "no battery" is suitable, then for
> > > > > > > me "monitored-battery" is suitable as well. IOW, if you say that having
> > > > > > > a property describing batter is not a accurate hardware property here,
> > > > > > > then neither saying "no battery" is, because no batter is basically some
> > > > > > > sort of battery (just like empty set is still a set, empty array is
> > > > > > > still an array).
> > > > > > 
> > > > > > The battmgr service running on one of the remoteprocs already has all
> > > > > > the information about the battery and it also handles all the type-c,
> > > > > > PD and charger configuration, only letting the OS know about the
> > > > > > results.
> > > > > > 
> > > > > > Hence, unless there's some other hardware at play (e.g. for custom
> > > > > > 200 W charging), which wasn't fully implemented in the QC firmware,
> > > > > > there is no reason to describe a battery separately, since the OS
> > > > > > can't do anything useful with that information
> > > > > > 
> > > > > > In some abstract way, perhaps monitored_battery = <&pmic_glink> could
> > > > > > be thought of as valid (since that's the data source the OS gets to
> > > > > > see)
> > > > > 
> > > > > Should we use monitored-battery = <&pmic_glink>; If so, would it be
> > > > > incorrect to mark pmic_glink as simple-battery, as that may cause the
> > > > > schema validation to fail?
> > > > 
> > > > Hi @Konrad Dybcio, @Krzysztof Kozlowski , 
> > > > 
> > > > Following up on the earlier discussion — is monitored-battery =
> > > > <&pmic_glink>; a valid pattern? And if so, would marking pmic_glink as
> > > > simple-battery cause DT schema validation failures?
> > > 
> > > I'd say, no, monitored-battery should be pointing to the battery device.
> > > Please fix this on the firmware side, so that the firmware can report
> > > having no battery at all.
> > > 
> > 
> > This won't be fixed in the firmware on my devices.
> 
> Why?
> 

Because at least the presence/absence of the battery is modelled in the
ACPI tables that ships together with this platform firmware.

That said, I'm not aware of a standard mechanisms for e.g. wireless
charging or how this is implemented in the Windows drivers. This part
requires some more research.

But even then, I don't expect this to be fixed and deployed in older
firmware.

Regards,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > > -- 
> > > With best wishes
> > > Dmitry
> 
> -- 
> With best wishes
> Dmitry
