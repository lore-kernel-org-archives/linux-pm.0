Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697883859D5;
	Tue, 10 Mar 2026 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178182; cv=none; b=YBHpvbR2BAM3DseW/UkybS/xp+rQXyyafWDq4OcIAdBmnAEs88DEsFId8oBRWcb7pD2dHa5ZiH7ikMnZVhDOPKX3uQEepNq9l7/wtBhadHg+LQnQm3JGN+lZUzIRj0P4JWX9wjDOga3cIAujd9y/mHkxS/PDK5Q/P2qF9GdIL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178182; c=relaxed/simple;
	bh=z32ZwuOBw0mqxqtSzu1Uf4+spzxppKPjGQKuyMvnXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJtuoT5iGkbDCzagD0UZbX8F83FlzBYnszXXa/JJkzLXgNzfhT1trUTltQ7T6WHBgHIsohzRFSgD4XIw/Y3SgK2Mx7Cj4D9FKKVnDAIGx6y64p55oz2iJ7OUhjQunef4YYApSESkPZZG3aukpPh4AofsrBhXXhiRIxNIInuCljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKzxhls5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKzxhls5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB95C19423;
	Tue, 10 Mar 2026 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773178182;
	bh=z32ZwuOBw0mqxqtSzu1Uf4+spzxppKPjGQKuyMvnXjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKzxhls5NMCS1yYzWwbCFynSWy0xy8EHBV1fC/1cfmsysmyZbugX259ix5GRkL1et
	 XdV4VDJeAjIwsRn2ZTvvxASIXTNd5lfo04X22aHkz03J6+S1+455rcoyUMXABpEJNq
	 neJ/Q3fnH1xhlEB6GxvdnCKGRD73SniCJyM5X/SaQujL+bcohBib09CVVYatCxsfTr
	 ArGwe9NRbTJ1VMEIi5FCTJT9qkw/vBzPVP1JAO0L26P5Q080kS8Y9tzoFqep0OaU1r
	 GXtfVNIYZXetgrvMN2AFXvIoPI6KCv/mi14EQWSrGDoeQdohHMjHKK3DHMAbIWQ9a+
	 sRNQes8UIbl5g==
Date: Tue, 10 Mar 2026 14:29:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
	linhongye@h-partners.com, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, wangzhi12@huawei.com
Subject: Re: [PATCH v2] ACPI: CPPC: Move reference performance to capabilities
Message-ID: <20260310212936.GA2143491@ax162>
References: <20260213100935.19111-1-zhangpengjie2@huawei.com>
 <20260310003026.GA2639793@ax162>
 <70469192-ab9e-406a-999d-a72d0f2ce0fe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70469192-ab9e-406a-999d-a72d0f2ce0fe@huawei.com>

On Tue, Mar 10, 2026 at 01:05:04PM +0800, zhangpengjie (A) wrote:
> Thanks for testing and reporting this! The error code -14 (-EFAULT)
> you are seeing is exactly due to a logical flaw introduced in that commit
>  when handling the local `ref` variable. On platforms that do not support
>  the reference performance register, the code falls into the `else` branch
> and correctly assigns `perf_caps->reference_perf = nom;`.
> However, it forgets to update the local `ref` variable. Because `ref`
> remains
> uninitialized (or 0), the subsequent sanity check
>  `if (!high || !low || !nom || !ref || !min_nonlinear)`  fails and
> mistakenly returns

Thanks for confirming!

>  `-EFAULT` (-14).  Could you please apply the following diff and see if it
> resolves
>  the amd_pstate initialization failure on your test machine?
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 07bbf5b366a4..ac90c0c55c14 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1411,7 +1411,8 @@ int cppc_get_perf_caps(int cpunum, struct
> cppc_perf_caps *perf_caps)
>                 cpc_read(cpunum, reference_reg, &ref);
>                 perf_caps->reference_perf = ref;
>         } else {
> -               perf_caps->reference_perf = nom;
> +               ref = nom;
> +               perf_caps->reference_perf = ref;
>         }
> 
>         if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||

Yeah, I tested the following slightly different but functionally
equivalent diff and it appears to cure my problems. Thanks for the quick
reply. If it would be helpful for a follow up submission:

Tested-by: Nathan Chancellor <nathan@kernel.org>

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 07bbf5b366a4..5ad922eb937a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1407,12 +1407,11 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	 * If reference perf register is not supported then we should
 	 * use the nominal perf value
 	 */
-	if (CPC_SUPPORTED(reference_reg)) {
+	if (CPC_SUPPORTED(reference_reg))
 		cpc_read(cpunum, reference_reg, &ref);
-		perf_caps->reference_perf = ref;
-	} else {
-		perf_caps->reference_perf = nom;
-	}
+	else
+		ref = nom;
+	perf_caps->reference_perf = ref;
 
 	if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
 	    IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
