Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A43E5572;
	Tue,  5 May 2026 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018999; cv=none; b=Y1RRjkTDAR8BdRc4lTgQqsBAzxx9zyYFYv6akCEeYbcvSmm5rLJYu24DZJGJsCY/dFIFm0RIsP2kTdMMT2h9LsOShkIRVZZBLP3LI2L/Co7t+o6G6PSJPbOnFb/ZgloZ7JsnSCCvPHvdDBbb98Pnvr67gHnFzLLuLRfvYo9BQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018999; c=relaxed/simple;
	bh=wngIzFQY61LFVz8abOPGp4EbGemyax42mCgJV6p6iPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPuT1IHqpmNVaUOWJjoqyvquxPZTHFD5w5TxjIkvfJoSkSi+SqKe/syFcCJNxwzS3/Ci8cZoBVu4/k+mb1vcklyOgQX9SIib6gctPsahVlZCSBj79S9z4RKoZ1gh78/Yr5m/EQ8Gq0F94SCRyWv1OnEd/jtIiFr1nr7jmHkqtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=We36GZ8M; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="We36GZ8M"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC3A1A9A;
	Tue,  5 May 2026 15:09:51 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FEFA3F763;
	Tue,  5 May 2026 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778018996; bh=wngIzFQY61LFVz8abOPGp4EbGemyax42mCgJV6p6iPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=We36GZ8MM/yfvHjkDwIuTLTWBu69Uu4K483k5nWZL7vMfmQ4YB3opU2gB0AvBR5d6
	 NN4zIXVRJbTrS6+tKe/DoqCZiPBAsO1U8hnECuaDXL8f/wf8hC1ig3gcbooPpCFnIe
	 n+DzMrjBVVl0hLAGiSJ9GiAfUunk0ZEi/NDbqseY=
Date: Tue, 5 May 2026 23:09:47 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 09/12] firmware: arm_scmi: add Powercap MAI get/set
 support
Message-ID: <afpqqxId9IkyFIAm@pluto>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-10-philip.radford@arm.com>
 <afpUytkInNKLTB0k@pluto>
 <afpkpUcevUh_Z8kQ@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpkpUcevUh_Z8kQ@donnerap.manchester.arm.com>

On Tue, May 05, 2026 at 10:44:05PM +0100, Philip Radford wrote:
> On Tue, May 05, 2026 at 09:36:26PM +0100, Cristian Marussi wrote:
> > On Tue, Apr 28, 2026 at 10:09:18AM +0100, Philip Radford wrote:
> > > Add support for Power Measurement Averaging Interval (MAI)
> > 
> > Hi,
> > 
> 
> Hi,
> Thanks for the review.
>

Helo,
 
> > > get and set operations to the SCMI powercap protocol driver.
> > > Extends scmi_powercap_info to store MAI configuration and
> > > implement MAI get/set via xfer and optional fast-channel
> > > support.

[snip]

> > > +static int scmi_powercap_xfer_mai_get(const struct scmi_protocol_handle *ph, u32 domain_id,
> > > +				      u32 *mai)
> > 
> > ..bad alignment and till now we try still to stick tpo 80cols in the SCMI
> > stack if it does NOT really hamper readability...
> > 
> 
> I will address this, but I'm quite certain it wasn't flagged by checkpatch.

Oh yes..this is currently a convention we kept in the SCMI subsystem (the
original 80 cols) BUT kernel wise this line length req was relaxed to
100cols a few years ago..so checkoatch will never flag it (not sure if
it is configurable in such regards)...

... so you are excused :P

....anyway maybe Sudeep is fine to relax this...I dont have strong opinions
BUT since all the stack is 80cols at this point...

Thanks,
Cristian
