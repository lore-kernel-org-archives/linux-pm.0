Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955155;
	b=cas9VGa7GcwrH3VEyILJkVTpquWD6oWyyJdm0WItfNdYrPMmvVP6ZMkmDTfxq/f9MnJj
	 8Z/hlrV+3jETMns8EiScfm82vDkRQhdTKrQjOPcw/tObqXwRnaCRs3gIsNarnPP8a1Fvj
	 GsHRl49dA1yDWqOL+EyFoc+h47I6kqdAJjnLASDfpasI8tBF9Y8RAUR8TYSRHqMxDy5DX
	 wjao+geQR9jIgxR+X/rQ/fbGN8xiJbQEhoKbTRanfFvnuCzokyJAar4zvc08rbNhp3uLK
	 T+K2HVLl9zf4xKm2/oBol0whDvIJ+qIizuNNX7+Vb44Tklx/aTPRc8stzjusllruTkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955155;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=5sEtgRVogw5vp/h0xvhUk5WCTcmJS4WcRx79k13IZ7o=;
	b=a4G7BzfzBuZBD8/0YYR8BiRd/+6Es4nFuClS8B8ytOdKxspCsnhkC4tYyhtvegV5nNJX
	 Ata4UAZQ/+SeLmO+CZXMhX1JXaXCY/arsG5f4YwVmLLhg9zDNRkRDaCA4yfyvGJAsJfOy
	 fSJwmLnvz2vGswTlNQF3Tx4BCqYCyCJ227cwfA7jwyg3SqO5FKhDZUBQY6wMa0nA3cVaJ
	 irdE8pnCjb5DBZZhObv6el8ClOO7SVfiKEWpJ9eGQvh5khPAPHIBPwz2JWFiU9Up7B5FN
	 b/c2JXUceRaLSwyZ6O25TN4X2SEhOPb0GTN/WJKHjL2Qoru5U3IaXQremADQPQhxYrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sverdlin.org;
	spf=pass smtp.mailfrom=sverdlin.org;
	dkim=pass header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=Osfs4yAE;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=CC47ZTMg;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D37606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=Osfs4yAE;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=CC47ZTMg
DKIM-Signature: a=rsa-sha256; b=Osfs4yAEPBTvxOlHIS9gTliHty7sECWi442MUl6m94BF76iTAydV3SSqFJkT0ozKs5E9x/frlA54amxyvvGJEWtXEBl4DYKFtUbLB0kKGrJkLpx2CKsGk4l+cCVNI4tTgFkmuEe1AX7ZfEtqXqnUOOouuoQQ7PpGwN/9zyKXsljUOIc1QJjkVsvm7ADk2mClY7oTE8/JXSDSsdMFDv5dNn+UEZa8oKc6fzLbs9nlRTZdmWQRsksPshv/7gppjR4F5Ja76M7tu7lCUMKheIL/NH+1plvejI1nJXI6RZH0h3Kx9lPBV51BJVkfbmsfNOYfhyaTV221YpYzGz/9xOv8ug==; s=purelymail1; d=sverdlin.org; v=1; bh=5sEtgRVogw5vp/h0xvhUk5WCTcmJS4WcRx79k13IZ7o=; h=Received:Message-ID:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=CC47ZTMgbns6WCHZTbtn/MKMfgXerrYcMlMZt0M5fmqyTyHzNLajBOhjot6aZhBiyAlS5DADaOz883TZWEMo0TjEFpxGpmjIEjjnU98Qdd9KNlme3SIDJ7GeGO6CJrKOqD8mTvJzGXKXHVQCd9Klm1KPSKKfGXw4UuN4Ga/eew36Kb6jOX/+UXPH51S65PjFL7pz6e1k1UsEqIxinUVczhZbco2ntZHQtqEGmN7iMekzBz+ktJecZfdPmsGdCAlY0hPl5/87pWOWKdArynsyJWh0eDE5lWhgOi0WY22aphjD1v6upDFDy7vK+0Dh6Qe9MPA08A9xGXZ4bHhXQjwguA==; s=purelymail1; d=purelymail.com; v=1; bh=5sEtgRVogw5vp/h0xvhUk5WCTcmJS4WcRx79k13IZ7o=; h=Feedback-ID:Received:Message-ID:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1496021118;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Nov 2026 22:39:10 +0000 (UTC)
Message-ID: <f25ef379708f06f459dd7c4576ac6c47694fc74b.camel@sverdlin.org>
Subject: Re: [PATCH 4/6] arm64: dts: allwinner: a100: Add A133 speed grade
 efuse cells
From: Alexander Sverdlin <alex@sverdlin.org>
To: rajanyadav0307@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Tue, 17 Nov 2026 23:38:58 +0100
In-Reply-To: <20261104-a133-series-v1-4-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
	 <20261104-a133-series-v1-4-58217cb33a87@gmail.com>
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

On Wed, 2026-11-04 at 22:40 -0600, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
>=20
> The A133 speed grade selection also needs the chip marking ID (SID
> offset 0x00), the word at 0x20, whose low 12 bits the vendor BSP calls
> PCPU, and the word at 0x28 with the bin extension bit. Add nvmem cells
> for them at the offsets the BSP uses. The H616 reads the same kind of
> marking ID at offset 0x00 as its speed grade.
>=20
> The cells are used by the A133 OPP table added later in this series;
> the A100 OPP table keeps using only the existing 0x1c cell.
>=20
> Claude Code (Anthropic) drafted this change and its message from the
> vendor BSP device tree; I reviewed it and checked it with dtbs_check.
>=20
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
