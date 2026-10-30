Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368907;
	b=Ta7A8kLQCw27HClLqao/arYBjgP+oCtzRQVdoxDJRjVtQJjZCXEhpjs5z+w6YdainQRC
	 TjgLbFIl3vG0C/28xbItAb4749DiNu2KDoUrPb466OoxeiJRnqQSl4lw2hYAHYcWjidgr
	 u8Z1YVSTVY8sX5vnp1Q7c9pq+1cTxdUC5Lt4gAiS9yva5v0pA3obLForDbCBEaAX5zPzn
	 MlB/VDDmxc240aEgitk4h+PJSxf9KapUiWjkFHDUzH7JM6zgaB28/ZVmHfZRqK/2kZDzh
	 rghL1kJsVMRedXl54nsbpaA4b3KXS1xm89fTPsdxqPZSdDy9nL/LOEGxFToFvUY3c0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368907;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GSTHr6nh7zIc64buOK91QH68PTZCFEuCdTatPpTgfSg=;
	b=L4oQRQvOHAHB41k+MB1zP+ZxrFuvHrS9XMhRAp+j6/FmTbSjBjNt6DPdqDfnmTu6z2+p
	 kJP5/ZaoZxiczWWbosrPNL/ThKyFH9fokYX5Mc2/eRS6E0g1oYNdhCCYzsVRYGUd28Lme
	 TOiNNJLB7/zlMPg0bNSUvZgmepN7kvFnsgCbAw5FZIPlnuHd/Xh14a0UUQUSVuSDIX146
	 3PJsGucvglxcE8Ivob8kY5S3JpaURtNaOt2dAL4C4H4s67dUuBy2tf79nsiG0xANdMsRQ
	 mGr3I7hlb7+AfJYGKmwjIUdekqbBvV3ABxKQat5j0QxdA/MBsHPhsgkQ0wr0/3VTFJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aySlwDMJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D52606A31A;
	Fri, 30 Oct 2026 14:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aySlwDMJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76F7C153B;
	Fri, 30 Oct 2026 07:01:42 -0700 (PDT)
Received: from [10.57.13.127] (unknown [10.57.13.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B65D3F59E;
	Fri, 30 Oct 2026 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793368905; bh=CBjM/kgm7b93hD/XSBn5BtbWlBow9tnu8Mo8LQbm7zM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aySlwDMJuejp2HuAywHeZq+ls0uUKG/LHhdsHM6Tf+m786W/OIpykVTHBZrovBhA2
	 n0F0cnlMhP3dlBiEWvO1gbjRM344iHuuFtiA8KeLLIol3ykSAZHO4pvkUymgkl9NaL
	 fBGjzlKB7JLUD/1lji2qfcUzoeHH0FeVgM9NS5yI=
Message-ID: <dc1d68fc-e4fd-4cce-9444-acc8031d5ba0@arm.com>
Date: Fri, 30 Oct 2026 14:02:13 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] powercap: Add generic zone hierarchy creation
 helpers
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <78abd10309b51ffdc3304997376d58e55b29487c.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <78abd10309b51ffdc3304997376d58e55b29487c.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 16:56, Daniel Lezcano wrote:
> Powercap controllers may need to create several powercap zones organized
> as a hierarchy. At present, each controller has to open-code the
> hierarchy traversal, parent lookup, error rollback and reverse-order
> destruction.
> 
> Introduce struct powercap_hierarchy to describe a powercap
> hierarchy. Each node contains its name, parent, backend-specific data
> and the powercap zone created for it.

[snip]

> 
> Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> Link: https://patch.msgid.link/20260806110159.69690-2-daniel.lezcano@oss.qualcomm.com
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
> 
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Add a static initializer and clarify hierarchy ownership and locking.
> - Check for existing zones and validate names and parent ordering before
>    creation; use zone for the runtime pointer member.
> - Allow NULL callback results to skip branches; keep errors fatal.
> - Use explicit locking and a signed reverse-loop index.
> - Explain the controller callbacks, their arguments and their relationship
>    to zone operations; update the description.
> 
>   drivers/powercap/powercap_sys.c | 204 +++++++++++++++++++++++++++++++
>   include/linux/powercap.h        | 205 ++++++++++++++++++++++++++++++++
>   2 files changed, 409 insertions(+)
> 
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
