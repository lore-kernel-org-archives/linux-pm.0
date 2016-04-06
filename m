From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] extcon: usb-gpio: switch to use pm wakeirq apis
Date: Wed, 6 Apr 2016 15:41:41 -0700
Message-ID: <20160406224141.GI16484@atomide.com>
References: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49994 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbcDFWlp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Apr 2016 18:41:45 -0400
Content-Disposition: inline
In-Reply-To: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, nsekhar@ti.com, nm@ti.com, rogerq@ti.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160406 10:33]:
> Switch to use PM wakeirq APIs which automates wakeup IRQs
> enabling/disabling and so allows to make code simpler.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
