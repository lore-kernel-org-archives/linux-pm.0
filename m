Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518F3B38B9;
	Fri, 20 Mar 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012759; cv=none; b=Aihf3Mg1JWiLhB6w4FeYFIHQnmyDGK+Kep9j2FMGEE/F8Ddpan36BTRHCcgkNHVt9Gde4qGqRGMoFMNU0UIQ9geNkBT5fuFhknJkN4MhpEBqg8vENVFmUL0bD5owkTvLBXcgdN7uDsSxphbR3WwEk5+z51DjTcsOcpJ5vZweLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012759; c=relaxed/simple;
	bh=hTEYF8dBsu30E1mvAypxJotJES0e3POjPVOiZrKLXkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8rOtR5f4WS4BN/KeY2zegEPtCq6XAdWoF2wkVQ7Cf2xlquouUogYJGGGdFVPFW3Ok6dU44EcD59ge+nsi/0y4vjJLAy17qB/lQu+Kv+B+RT5n6NZu5AjPTU3PRZauE2on6+kbAlhCMk/C34czUXsYFVCE1T0ael3U7XoaKuqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bokmuxWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bokmuxWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A392C4CEF7;
	Fri, 20 Mar 2026 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774012759;
	bh=hTEYF8dBsu30E1mvAypxJotJES0e3POjPVOiZrKLXkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bokmuxWxhSyFHsN9u7KGgPeNAk6zb0bFZfMEE5JSVewuk8tl5Il5GpZC0FZakLp7v
	 Z2xTAqq+eObHceACWep9rhFLpVHvm3n86s7S7HpyNVd6XTw1J6hlIUVsd4JpMmSOtD
	 L0FA0FDXZFFf35ZwumVHN7g5t+XY5EUOG2jdwp1ygv5FynK+floNiMghGnMugoxVgN
	 8byZnOfUEp6mjLafAo280J1V9UCXYJX1jmkqRr3n8m0K2i+efJnJQF4x2YK5dYx5xN
	 vu7WY2j8G7YdRwMl1zFlgpA3x6g8uQIJXwoCY2RCqT8CpTqIXsTaXIAAklKEFxYrrs
	 /oVNmTjDfpTmg==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/1] writeback: don't block sync for filesystems with no data integrity guarantees
Date: Fri, 20 Mar 2026 14:19:10 +0100
Message-ID: <20260320-tiermedizin-nutzfahrzeug-75077d86e976@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320005145.2483161-1-joannelkoong@gmail.com>
References: <20260320005145.2483161-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=brauner@kernel.org; h=from:subject:message-id; bh=hTEYF8dBsu30E1mvAypxJotJES0e3POjPVOiZrKLXkI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTu9Qzs64q6V1it/Zu34tkBvjydaYaHnnWmebbvFBM9v cCp7+jsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk0ODMy/JumKMgX+mjPh8fx x3eJdZXuO3GR+5zIxQwBgxqphaqaDxn+CiU92vtQVeD8k+zXVdfS0k70SR2StMkKPVaR+iwhpmI xJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 17:51:44 -0700, Joanne Koong wrote:
> Changelog
> ---------
> v2: https://lore.kernel.org/linux-fsdevel/20260319194540.3463371-1-joannelkoong@gmail.com/
> v2 -> v3:
> * Move SB_I_NO_DATA_INTEGRITY check to sync_inodes_sb() instead of
>   sync_inodes_one_sb() (David)
> * Move comment block (David)
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] writeback: don't block sync for filesystems with no data integrity guarantees
      https://git.kernel.org/vfs/vfs/c/76f9377cd2ab
