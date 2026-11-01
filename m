Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571370;
	b=wwvtjfNGgpqhxjxIGnw3RugFlRbaLa4S2bRFsn860x1eg0D3ymB4TlU2g3jjZPp7rPXz
	 1EiSvDUmuUJ5Ne6M+yu0rgi3uZie7ej9LfLHWf/mg5Qxdn0E/YE0aHASo92fP/zv83ysA
	 oc9b5S1jEDvL9P7xWt4N0eAFQ3YQvvgqtXUYGJy4j/n0s9d5LwFMPzqmQBXG5+SGQhsuz
	 vjfRy4wnJ3B1SA47nEbb/xKFnmsmlvA4Q/v0e15jBIVtDJJYAHj9iBsFu67xz34lTfmjf
	 n1+2NnjJuHCoXrwkLjfcD/fUmiu/xmXMMr0h8sOkR2/x+FR457qEotIBhjLZCVL9F0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571370;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FrrB0roc1oSA1dp/45kSSfoFg28Ifiyl/SVkMu1uAs8=;
	b=hZJDu89CXUlbcDO/f5B8mx6pEymLg0uTIYgMlnoMDh63AwQvXTUpMK+utyiwTrjEK0cM
	 9beettLsRCN/6B4t11hWL//W09ytlHQDcxhAE9T9XwMDexOP8YLVzEkWxV2/BL6eP+pzK
	 7ZVlMDCtNrtdDKHp2PgZTYI0n3L/YXYo31nzOiqsaC7l4Hrq8StCIh7alAz83xVt8Ko2d
	 Qh3z6OvOuHUi9+3W8XFmnHLVjASej9q5AAKNhLIjSFJb8SD1DORMsRskp8xs/CFioHxoo
	 vXJXuWs4mo+xBkdIu7g707ejKSblzI+pUNvY7wkT4WKIdgqJIs0+uPFSMiAyHkTfFLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVS0HPuC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA860A2630;
	Sun,  1 Nov 2026 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVS0HPuC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AE61F0093A;
	Sun,  1 Nov 2026 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571369;
	bh=FrrB0roc1oSA1dp/45kSSfoFg28Ifiyl/SVkMu1uAs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lVS0HPuChtOSonktA1xifZwoIv4if9F4XQhhuGT/g4YMUcn+hrR2WWlPxIDRD5LAa
	 3Xax/qmzqJ0HxPHRgNhzpCgYKZvNpoE0u1R/Ea8OEJltF8fUoGN5ov9nYh7Gq5VyJI
	 Zq2e5PL+kio75M2BKkIigt77eWzy/TpjITkkdc3N1ImA9Y9rdNFpgRlVVoVcU9hTc6
	 uGg98+0CjOGI1iuhaWBVd9E4WMHR5sDAoJgBue+Vx585LLkSVSpgQxNwB5mTObGYR6
	 GMLWyll+JB8/ygVe6KBDhjjAVCv6HT80dnGvjBnr9Xp+RCL8K0jQap6yRgCQosYn4w
	 tbOpC9WxvqZ+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D33C38003B8;
	Sun,  1 Nov 2026 22:16:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Add RISC-V RPMI device power service support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357136804.2624073.16073798637775674384.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:08 +0000
References: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
To: Joshua Yeong <Joshua.Yeong@starfivetech.com>
Cc: linux-riscv@lists.infradead.org, rahul@summations.net,
 anup@brainfault.org, lftan.linux@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulfh@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 joshua.yeong@starfivetech.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Ulf Hansson <ulfh@kernel.org>:

On Thu,  3 Sep 2026 17:23:44 +0800 you wrote:
> The RISC-V Platform Management Interface (RPMI) specification defines a
> modular and extensible messaging protocol between the supervisor software
> and a platform microcontroller (PuC). Among the service groups it defines
> is the device power service group (service group ID 0x00009), which allows
> the supervisor to enumerate the power domains of platform devices managed
> by the PuC, query their attributes, and get/set their power state.
> 
> [...]

Here is the summary with links:
  - [v3,1/3] dt-bindings: power: Add RPMI device power service
    https://git.kernel.org/riscv/c/53d17430e0ef
  - [v3,2/3] pmdomain: riscv: Add RPMI device power service
    https://git.kernel.org/riscv/c/f94fe707c5b7
  - [v3,3/3] MAINTAINERS: Add RISC-V RPMI device power driver
    https://git.kernel.org/riscv/c/396a18344d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


