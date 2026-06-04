Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEB3ACA6E;
	Thu,  4 Jun 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589157; cv=none; b=J0EvfyhXT3O1rxiII1DNDmSgzUpPZIfxPWy7vEh+9e3OKhzPOKKFWwDKYfqq+YQ7WyDC7nvABhq3G+UKxTK0cyIff6KkgfWMRKFlAnyseKhakEnRdZbByzEC5jnCNVHAe9UQwPrN5OMj9mHJo2yYyUWVOa6pKY2RAo5zKsyTCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589157; c=relaxed/simple;
	bh=GwkbEHH7aEYOncu2D6n2F9/P5LqzvyyDOt+VBohz2ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YdiqhDt/Sc1Y/qRiSbpYDqXaRrVADTWAV1+iiTKUVFTqNtbs96nupD+Gw3vU6a3zRSLV8Z5TdkCirf7dhdFSEMVTRudOo86aa4GHRvxxZ78S8GhsGeS2COuG7vo1q37YuYLwSzJChG3VnDRQ72rE/e0VNn/hBzFjvN4E+DtZNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6023B1F00898;
	Thu,  4 Jun 2026 16:05:56 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2642F181D82; Thu, 04 Jun 2026 18:05:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20260507134608.76222-1-clamor95@gmail.com>
References: <20260507134608.76222-1-clamor95@gmail.com>
Subject: Re: [PATCH v4 0/2] power: supply: Add support for Surface RT
 battery and charger
Message-Id: <178058915412.2707129.13808686364711300875.b4-ty@collabora.com>
Date: Thu, 04 Jun 2026 18:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 07 May 2026 16:46:05 +0300, Svyatoslav Ryhel wrote:
> Add support for Embedded Controller found in the Microsoft Surface RT and
> used to monitor battery cell and charger input status and properties.
> Controller works both for UEFI and APX booting.
> 

Applied, thanks!

[1/2] dt-bindings: embedded-controller: Document Surface RT EC
      commit: de296b53775cd1ccb6b448b4cc8d843c8858e1df
[2/2] power: supply: Add support for Surface RT battery and charger
      commit: 3d6529b837de49294cea0d4600144353f5f084dd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

