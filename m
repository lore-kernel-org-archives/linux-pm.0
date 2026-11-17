Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955989;
	b=1u9r3kAnR0lVBUT/eY5g2BJb9AbypDh6Sg7Yhml/VIwxeHHML4R/6DnxstwpCuTDtgUU
	 7C1ooc5zzGixuwkWCWG3gF6kP5jtZI7IeIYxUv+jCh5Z9IeJ9az3tEtnzO/AxTfc1TEh6
	 r35D2gt1S+hq68EG4vaj5TFZe7DZ+vi3WVyOIS4abqZA5ExPK1jRncjuCidMVeSfZFnnz
	 Akx0AkmVIltZpozqbDG/l082c9FeoBN5vJQY6M95Twz27s9uYAh5y0AZd8Pjh7U7kJLRx
	 lCfAr+9b8HcBOXylK7uF8sGj4KxFa6hovP+OBNM35DWDEAK6AcVHjNSuKStS7iJCxzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955989;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=utpAkiwFHBjBDfI84DKHsLpQh91ULE12v2wjMHOYcls=;
	b=Ci1OTuSEyPXwZri0HYS7WNWhmlbj4lCiLgftCUKGKGD3dZaFYZGi2p/1bHb+S3AZoIQS
	 XZD0QI3igFio+tTPUlSpdwbdvV4SeQXuDnWnL9hx+bZm1vXQo/MXcco+NF4mjQhCHxUAk
	 x8a9G4xFyczF24mfWmicoVX/B6oOfmHEJ4yFhOnKJdI0+PMYr6WmnDlZfeiWdTwPWqc/M
	 FjYJ6Z4zCZqXu2yFg7aSj+vcOs9ayizXO4zjH3zEUbHJ1nB8KFNN0gVpGTs19oMTqZm+k
	 YMOrXrnjHF2nydn/tVEJlOOj0VrcCdOGEiMWWHB/sWhNwtHNK2wlJoS+HwX51VlccOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sverdlin.org;
	spf=pass smtp.mailfrom=sverdlin.org;
	dkim=pass header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=VpISasGt;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=WPQqpMNw;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732A606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7732A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=VpISasGt;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=WPQqpMNw
DKIM-Signature: a=rsa-sha256; b=VpISasGt6hFOUpKJTSi8dBra3gbAk0b9ucNeEEkvSqEDrMQnNovWvDWBhHWiWmB45EPYqReyCK7Sn6X/U0djwvify9yCIB43hDeIbXKLHM5QYUUSRGJUzUid3yOjmEyDLYzhjxt1IXUfFaBOROF5X9yxvrvqn6DfiUsb4gpUlQoARK8KLCElCUCDYdQk8eGi96Bo9QQKXDi39+dxnydUF5ql3qVR/IuXM4iZI6ioJFs4l7aFD0rmLu/0RtbJMt1tsuA8PHouvRhjf9ZQFvzcssgv1IzBPrE9U/TMQ09b0Tu5iZkhLHc1P7LScvCpfmMt5NOde73baMDHiAKN/k9png==; s=purelymail1; d=sverdlin.org; v=1; bh=utpAkiwFHBjBDfI84DKHsLpQh91ULE12v2wjMHOYcls=; h=Received:Message-ID:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=WPQqpMNw/2XWir5D2XHi3oGT4BNQ0Vp9yoeFLqxVPB+h019xYU004bkv1X/PlsK67Dkdy0Hpo5UvS3N+yw9L6WJZ6iF+DP23jHF3CvXu8rvhhzBWA8YdUrpM482YqXQ0ZXQqbukhRsY/CtzdI3yjQ9dkV9eLUzPhdOJJT8LxHZkbRS/U4XovujIi3W6Lw5Fik9BatQ6tO+mRUeD+AGetIJ9lkmtcGhua93XPiJYItjVwwsGy58yR1mBIVCc1MqeOpGuJcvN/Dnr9dAAM22CR2snE5SGZh95gT6gUZfzjDsCU5y9XdoUck1nhVyt73hHcUoda3qWDI6XEJtvZ18DbhA==; s=purelymail1; d=purelymail.com; v=1; bh=utpAkiwFHBjBDfI84DKHsLpQh91ULE12v2wjMHOYcls=; h=Feedback-ID:Received:Message-ID:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 150623937;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Nov 2026 22:53:04 +0000 (UTC)
Message-ID: <f7752d1d155491876ae5d4bc1694c01c8d86b789.camel@sverdlin.org>
Subject: Re: [PATCH 5/6] arm64: dts: allwinner: a133: Add CPU OPP table
From: Alexander Sverdlin <alex@sverdlin.org>
To: rajanyadav0307@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Tue, 17 Nov 2026 23:52:52 +0100
In-Reply-To: <20261104-a133-series-v1-5-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
	 <20261104-a133-series-v1-5-58217cb33a87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Rajan!

On Wed, 2026-11-04 at 22:41 -0600, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
>=20
> Add the A133 CPU OPPs from the vendor BSP (sun50iw10p1.dtsi). There
> are ten voltage sets, speed0-5 for the a0-a5/a6 grades and speed6-9
> for the "high speed" b0-b3 grades. opp-supported-hw selects the
> frequencies of each grade:
>=20
> - 1464 MHz only for the a grades
> - 1416 and 1512 MHz only for the b grades
> - 408-1320 MHz for all
>=20
> The highest voltage is 1.18 V, inside the 0.81-1.2 V recommended
> operating range of VDD_CPU in the A133 datasheet (V1.5, table 5-2).
>=20
> The BSP uses 1008 MHz where the A100 table uses 1080 MHz, at the same
> voltages for a0-a2. U-Boot starts the CPU at 1008 MHz, which mainline
> now reports as an unlisted initial frequency. This table follows the
> BSP. The BSP table stops at 1512 MHz, so there is no 1608 MHz OPP,
> although some datasheet versions list 1.6 GHz for the A133. A newer
> factory kernel adds 1608 MHz for b0 and b1 only; that is left for a
> follow-up.
>=20
> The table has the A100 compatible as a fallback and the speed bin cell
> first, so a kernel without A133 support selects speed0-2 from the speed
> bin and gets the voltages of the A100 table, with 1008 instead of
> 1080 MHz. It needs the efuse cells added to sun50i-a100.dtsi in the
> previous patch.
>=20
> A script compared every voltage and the frequency set of every grade
> with the BSP file and found no difference.
>=20
> Claude Code (Anthropic) drafted this table and its message from the
> vendor BSP device tree (numbers only) and wrote the comparison script;
> I reviewed it and tested it on a KickPi K5C.
>=20
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0.../boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi=C2=A0=C2=A0=C2=A0 |=
 172 +++++++++++++++++++++
> =C2=A01 file changed, 172 insertions(+)
