Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366635;
	b=lW2IdU96eF4/aCmfMGA2QC0NiE+9NinNQi5B5olJoh4d5zt9r9hIpO2Q7lfLvXZ4igN/
	 t3MWFpu0xG7P7iHrPB9jm2Jejy1GBnvw6PUtLxSrz41qdRcFdKGRgcohzCNw8BA5iT3sL
	 5RGsGMGcyUmfrIfgOA+WJ9lA3YThrVNHcyaJgcnExCNgq7sbrZLEHpIHNDKN+nls6edrv
	 Odsg93EjWEoSNHUW0RAZJv453KhiPw3bwkexZ3IohbDViHJdji5XIcynGxcFcteL8zTLL
	 QSMZn3u7wdQ8skAGQVHOgKP9EvC4h/fkLqj38IS126u3KOg94fcvOvcrHrN7wmd5TcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2Yw74l8uzk8/LW206uKJMYpkivuj4oIRzbpObpcHoLo=;
	b=Xule2b57fI8TfTHNBSwSPVW+LsWzDPAzGL9upFImyWDfjZ4aum98whyurhFiaCI+mim/
	 HI7V/QVP5zsPJx/lQEDPo2zhA3ZHCe1Gz+yc/smBJR5IICzjf+iVtP0meAOxT7TDDlKsj
	 i1pVi8iYSOvYrizdQf4xMGcuXvNGRuQC0c91VKIcGpkuJq/jzHSrOn+2sLil7NU1Gd0t0
	 UD/vPNqkXdUWXy+dukvUEOneOSw81cb9jM1kNrksJ3prYssHj3VmTT/Ozow2bXCszeONG
	 wxggNftum7HMMht4NlULG8bCHMsrh0420obWeYL2szrMQUWpWJ8T/TR//JLP6mDB38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF2YUJbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFF606A320;
	Sun, 22 Nov 2026 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF2YUJbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCD01F000C6;
	Sun, 22 Nov 2026 16:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366634;
	bh=2Yw74l8uzk8/LW206uKJMYpkivuj4oIRzbpObpcHoLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aF2YUJbppibS6GSpXrZYFlzyZc3k5urN25NEqoD2FPN02oVamYM9O2DyDzBDVEuCb
	 IU0Qrx0C3cc3Ib+FCM9IIy9r6xRQikOkl1899Qz9ZlJpBdrndioo3xSxrf7COe+2I4
	 qHQ0goT/cCIq8/vgiCjsBuO2Nq6++ivH7HqPj/ldNajFCCJ9+FE2HCLupVE1CPX+Sb
	 CWSUy04oaPSJnGPo4P3uC106jSMP9MWCT1JVEf+LXrXS5oi7MgwrifBgR9Dzh610Zk
	 yRVkuZ5OVcg9IjZb/yTgEG771NV6jOyEimMeFwTXDLtvqugVr3mVZxjHP0rdAKpVu8
	 gzxkgzMI7kYxg==
Date: Sun, 22 Nov 2026 17:57:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, zhongqiu.han@oss.qualcomm.com, conor+dt@kernel.org, 
	treding@nvidia.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	bbasu@nvidia.com
Subject: Re: [PATCH v3 6/9] dt-bindings: arm: nvidia: Document the Tegra264
 CCPLEX cluster
Message-ID: <20261122-caribou-of-pleasurable-competence-e8fe0d@quoll>
References: <20261119111217.902071-1-sumitg@nvidia.com>
 <20261119111217.902071-7-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119111217.902071-7-sumitg@nvidia.com>

On Thu, Nov 19, 2026 at 04:42:14PM +0530, Sumit Gupta wrote:
>  examples:
>    - |
>      ccplex@e000000 {
> @@ -49,3 +66,11 @@ examples:
>        reg = <0x0e000000 0x5ffff>;
>        nvidia,bpmp = <&bpmp>;
>      };
> +
> +  - |
> +    ccplex@30000000 {
> +      compatible = "nvidia,tegra264-ccplex-cluster";
> +      reg = <0x30000000 0xcf0000>;

Drop example, no need for difference in one new property.

Best regards,
Krzysztof

