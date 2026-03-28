Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B4946C
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774710941; cv=none; b=t7ueHAAETfnNaqgKwFc/xjfStcpMfw+MFXYb4pKThLeM7rkKOhniTllauyyFQI8CEYHUCbAvX6OhWuEl/g7pBJWZNpi10gQpLsfbvOIXjsNTfx6aPT1PWaeg1y773BM45K4IImFY2p/8tK3eKd673Ooif8HcFJIxSf7+pQoGuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774710941; c=relaxed/simple;
	bh=ICqzzqLxaQ0oD8cZsvkZ1Auyp2BNEN+4P7TyZ9353cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwQE7+h//oeRFD9aImSLuEOFJDR7bC2fP81taNhUXbM3mbm1/UqsgTbOKQBCw+pP1VCGLTw1FiL6kN+hkVGyYLZHMhQQlnYqXusNSaVVBy4hScAIhOYjGihGih9ffl/cQoQkTtdbDF48lP9lOPHL8lOeZ5ziZD02GY03ppFbsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA+R35wl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA+R35wl"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c9f6b78ca4so419426585a.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774710939; x=1775315739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kDUry0xFE9vHvVj18ny7RFWBuEEHB+W5Lxw16DJs+g=;
        b=dA+R35wlUXZthVYGFUmdvTh3S5roPveh3Y/N6QKO297DQmVZkjvhRagCSqIcVWYsfA
         Jf2DdqM0E9BzSrjkYKH/SiUvBSVtlCIyzbs2YsmjOJcby4VyB3/YLft/0BVno25gdlg+
         HuDDa/S4epzZ9or/feRGuInInpPyldD7dUI9yEpDk94OEoE4g1AWrJIjWSMq86K3ZHco
         CFM2AHFPLB/3OInhMbyxiXzyVyUWocSA5Lk853bSg9YgKzKj/9IJhRg4kCT6Iufua3Vd
         A+SLJM3IO/8VBNdN19oB4ybvAIpCymqHbuQ8z04WUjxOm+UI7Z7DPOmeCFOMLPVid0bJ
         Pzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774710939; x=1775315739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kDUry0xFE9vHvVj18ny7RFWBuEEHB+W5Lxw16DJs+g=;
        b=G9DvZ1yf4HUabUmZoK6F8W1WhrMB0jHY12lPCkNFWdje6ZVQDdll0sdbJOJ0r767FT
         2c5F8THn42sJESd0yNRL1bRVRn5JGj04GBGKJBxTjC+5i1ua/wj/hRli8yL0oDaJxKFy
         EMI7nzgEsADdxXHiHyn9leQW90nS8E4wyxw2l60XV3K0Oka4jH962YsM7zMmGgb9HvxV
         8L0YuehHejlOAAkdTBSi9VnToKMM8gvzCPnLaqotN2X1v1FMHwCEiTXPmXteV9uiFQEy
         pVnIdFW4WL5nH4Lr4pS16fm1+jjaNrQtZU49wlhj6x+FS/ytBdrRPQRL7FOyqKC1pz98
         /2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXetiAAUdscK/pi6w7ztoAXVZskmo8+b3iOTCme7+KJj7Dss4+vcd8ZX65T8qSoIQkCTo4iiIXirw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRbpZ3gnKQGgldNU+io7zirsoFHrsCSgsT4xaQ9vQnKcnZuZL
	YEWAMfNDDt9fULcjy5bblLC7dOgMdUGxpuaIb/TR2Jio00P/y4zzx+nr
X-Gm-Gg: ATEYQzxpH6xuV4YTgv04K5UGuOcHrMWsZq+Nnrl5hZdZncLa2jDYfMceOMPtK/W9Uma
	Ts9GMsT9cs04yIWc1PnLijt/cWEfS0pjiCR2aQi2SsMXuThM9cbxDzah4JCc3BBJVdaHo6vdqzs
	NC/FGSj+ylmKqXUCKmIyddFcfpwROtUtHHxIHYtS+8WsQ/+w6f4d2qydCCkC8abeakEKVqSHYRl
	7qHTcWWbpuNEl6tZf79AGKJQfIj7KTcDKkMIs4Ilbxqrcs7hh3Igw7lrwfJ/Rbo3DPEsrvzbGhB
	qFNonYET3ilClFnqZuoTtqddRSVMd285o0l29V27d2tYZE/Tu4L8jAXcuRtdxkgmoTVDTTQqieZ
	X56jazUH7oWmGN/++Kwi+PR3YGyMmazDaZoymtW/3IZOG9L+rqgdDjqwZ/qIa8pnfTtCM/dfy3A
	3XiJ4NR66xC+GrZ97ud2Rxp/6jcA==
X-Received: by 2002:a05:620a:4446:b0:8cf:e0fe:f217 with SMTP id af79cd13be357-8d01c60d34cmr849118585a.20.1774710938926;
        Sat, 28 Mar 2026 08:15:38 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02808677dsm181603085a.42.2026.03.28.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:15:38 -0700 (PDT)
Date: Sat, 28 Mar 2026 11:16:14 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: thermal: lmh: Add SDM670 compatible
Message-ID: <acfwvk8ptnBrGmVx@rdacayan>
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-3-mailingradian@gmail.com>
 <20260328-resilient-smilodon-of-improvement-a8619f@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328-resilient-smilodon-of-improvement-a8619f@quoll>

On Sat, Mar 28, 2026 at 01:20:43PM +0100, Krzysztof Kozlowski wrote:
> On Fri, Mar 27, 2026 at 09:40:39PM -0400, Richard Acayan wrote:
> > Document the SDM670 LMh.
> > 
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> 
> Why are you sending patches already applied 18 days ago?

This one in particular was applied with the assumption that there were
no driver changes to support SDM670, so I re-sent it in case the
different CPU clusters change the suitability of the fallback
compatible.

I'll drop them next time, and patch over this if necessary.
