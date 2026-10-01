Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE449E126;
	Thu,  1 Oct 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860251; cv=none; b=ASoEAq+mXNZRE53UPX8dH3/b3dA00jmVWSzBlur7vXmIunlbDM+KztrUBmy70oSMLogQ9DMBTKMBNhCfvbZKsRD/VifjZzvOoJEAqwkE5YwYnWv3aktIR1BZYcFmdNvwpzuBpx0Sqc+mxnZTOXCyRQzdumfyEmhvwSS/FxNtW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860251; c=relaxed/simple;
	bh=XkKLnmFah06/AZG5r7+34hKAt7gauGCzgrcOlMR8aZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qtHkKokdsbfwEsFwl4NcXqAr3bj9VcpOpIDFVBtF+KoIdjLQ7Y3tK1DsCM3My/MwIVwqn3AYYScS9empjxNPQNPwqSHM5Zlo/olwls0Iioy0QawZQ+oRjJ4EQdAna2iGxPWCQpqV3BcQTxQIteotMxXQn2mQq8wmgGNuaCPy7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRPmBmk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRPmBmk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA251F000FF;
	Thu,  1 Oct 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790860249;
	bh=p/COd8m4uSbvnalEiSJHkoUnfeSbdkp88K1kpUnBTUA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=PRPmBmk7WhzFF2671//hPYcglq7J01lDeHsuoemldwONRWroL++tCZismD//l5HbE
	 86y241lSQdrHfitvssSHxHhRd3+Pai1rtYVmLNdnWWFk6intYkPgsbaVIEYeCgRsp+
	 E62R/Bm5Q8t6wYgypg8kMTiFsdHZMe10R8vFBgZyzXtFjOCqVyWG63XQZYPMZ5TJQ+
	 FK02cHbEP2oy4JDQ6HmTTUprqgdgcPzLAVhkYt9tcrtBEEAEtlVsT9OP65606MqRZN
	 pUFcgG2NXs95bi6a/0J6SX8ntym0leRQfvUeAcwyKRVyvY5abILYYl9H8cCJ5gwcHn
	 Fua5SLJgUmpRw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 15:10:45 +0200
Message-Id: <DLTIZ3CNCQDS.24NN9OMJG7AXA@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 0/3] debugfs: make debugfs_create_str() read-only
Cc: "Yichong Chen" <chenyichong@uniontech.com>, <rafael@kernel.org>,
 <djakov@kernel.org>, <quic_mdtipton@quicinc.com>, <vkoul@kernel.org>,
 <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-sound@vger.kernel.org>
References: <20260807100053.1089834-1-chenyichong@uniontech.com>
 <2026100153-unmanaged-impart-3adf@gregkh>
In-Reply-To: <2026100153-unmanaged-impart-3adf@gregkh>

On Thu Oct 1, 2026 at 2:51 PM CEST, Greg KH wrote:
> On Fri, Aug 07, 2026 at 06:00:50PM +0800, Yichong Chen wrote:
>> debugfs_create_str() has a generic write implementation that replaces th=
e
>> backing string.  Concurrent writers can race and free the same old strin=
g
>> twice.
>>=20
>> Instead of adding more locking to the generic helper, convert the existi=
ng
>> writable in-tree users to local file operations and make
>> debugfs_create_str() read-only.
>>=20
>> Changes since v2:
>> - Use scoped mutex guards in the interconnect and SoundWire conversions.
>> - Clarify why GFP_KERNEL is safe in the interconnect conversion after th=
e
>>   RCU read-side critical section is removed.
>> - Drop the unnecessary firmware_file =3D NULL assignment in the SoundWir=
e
>>   exit path.
>> - Use WARN() instead of WARN_ONCE() so each writable debugfs_create_str(=
)
>>   caller can be reported.
>
> Sorry for the delay, now applied.

This series fell through the cracks on my end. I also reported this issue i=
n [1]
and I agree making debugfs_create_str() read-only is the best fix for now.

However, it duplicates code and I think having a proper helper as suggested=
 in
[1] would be nice follow-up.

[1] https://lore.kernel.org/driver-core/DLPDB44JJRGJ.3K6JNS746M7QC@kernel.o=
rg/
