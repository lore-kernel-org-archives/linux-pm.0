Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C293A5456
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779192; cv=none; b=PfnFBNpnfpXdyyKJ1juACVU4kM3UlfcKTM8/r74ryoBVUcl/5lxzTRS/7p5ijXJBAsz6CyhtO720Y/gFk6N/P6SmfxeesckU80nKS2LITNproFzOWEZ6syLbF03THQvQed8/UH8iK1Ncm86kh5B8H6gVGLxTBowDsOTpEUI7Obg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779192; c=relaxed/simple;
	bh=aiBAhlv2Ev/TS2fJoaSo8lPZ16KTHkhhUdlu5+WAv2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAhZ07HjmoO2/oC5+q3fHZd2j2irHuckia9NFgx6TVqsO60Cx70G9B6svyj7t2WhxVwEwOAS3zZmRf2qUkrNeBTR31fRFZYHdirn+LOiU8xpCQcnZo2BCZRTMy8wCWtgnKDOZNZhv2mbDMclBBesfJwpGXRBYlLVcQHLJmQixZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fwfP72/U; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwfP72/U"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3550c917fd3so2195266eec.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791779189; x=1792383989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7HtE6pXgrE7ezeCTTTPF8rtN8BUz+TwVSZ4PqyPsxjA=;
        b=fwfP72/USZqDt0/SJslKhbUX9vdNj2ckCWvHsMlLtG0IrYkVzRItznHLmmhNF9q7Zp
         f3yEUZl7xwaut6bI/yqwyMtLHNhqX87+ixG1akNsyESDRYuXrVdvNmiq+Lyw6385Frus
         lamLXcQZuV2aMJ1xl/0fmDDHiaqwlE6Fd0XTX2aWHFG3mhqJMp2EOo9+HZx5hZ8Tj2II
         Ked4bKgqeJm1f5aaINtJLbvGB6BJH9vl52HdtgAeCF4BScdeG8IjwN9qFEW4s9kMD+HO
         RiKWIxn/hZn3sIhWdBXLZ5CqNZC6WP+7Q8E+QbMOSPz1xKEIh1w6ppYGzlLmXDbTdIeM
         O9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791779189; x=1792383989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HtE6pXgrE7ezeCTTTPF8rtN8BUz+TwVSZ4PqyPsxjA=;
        b=2AywSdXywr2UsrrB6JkGd7RVIk5YUysp0Et+QlQAtCHqAc9OVj1wg3wv0Zza/TR2NU
         sVvhG3a8EM9IUh0UwIlOx+B27GnInpopynMb1oJmwSDnriMsHoFmgsLmBRt+cOV4EmR4
         iB8u58aunARREj6P/Z2rNXLLCbaHER9x1v3JG5hOU10BNUk2g4pB+l0JbZC7gH6yX6ta
         IMkZpjbkvcO9aWiUJEMNoIPy/seR0ytXoMz3OEqseD/emN7a6k4719quiy/xaO7NyyAm
         bY7glPgdYLk/uv1fR21wbwODTQUvC4xCsF0pzeLc5/2NSfWmy7kLJJLpnZEiZ/PRWLL2
         uqLA==
X-Forwarded-Encrypted: i=1; AKwUvBzP/PNZhONeNwUO993KzRbkrWqABxexzGU/GGnoTtkEAnFHSUlG3Kv2xi2V3hdgCu7aV+MGcfJuuw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKX8OIS62+/4rkQdFIZwnDwHjF1Aor2l4l0IqQv4D6vCo9HsmZS
	IH/tMgH475fLFRDWE5X8GR3qALd3V8eJ5+NnK3NIQxpDNgw5duA02qKw3snZ1EpGXGJi/5OSxgs
	4eALl
X-Gm-Gg: AYBFou2/4S/YJMa4gZXsa23X/W4OjNFakiGiGcHoDsQms9olhdLr7x/VZwuUvkbGHVO
	LZbdT5EMLRG20muv9l0KMDOLY6bCxXc1eN43gV+UHldv6acaYXjrtPhMeVCaLZobZ7mH5sNLP2s
	SHrcpGBEXG0PyqW9E8vdvCln777iHFEn6gTdXkm5IRv2knq429rTGG/0b105HwTwfM5j251t2F1
	53MbqhVp2Tp5IQFNYvFPYFhX+Cx9kuIEbqg0fKQEgahj+fJzgeCEiAtpSZKk1bAHeOPDEEblDMd
	eLdMyiWMK1SP8Slsr9wEtr01iyz3YtCk7FGVw11oHoEiIB358EHAnIWeem48/Jyq3R0WZcaWfN3
	xZ0MvF/78Sf6JjEfN7DANJda7tscb6xorxA8nlhYyFUGw3g6VFDn+Osym1MvJtPeEaRq8XEWSqA
	eEU1SfSFamOwRRsCVk0hS/J4peoXQai1HzcrgP2kc440PmgxoUCZKNbF7Qt9d+cuAp5QikUtkyV
	w==
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id 5a478bee46e88-3537e033341mr12296308eec.11.1791779189344;
        Sun, 11 Oct 2026 21:26:29 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm32289042eec.0.2026.10.11.21.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:26:28 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:56:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: xiong yining <xiongyining1480@phytium.com.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, chenbaozi@phytium.com.cn
Subject: Re: [PATCH] selftests: cpufreq: stop CPU hotplug loop after cpufreq
 update test
Message-ID: <asxhcagRL3myS3m_@vireshk-B250M-D3H>
References: <20261010100148.297720-1-xiongyining1480@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010100148.297720-1-xiongyining1480@phytium.com.cn>

On 10-10-26, 18:01, xiong yining wrote:
> Original test uses a fixed 5000 iteration loop to trigger CPU hotplug
> for verifying cpufreq synchronization between CPU hotplug and sysfs
> writes.
> 
> Two issues exist:
> 1. Background hotplug task keeps running after test completes, causing
> redundant CPU on/offline operations.
> 2. When cpufreq frequency setup is slow, the hotplug loop may exit
> before frequency updates finish, which breaks test purpose.
> 
> Introduce a file-based stop flag to control the infinite hotplug loop.
> After all cpufreq updates complete, create the stop flag file and
> wait for the hotplug task to exit.
> 
> This makes hotplug run only during cpufreq sysfs write test,
> align with test objective.
> 
> Signed-off-by: xiong yining <xiongyining1480@phytium.com.cn>
> ---
>  tools/testing/selftests/cpufreq/special-tests.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
