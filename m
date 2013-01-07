From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
Date: Mon, 7 Jan 2013 11:16:55 +0100
Message-ID: <20130107101655.GS3392@lunn.ch>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch>
 <50E6A378.90503@ti.com>
 <50E6F6AA.4000905@lunn.ch>
 <50EA9E10.7080605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:42181 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab3AGKRH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Jan 2013 05:17:07 -0500
Content-Disposition: inline
In-Reply-To: <50EA9E10.7080605@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux ARM <linux-arm-kernel@lists.infradead.org>, iwamatsu@nigauri.org, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, jgunthorpe@obsidianresearch.com, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>

> OK. Please put me on Cc so I will keep the review.
> 
> >We differentiate between the different SoCs by DT. Each has its own
> >.dtsi file and we will put the node into only those which have the
> >hardware.
> 
> Ok. That I understand, but my question was more into the difference
> between 88F6282 and 88F6283. Do you need to differentiate those two?

Hi Eduardo

No, there is no need to differentiate between these. As far as the
temperature sensor goes, they are identical. I've been testing on a
88F6282 and Nobuhiro Iwamatsu on a 88F6283.

	    Andrew
