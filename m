From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Orion
 SoC
Date: Fri, 4 Jan 2013 11:47:53 +0200
Message-ID: <50E6A549.5050407@ti.com>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch> <1355482986-885-2-git-send-email-andrew@lunn.ch> <50E6A378.90503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55767 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab3ADJs0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 04:48:26 -0500
In-Reply-To: <50E6A378.90503@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, iwamatsu@nigauri.org, linux-pm@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, jgunthorpe@obsidianresearch.com, linux ARM <linux-arm-kernel@lists.infradead.org>


Hello again,

On 04-01-2013 11:40, Eduardo Valentin wrote:
> Hey Andrew,
>
> On 14-12-2012 13:03, Andrew Lunn wrote:
>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

<cut>

>
> I believe you forgot to request this memory. I suggest you do:
> +    thermal_dev->base_addr = devm_request_and_ioremap(&pdev->dev,
> res->start,
> +                          res);
>

small fix:

+    thermal_dev->base_addr = devm_request_and_ioremap(&pdev->dev,
+                                                      res);

