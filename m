Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664599;
	b=tH+JNdpIl+QCVNAjjD9zzKXK1FSwSYUUOOOE6pDxiN3AW+5Ui0cnRzIIDR8aLqJoKtSC
	 Py+DgkPcA2rpQ0TXn6PqeiL6hNnAK4q5lFlX1G/bGCggC+zz1r55gmxxj9F5qmyEX5a+h
	 p0mZAsDOmCv/CDHHOd/BUpzVuNNDtsaDuXeXPdRvdZxzerMxkbYlYh4EGf3R8Iw5m4tpm
	 eEDAjTo7j3MZ8y7ol88sMmDK0XWemXFBjnbh8xYR3UYlCvJe3keJGxpJRZXaBHxxVExmf
	 LwTUD705lBLQzDMUVV3F1vbRbyNyDoLodwRlyiml2H/6O9yCGo20QHqPEMqKylecLaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664599;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aZ3FSAhacOoA0G/LYvZBcAVEF7qI69cr77OqatyrH7k=;
	b=w/FirYVdee2zk+1mgzdWDj8uDZ3C7Q4SzVWh9pGYPqrhZX2vdBVxQ1nVkYN0K1KbgrBp
	 +4RPWkLkv9Mim3Ao4BaCH04t32ZfR8Rms9wNAlLMpm5To8+9aFdFSs7T+2dkCTSAVYYjK
	 wUYZ1o6A7euDKMb257SF9PVl9iCyZ1gp38Pp9C3f4w6eFo2PSq1xlPq7O9rdIVY8vL+07
	 xU/uPhtBaciD3asj/h2pcXsnog/cdpn2r/4719Rjb9WwhgMQULecfN0VB27xXHTlu9Kkq
	 a+oAI+rwxRT7MUena8pHEfBmU23FGSX3aHiihl4UnDnFS4m+wLCTUzRI2n48irgWJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i7gz2s1V;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D300606A31B;
	Thu, 22 Oct 2026 10:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D300606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i7gz2s1V
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04ECF1595;
	Thu, 22 Oct 2026 03:23:14 -0700 (PDT)
Received: from e121740.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DDEB3F7B4;
	Thu, 22 Oct 2026 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792664597; bh=LlWXz+PA+zM435hlpcLMlUTS430tdpoSr+PxDjy+z5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7gz2s1V+8RC3RRnbxmDymuL7h2jDLYk4Ge6j4Bzn2SRLYA7flQ08O1OMxby7Bu56
	 fhWnOI1gmkJasfrzwWWxO/ZndH9TcprW7UxVqeBKx6QilV93iAtNRoSjPa62tIPENr
	 TetS7yunMuQpOyiteMUIdn8f2NIqA0VkME13bNHs=
Date: Thu, 22 Oct 2026 11:23:04 +0100
From: Philip Radford <philip.radford@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v9 03/13] firmware: arm_scmi: Refactor powercap domain
 layout
Message-ID: <atnkCP6oB4xT65dV@e121740.arm.com>
References: <20260909220437.1254412-1-philip.radford@arm.com>
 <20260909220437.1254412-4-philip.radford@arm.com>
 <20261022-spotted-impetuous-kittiwake-b2adcd@sudeepholla>
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
In-Reply-To: <20261022-spotted-impetuous-kittiwake-b2adcd@sudeepholla>

On Thu, Oct 22, 2026 at 11:10:06AM +0100, Sudeep Holla wrote:
> On Wed, Sep 09, 2026 at 10:04:27PM +0000, Philip Radford wrote:
> > From: Cristian Marussi <cristian.marussi@arm.com>

Hi,

> > 
> > SCMIv4.0 introduces the idea of an optional Concurrent Power Limit (CPL)
> > for each powercap domain, where CPL0 coincides with the one and only
> > per-domain constraint limit that was available in pre-v4.0 SCMI Powercap.
> > 
> > Refactor the powercap domain descriptors and powercap operations to allow
> > future v4.0 extensions to cope with multiple CPLs.
> > 
> > While at that generalize the powercap protocol API to drop PAI references
> > in favour of a more generic avg_ivl naming, since from v4.0 the number and
> > types of averaging intervals will change in a non-backward compatible way,
> > so let's bury these changes within the protocol layer.
> > 
> > Last but not least, make the necessary changes to the ARM SCMI Powwercap
> > driver in order to support all of these new capabilities.
> > 
> > No functional change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > [Philip: Adjusted domain_id comparitor in scmi_powercap_pai_get]
> > Signed-off-by: Philip Radford <philip.radford@arm.com>
> > ---
> > V7->V8
> > - Fixed conflict due to changes in 7.2-rc1
> > ---
> >  drivers/firmware/arm_scmi/powercap.c | 182 +++++++++++++++++----------
> >  drivers/powercap/arm_scmi_powercap.c |  52 ++++----
> >  include/linux/scmi_protocol.h        |  74 +++++++----
> >  3 files changed, 189 insertions(+), 119 deletions(-)
> > 
> > diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> > index 96d55921fefc..7c2dbba5002c 100644
> > --- a/drivers/powercap/arm_scmi_powercap.c
> > +++ b/drivers/powercap/arm_scmi_powercap.c
> > @@ -123,7 +123,7 @@ scmi_powercap_set_root_children_enable_state(struct scmi_powercap_root *pr, bool
> >  
> >  		if (!scmi_powercap_is_control_type_child(spz))
> >  			continue;
> > -		if (!spz->info->powercap_cap_config)
> > +		if (!spz->info->cpli[0].cap_config)
> >  			continue;
> >  		if (prev_state[i] == enable)
> >  			continue;
> 
> You seem to have left one use `powercap_cap_config` above this hunk which
> breaks the build and hence build bisectability with this series.
> 

Apologies, I was sure I had tested breaking the build throughout the series.
I'll amend this.

Regards,
Phil
