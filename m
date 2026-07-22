Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA60434417;
	Wed, 22 Jul 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705402; cv=none; b=T8C+BHYKiIIgUO5KF0z5CjJX4gIwDkhkOGF1aKpd97UnXc9niriGCQu2KK+bX9BOsWehtRgMIaggO9UbNOEBcfl5oocKsAwic8yCLE15TGw7bhJamDRaYrEZVFDaUCCwEw7ANf64I6geb+jEuNzbWh26vL+VsnUHuzj/FqzPnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705402; c=relaxed/simple;
	bh=pHNyv6JsIjY9eaeoYslwhuyBTv3iH4SMHJeoYOKTwoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=menRHfkLyoGFMDq8RPRG1+aKxehsjhxvs9XqwPmSvA9YW7mWJtF5utIBhUDu6n9k2tmiRgd895Vex0PhHQrDCb9wSB5/eInA5H0TUfkFsH3VghPDvCSS8zuZKRcUwZ3QKdziATqHN3Q8mLfsgvNMnyVhXla/mDUr8GmMJEV0rsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=txXA1mrA; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="txXA1mrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1784704834; bh=pHNyv6JsIjY9eaeoYslwhuyBTv3iH4SMHJeoYOKTwoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=txXA1mrA5aLeVDU4l5vz+ryvXqecWoLmWQVFM8S1jKLhpcwHDiPkPHY9trQlNt4zw
	 ohXZ67Sd3jkeIttzdfOs6ZHQCBP9ePGCZNuyYAjY5HUuFy+oIiZNVDdyihmX2do/EZ
	 BytJE9knKTVQdJ4n6VeQxGmbk/X0Hx91o5DQpCNStEPdnM+wqaocp9Tt0ElScDMToL
	 xNbuYK31Rj9ODNfIKYO90v6+tDIJBhEdT1rCRjgwY0s4MsrIzzVH+hfp7v0kWtqDSs
	 jAxS6INn5GNGCbjQ7Nu21c0U/98+rMTMwb53IZYU8IuUtHPw5ke0TRXRc3WrelGRL9
	 ob4YtG98KpbUQ==
Received: from pliszka.localnet (79.184.64.220.ipv4.supernova.orange.pl [79.184.64.220])
	by ms.puri.sm (Postfix) with ESMTPSA id C4D032109F;
	Wed, 22 Jul 2026 00:20:33 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vincent Cloutier <vincent@cloutier.co>
Subject:
 Re: [PATCH v2 0/4] power: supply: initialize MAX17055 from battery info
Date: Wed, 22 Jul 2026 09:20:31 +0200
Message-ID: <oKXqjsJUQIeHi1TxqbDgxQ@puri.sm>
In-Reply-To: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
References: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On poniedzia=C5=82ek, 20 lipca 2026 03:11:36 czas =C5=9Brodkowoeuropejski l=
etni Vincent=20
Cloutier wrote:
> - drop the Librem 5 battery description because its user-replaceable pack
>   cannot be identified reliably from the board revision

What makes you think so?

S.


