Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9235C68A;
	Sat,  3 Oct 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038252; cv=none; b=mqBCMc+oC1eCAH36Tu8xi1aQrGs2HifiIX2BV3CiQQvIQDJhGBcZ5yCFCYYj5F06wOqKw/Yw0yTi1+Vz2jlvpbIQwLVkIGTaHrTPNLHo40SSvfdMgS7Inm47YPqRtmQV4nzdt8r+jbXviwX0NhefYOEBM98jzAhgL4kdE9N2wM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038252; c=relaxed/simple;
	bh=Un8/juDdjwn7G7DjI0deCBAAW0YpUVKLvLlVd7yrup8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NApDtNrAkRPmlN5/jxAdaYAYe4ZUX3KLrCcu07i/AtWHGwCnaheNPX8i3Oz64j5+L1kv2zkDEQ7+ZLMfdj5ncAUYxMBoRYsexX4ea/bbi30u7FMqyTvtvOVy5+5pWQ8EQvWpxmo6fyO7RRbJfebNRigmHneiSQoHOK7cFCFgZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiyAvf06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiyAvf06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168C11F0089B;
	Sat,  3 Oct 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791038250;
	bh=im7RalomTYcHExz9sX/F/AbBvKSoYAIBxb4JScV95Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XiyAvf06c1/D8xwfm7Cb5Lvl77GQT3tKwzaW6a+Q7bBhWI8uiFmt6Ww0K9ZB1pTf+
	 I9cbQMD+3sMQ0KUT0EQEy7/JsgSwxZG//UaPdHc6QufCF6mK8FfXSLuHIoMliclYN6
	 Xjug9m8yTE3pmFIfILauAj2y+NcOiSlB/RI4amy1QJqwx2z85TsNQ6g88RgVpbM3m4
	 Q8eNeGx3ZGLckLryOXolXv2Rfi/vy5uI7EE512XuKJRfggTkxNlDHzdwV0cJ0ObGfT
	 TPDSUc+TYxv1gZNbA90HKEuKIg/4ci9idugNwqibYD5aMNUh8LC6KEHhXGNjW/ZtUh
	 2fi3uXTQeTXlQ==
Date: Sat, 3 Oct 2026 16:37:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: bq27xxx: add BQ28Z620
Message-ID: <20261003-adventurous-attractive-bird-fea9ef@quoll>
References: <20261002-bq28z620-v1-0-bdcc10d42519@flipper.net>
 <20261002-bq28z620-v1-1-bdcc10d42519@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-bq28z620-v1-1-bdcc10d42519@flipper.net>

On Fri, Oct 02, 2026 at 04:02:54PM +0400, Alexey Charkov wrote:
> Add a compatible for the TI BQ28Z620, a firmware derivative of the
> BQ28Z610 that keeps its standard command set but drops the Battery Trip
> Point feature and relocates much of the data flash as a result.
> 
> Keep it standalone rather than falling back to ti,bq28z610, as software
> programming the BQ28Z610 data flash layout would corrupt the
> configuration of a BQ28Z620.
> 
> Link: https://www.ti.com/product/BQ28Z620
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

