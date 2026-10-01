Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D50496D35;
	Thu,  1 Oct 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862603; cv=none; b=EaTGBP9UixiJmwibIgf5Zh9hCXHk0Zh7VPIo/hlhXRn1+EXGdGZRIaLSZGltMoAegLHXCyFOgY08IK82A2+R3UpLtBnniG1QP+TC8wTd4kB07k/GiLnjVSDqUc/cIGE1hsHa1rox8SdI50m78XzRovNmB7NCShIjOZIWnqFLD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862603; c=relaxed/simple;
	bh=zQ9MtrvJfthHd5Vg84A7ZAy6wwcDhigK3I4PjJDOPMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=t+zCUiYielXQlJ6QrHf2EouI6fa1vAT71eqwKeAbuu3+QUZPcgk99hGK8oUcLZLqGAdZ5KqNjOw8BZFetRwLUgE1C3zajlhyOcycMEzzeXdx5IVmMXJbeSQ+cHNvuaIUnxEeZi9/ZqobQtqtVy/X80yIJb7sab8jyOoOovUpuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO8uIpvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO8uIpvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285EE1F00898;
	Thu,  1 Oct 2026 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862598;
	bh=sXzExsQ7ko37b3Osdz1dvDlhOHBAgHiJiu7t1kn79LQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=NO8uIpvrwNZMMO29VNksLG+RliC7ewccbvWQrg1gu2HiClGxxN31B9nPLDzbaU8X8
	 9ShhxDp1khV1a+mLptUYOfjeYcO1oXEIyrGmA0i1KMqv+HVEWneMBnfEsbZJAwVkb5
	 mc7kGmp59awUEw8u492ae0CkWUt6ZWHUkk4tuRlDouiAbQ52MzuC+/xTNiTZjsQo6t
	 cTzEPfzLMdcJPV2el+rVAaKXs6gU17aA/jVZrWrFsa5zgCWJcShSKmJjZov4P2vLyf
	 fKmnHTO1tkN7ziKwYlA9uDFhJcC116G7u9/7J4XJmbmL/LagmnfrNljz+6fw78ZJ42
	 op3HUq56R2iMQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 15:49:54 +0200
Message-Id: <DLTJT271O5MJ.29DXT8VS9712I@kernel.org>
Subject: Re: [PATCH v3 0/3] debugfs: make debugfs_create_str() read-only
Cc: "Yichong Chen" <chenyichong@uniontech.com>, <rafael@kernel.org>,
 <djakov@kernel.org>, <quic_mdtipton@quicinc.com>, <vkoul@kernel.org>,
 <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-sound@vger.kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260807100053.1089834-1-chenyichong@uniontech.com>
 <2026100153-unmanaged-impart-3adf@gregkh>
 <DLTIZ3CNCQDS.24NN9OMJG7AXA@kernel.org>
 <2026100139-deviancy-direction-edea@gregkh>
In-Reply-To: <2026100139-deviancy-direction-edea@gregkh>

On Thu Oct 1, 2026 at 3:19 PM CEST, Greg KH wrote:
> On Thu, Oct 01, 2026 at 03:10:45PM +0200, Danilo Krummrich wrote:
>> On Thu Oct 1, 2026 at 2:51 PM CEST, Greg KH wrote:
>> > On Fri, Aug 07, 2026 at 06:00:50PM +0800, Yichong Chen wrote:
>> >> debugfs_create_str() has a generic write implementation that replaces=
 the
>> >> backing string.  Concurrent writers can race and free the same old st=
ring
>> >> twice.
>> >>=20
>> >> Instead of adding more locking to the generic helper, convert the exi=
sting
>> >> writable in-tree users to local file operations and make
>> >> debugfs_create_str() read-only.
>> >>=20
>> >> Changes since v2:
>> >> - Use scoped mutex guards in the interconnect and SoundWire conversio=
ns.
>> >> - Clarify why GFP_KERNEL is safe in the interconnect conversion after=
 the
>> >>   RCU read-side critical section is removed.
>> >> - Drop the unnecessary firmware_file =3D NULL assignment in the Sound=
Wire
>> >>   exit path.
>> >> - Use WARN() instead of WARN_ONCE() so each writable debugfs_create_s=
tr()
>> >>   caller can be reported.
>> >
>> > Sorry for the delay, now applied.
>>=20
>> This series fell through the cracks on my end. I also reported this issu=
e in [1]
>> and I agree making debugfs_create_str() read-only is the best fix for no=
w.
>>=20
>> However, it duplicates code and I think having a proper helper as sugges=
ted in
>> [1] would be nice follow-up.
>>=20
>> [1] https://lore.kernel.org/driver-core/DLPDB44JJRGJ.3K6JNS746M7QC@kerne=
l.org/
>
> Yes, that would be nice, but for read-only debugfs strings, let's keep
> writable ones away if at all possible :)

The two converted subsystems now have identical code that can easily be
generalized. And I think we have other users that open code this too.

For instance, soundwire would collapse to just:

In sdw_debugfs_init():

	/* Initialize struct debugfs_string */
	ret =3D debugfs_string_create(&firmware_file, "");

In sdw_debugfs_exit():

	/* Free struct debugfs_string */
	debugfs_string_free(&firmware_file);

In sdw_slave_debugfs_init():

	debugfs_create_str("firmware_file", 0600, d, &firmware_file);

In cmd_go():

	scoped_guard(debugfs_string, &firmware_file)
		ret =3D request_firmware(&fw,
				       debugfs_string_read_locked(&firmware_file),
				       &slave->dev);

Thanks,
Danilo
