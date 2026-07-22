Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3D353A83;
	Wed, 22 Jul 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680255; cv=none; b=EBupUzq4CbER+WBlH4mj9/6Tr4DhC1s07SrC6Rel0B+gaGFZV7uu7ou/bDbnlP4c8DYHfNYptyhkT7Xfp8rGhzIcgXBAuyeoqfX09UaWByr6FW9aJ/JczuTTQ/ZADQOPxx4Yj5SVHZk0DVoQUNE8FtzJgWAs4DbEo8vd4QGfHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680255; c=relaxed/simple;
	bh=WfcGv2cG8OpZnOEtZDT7rv+r9kA6dCX95jH5OIloFqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CUou3k2ahE86EbipuJ4GjbzhfC7TAXp1yTHGKwM2EYkNHXjAkrKGEqkDT5cLf1f8Cj4gdeqRFduqjB72P6LlKD47gRsvWGAEL30tY/vmD2+5seVePSg9oLPZUuXzR7cR6xXpHLS03jDe9QCeXXnvBp8yobmL98hoU2xuOOidWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D94B1F000E9;
	Wed, 22 Jul 2026 00:30:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 206A3180767; Wed, 22 Jul 2026 02:30:51 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
Subject: Re: (subset) [PATCH 00/10] Add sysfs entry for system load control
Message-Id: <178468025110.524960.11847050585350482153.b4-ty@collabora.com>
Date: Wed, 22 Jul 2026 02:30:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 29 Jun 2026 17:44:56 +0200, Waqar Hameed wrote:
> During discussions of the development of a new driver [1], it was
> concluded that a new `sysfs` ABI for controlling the connection from
> power to system load is wanted (often called BATFET). This patchset
> introduces such one.
> 
> There are already several drivers that are controlling this, but with
> their own custom `sysfs` entries. The drivers in this patchset were find
> with a simple `grep` for `bat\s?fet` (there might be more?), and then
> converted to use this new `sysfs` ABI. The old custom ABIs are left
> untouched of course, for backward compatibility.
> 
> [...]

Applied, thanks!

[04/10] power: supply: rt9471: Remove superfluous unpacking of propval
        commit: 45413165bef33bb7d5544a3331f39492cdde9418
[08/10] power: supply: bq24190: Remove unused watchdog struct field
        commit: 0e2a6f7c0fa69293fa6f53dcf3406a9d7a1b1816
[09/10] power: supply: bq24190: Disable watchdog with bq24190_write_mask()
        commit: 50ffe6eedbd8d1ff8fbc2b451bbade8ca3063487

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

