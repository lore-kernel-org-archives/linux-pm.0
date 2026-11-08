Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158667;
	b=BuV3ag0X+DKRCxZGtDumKz4yjiYBbqGhsimNRcIuk1mRaPKkiu6JD0xadwZmzZcmofoY
	 4CLpSv35lgpDwcRKlrI+VN3sSlLCYAtB9ajyaJm6pl6GD/0kkwQqFGNYs1nzT6uGIoTNs
	 5dTmO9+xvDJrRTG1h9R9N/zyB5gOmkIkUibKz1FZXqXjWwPV8l/J6pvfC/SHF+gt0l5CI
	 ycqH0JCzXcgqL8UnaAKHCxyRyDOT1P4u7gqx18TqgBko2H5f1u3zrT0DmI+J+Ay+StQNh
	 0YU59nWtjG8Konf9XPD812cVjKu0hgp7H0mPJHFIfHb8i8nbw9QynkPnnNv33AEQnbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158667;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=rVreDcV09/jhRW6Avy9X0VDVq0o8YVCljWqSlYfjtBc=;
	b=P4nyEJ+jm4mLJay0EfAIsb8KL+MzT8dKsH8PIhoOPDkZz9wlcMML1/m6ftKkBx6+IiPu
	 iwGQs4/fUBelZk8qcbOEJFGYMeXi6PMxZmZNckdBNTNaA3YQOHT7Fggf6y8spXWiCjzCL
	 bI5CRtEhm3aQHu5GBoqKYn7iZt9h/Ib8/7fa7cKEkp78Fl1ct4IXKLff4NbyUFzTQco0f
	 6DqD/sb2RGIQijtFUmP/SgxQDFV3lWabF0M8zl+4yHHBAFDUwCt41pP+TA2bQQkyunwLA
	 WkvqfispVkxgFTkELG2f1pYOSklHGhfdGj36MhkhUTKJuQUaaXq7eWwzDQEfS9krucQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=XEDqDMeZ;
	arc=none smtp.remote-ip=203.205.221.210
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195D606D80A;
	Sun,  8 Nov 2026 17:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C195D606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=XEDqDMeZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794158664; bh=rVreDcV09/jhRW6Avy9X0VDVq0o8YVCljWqSlYfjtBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XEDqDMeZi79XSwIiNuzkmh7GPg/BDTMqxaQEMDL7RIfD1ZFI6G79UxQPoumC1geXf
	 jNhL47gCdjGXgsQ5NUdEUPZe2ZPZSS5xqSzwAuZJXuMbCl2a6vF3l9F7TX9K9s+k17
	 SEQGkAck5Kha0CEhZ9y+pm3K4EaD+JMtqfaeWmEw=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5F906C5D; Mon, 09 Nov 2026 01:23:57 +0800
X-QQ-mid: xmsmtpt1794158660tqkcohesj
Message-ID: <tencent_E1DFCE4AF97ABBA238487CDD5BA73040DF07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+xh03pNn9JIu4Ay+cjhNLf7DEGFLsR8FH8JSsV7cbqft0wnDQb4
	 2WemOFW1otbO49XBdcxcK5cRixk+Xb/lwuNCHvG1mFVqjThz6FIRv+XyZBrPLh+qilUOA9s+2AmO
	 PTABgYojcKufU0XypQHm5Afi5CxYcqbwcTDGGx0Ga1on/LYUza6rhUMHT1nVXT0UIv32ArzCgfwZ
	 E2mVpNwOlSHYgip+3iyW6dJ/3pR9ddr5PcR3TYFqYMTI4Yz2Y7gnePw/RlkT2tBgxo4Z7QUIikEU
	 fbe8/9eI2IlA7X/UsRv8dS43fMAS74VjVFOvcEa516KCFC/Xg/qK4B98mbp8q0at5fy8pYf57uYR
	 IOMGfNvSb010I+4jcR7pG6Khu9qd5AyM9e5KekDZFAKe9zrUpVk2iEocGkeuIUiOgslFitchqZXl
	 qwNiUCiTWfUha1bLNmdO12D4EyJNkomYq/5tLQ/VbLWpHw80VQSXBQ9C9SZqpsqFgTXr6wJ7nOT8
	 ckLLzXlThIWXIMiH2XlplODg8dXNr5KjLOn/BFt0tJ9+bNTpDf+w/GRgWzcLrfghGrG52X+hR11W
	 ABgjvMYMwIeA9+cmShcz5/+BoL0aCcsICXyhxCYZZIvL2FZ3H8kK+yE89xM8fNLBen4uTHKrxO1v
	 lHLdX6QMoLaoTjk835nlYnQ/mHDMiwFFZJLsaTmI1UpbNkaB4PAeHFILVZ+4sZFh7WzKazFh9M9H
	 DOTKXwXnMG9kWsaCrPUQoeNBqSVmqxe/Ubn7PzuMpL0rqwLpQEmUVs6fHRFWY9l+V1t/I3oUhhJq
	 cRGK+AUc39+1Icx6E1GiB0MdpxvueiwSsf+G4eB/ZDUuEmVOZt66mddKTVFsdjRDpKnNdS4S7NzF
	 wkSFjZ8/D8/LXs/s9SWk/1WB/PoGWiJDv49xVOks3Cum3YT39tFJUxVHe5V3M9Kcqu+YpI9gjr+9
	 mb6oxu6Eru4BN4QU0r+IR7hPL4dNMZofVkq2e6VKt3lacx/9zCx+wm6MFq2DUAKBkJwMpD5kuZcx
	 JzQWc8Aad51HAxBvpghiwDjY2CNt5BWFqayaLEaUp/oMhnqc+dQZ6r6Cwkhr0=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jiawen Liu <1298662399@qq.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Rafael J. Wysocki <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH] thermal: rcar-thermal: fix runtime PM cleanup
In-Reply-To: <tencent_64AA3EA1C81C724ED7D0A90390E677BC5205@qq.com>
References: <tencent_64AA3EA1C81C724ED7D0A90390E677BC5205@qq.com>
Date: Sun, 08 Nov 2026 21:22:12 +0400
X-OQ-MSGID: <179415853266.5.12241913322882574102@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Geert,

Thanks for the feedback. The description did not explain the failure path.

The probe path ignores a failure from pm_runtime_get_sync() and continues
initialization. If it returns at that point, the usage count increment from
pm_runtime_get_sync() and the enabled runtime PM state both need to be
balanced.

I'll recheck the unwind against the current driver and describe the affected
path and cleanup explicitly.

Thanks,
Jiawen

