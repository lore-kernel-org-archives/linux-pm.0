From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH v2] thermal: add Intel BXT WhiskeyCove PMIC thermal driver
Date: Wed, 29 Jun 2016 10:29:12 +0530
Message-ID: <CAKDJKT7_nPtPz6zH2WdmasqLfbNMWGeMdFBkrW8u8_zrAcz9+g@mail.gmail.com>
References: <20160629042846.GA137699@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160629042846.GA137699@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi


> +static int pmic_thermal_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}
> +

Why this remove function still requires?

Regards
Manish Badarkhe
