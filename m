From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: samsung: Remove Exynos5440 clock handling
 left-overs
Date: Tue, 24 Jul 2018 17:46:59 +0200
Message-ID: <3064664.tE3uuFXtKN@amdc3058>
References: <CGME20180717154647epcas2p4285b46d932fbfd04eab2bdf05de8a5b1@epcas2p4.samsung.com>
        <20180717154617.29913-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180717154617.29913-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 17, 2018 05:46:17 PM Krzysztof Kozlowski wrote:
> Commit 8014220d48e7 ("thermal: samsung: Remove support for Exynos5440")
> removed the Exynos5440 specific part of code for accessing TMU interrupt
> registers but the surrounding clock handling was left.
> 
> Clean it up.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
