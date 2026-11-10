Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330175;
	b=fmd9pd0v6cJEe+zLnAVdgYIXXoa7s7lV3T/P0iMiGoF41G1NlNj97rDzW5W21EMNEkFG
	 LQMUbfLO92E9T7A4PMEy7m9mqbSmW1yhrZ0s34KCmtXZX195HyrU0KJpc2BFaGq2Yo4IK
	 yTdVvrCVKsG7//t2Ok4ppsWBFQZItkdcrFDusi9sO92dGII0Oo57Tj4NZVzmUql6J76fW
	 8hKTkXpEWCSFOaVifbyzkKWgM/yB0VAayeI67opNzo7pJEg+nE6sITFHesUHF8ZLbfRsP
	 R3qk9T8oFhrfKF/UY5dnZR9oBKUic7lhFFDDVjN6xke5AbXMPYfZYTFX/x95QHOW5sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nl5ptLDjAXpP/V2ebmi2R/C5Fegagcu6ODQA3prZYlk=;
	b=Y42Si35p1QigIWAi0JnaAAUFZ2T0CepPgKAFSwRc0LSRCxJAQ1wyg68w+p93kAVBaSh0
	 +nZXQ58pr76IhIxQZppGoXjf5ezTQQHXi7k9/TzB3J7CFveV1/yHbpbWkEcibhAdVJohB
	 MD/sr07/JmMwpj6tnX1ZJM2naxRA1tNzbJJXJLceAAGoHdirGx1DRfr82MgM7aZ/D3mbl
	 1YZXAZgeu2rKUCtLCdwZAoW9Q8TNbhH5IHIldNINfdJfl0Il3cnp+N4IBo0bdSfHlaUrB
	 ql2BMrVGrA+ZxQMxvasKBMKUBAe8f5EYDSfcROPWDK7reaMG6MQquPoDmtPY61BG+IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbGFs4xt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51B606A325;
	Tue, 10 Nov 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbGFs4xt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F9F1F008A4;
	Tue, 10 Nov 2026 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330175;
	bh=Nl5ptLDjAXpP/V2ebmi2R/C5Fegagcu6ODQA3prZYlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbGFs4xtW3503yfKAVi/ThFZI3zz+nGmvb16IEIEgMnvDnnvPQUXfRJtHWJmBrMW1
	 STrtF4LACmNjRTzeJAs1tSJWaAfoNZc4lgYTm5O1BL5YC2MIXPhUBqVm9cO0Q2z9px
	 aw0LTZvnO97nSVl4OwrGBSRXXQtBPH9KWCSqLsTuiH/97oARxjegyVEdXKi870a0AU
	 MGmnpPur84wobWoeOzCsJRZDbOvk0h9/GDtXjGwa5xwCMpy/XivBkYzj0PZVuHFCtQ
	 jHd2F2wq/Im7QXKeLvEbzAF8PZ6zJNoKa+5NNIEwX+GgiG1FRWHbRejHQaU8II6XYI
	 tG7sDAF0oBzDQ==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pmdomain-fixes tree
Date: Tue, 10 Nov 2026 12:02:53 -0500
Message-ID: <20261110170253.2694265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avNHazNbGtMQJ5pV@sirena.org.uk>
References: <avNHazNbGtMQJ5pV@sirena.org.uk>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 04:33:47PM +0000, Mark Brown wrote:
>AFAICT this is caused by commit
>
>   d7262971a2acc (pmdomain: imx: gpc: remove all initialized power domains)
>
>though I don't really see how.  I have used the tree from next-20261109
>instead.

The while loop that commit adds to imx_gpc_remove() is never closed, so
the function is still open at the end of the file:

		while (num_domains--) {
			ret = pm_genpd_remove(&imx_gpc_domains[num_domains].base);
			if (ret) {
				...
				return;
			}

		if (num_domains == GPC_PGC_DOMAIN_PU)
			imx_pgc_put_clocks(&imx_gpc_domains[num_domains]);
	}

The patch was posted that way [1]. gpc.c is only built with
HAVE_IMX_GPC, which only SOC_IMX6 on 32-bit ARM selects, so x86 and
arm64 builds do not see it.

With the brace added, gpc.o builds with imx_v6_v7_defconfig:

--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -536,8 +536,9 @@
 				return;
 			}
 
-		if (num_domains == GPC_PGC_DOMAIN_PU)
-			imx_pgc_put_clocks(&imx_gpc_domains[num_domains]);
+			if (num_domains == GPC_PGC_DOMAIN_PU)
+				imx_pgc_put_clocks(&imx_gpc_domains[num_domains]);
+		}
 	}
 
 	of_node_put(pgc_node);

[1] https://lore.kernel.org/all/20260924142520.1594149-1-lgs201920130244@gmail.com/

-- 
Thanks,
Sasha
