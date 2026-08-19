Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AA1A6820;
	Wed, 19 Aug 2026 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123629; cv=none; b=Sz+X2KJIvtZzOsHEglx6Y8W69IRZE+QHFxBOV/KOJ0ZzAxtDne6uPRm7QkUdww2M8W3fswT/8ycEAEry/cFhzNH9pNA/pcI2rXmgF7yDy9FHU4Ey9GNSfTLpcPNMFVj3gRWVW4HhQY/K53ntOS9cYiQ4IurCd2jQTXQPl4AdiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123629; c=relaxed/simple;
	bh=pzLbRNXkl+lQg5i+TSInb9jRZdea+IAUHe0jOORjpb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ4ULeh2pXV1HL9h2rINaQVJXmsWUj8Mc/zvLMjkmiYy4VZrYdttkCQS245Od/0DFP3eFZ6N5pq21MrLvBTTCsRv6GtjaXbb57l9PScQVRmxmLdqoJ4DkVQPIdizQsu7JA+xoOoP737GrEC7jpuyqgyvc7MyaDAoy4dAekmAPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llPmmxDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llPmmxDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7B1F00A3D;
	Wed, 19 Aug 2026 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123628;
	bh=O5Nz5q7xRkcWzabeKY3mkiPPpQooP/7oyuWXc8EAYgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=llPmmxDkHPvBD6pTgkb+yl0pCqEo4tzRzYQYJb9a3ATq0scMDo+pd76a+auaJxumf
	 oUput3ZIxQVTh39p6f9/dC9kxUpcV6fJHtDM4i3wJA43NSfU8OXBS9f3gdQHhBadmP
	 r2JgI21vwGHRF1ACfu4GRlyXW/IUaLChgg+KwUurannI2p2WrbUUn4Y4n0S3+Dn3gj
	 0dwAlsOu8/ywboL5sToExRFkchovAurpjV4Tj2cUvnVZtvwYc6lMYNONHx4ncZGhC5
	 bp9CD2xlN6rPMW57GFlrAJLY31jCaGZFij4Fu2dF7IH5Gr+PcLutt47fkrZS52HGEU
	 1drhardGuLUvA==
Date: Wed, 19 Aug 2026 09:13:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "user.email" <zstaseg@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to
 device-specific pmic-glink compatible
Message-ID: <20260819-saffron-porcupine-of-recreation-d5aeff@quoll>
References: <20260818151039.409767-1-zstaseg@gmail.com>
 <20260818151039.409767-4-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818151039.409767-4-zstaseg@gmail.com>

On Tue, Aug 18, 2026 at 05:10:39PM +0200, user.email wrote:
> From: Stanislav Zaikin <zstaseg@gmail.com>
> 
> Switch taoyao to its own compatible so qcom_battmgr can select the
> taoyao-specific property mapping added in the previous patch.

How is it going to be a "previous patch"? Previous patch is a different
DTS commit - look at the DTS branch of qcom soc or any other soc tree.

Best regards,
Krzysztof

