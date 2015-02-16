From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND v3 1/3] mfd/axp20x: change battery cell name to
 fuel gauge
Date: Mon, 16 Feb 2015 13:54:21 +0000
Message-ID: <20150216135421.GJ14545@x1>
References: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
 <94002239142b80ddd090f39325c9adaa17c9da9f.1422909564.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47803 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbbBPNy2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 08:54:28 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so19638009wgg.11
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2015 05:54:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94002239142b80ddd090f39325c9adaa17c9da9f.1422909564.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, david.woodhouse@intel.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, todd.e.brandt@intel.com, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, dwmw2@infradead.org, jic23@kernel.org

On Mon, 02 Feb 2015, Todd Brandt wrote:

> Name changes to the battery cell structure to a
> more generic cell type: fuel gauge.
>=20
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Acked-By: Sebastian Reichel <sre@kernel.org>
> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/mfd/axp20x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

> v1: 01/07/14
> v2: 01/22/14
> - replaced the const in axp20x_acpi_match declaration
> v3: same as v2

=46YI: Changelogs are usually placed _above_ the diff stat.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
