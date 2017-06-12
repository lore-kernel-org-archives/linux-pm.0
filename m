From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpuidle: dt: Add missing 'of_node_put()'
Date: Mon, 12 Jun 2017 20:46:26 +0200
Message-ID: <17037298.Hu7HCo3Bt8@aspire.rjw.lan>
References: <20170612155441.GE2261@mai> <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50290 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752439AbdFLSxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 14:53:35 -0400
In-Reply-To: <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, open list <linux-kernel@vger.kernel.org>

On Monday, June 12, 2017 05:55:09 PM Daniel Lezcano wrote:
> From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> 
> 'of_node_put()' should be called on pointer returned by
> 'of_parse_phandle()' when done. In this function this is done in all path
> except this 'continue', so add it.
> 
> Fixes: 97735da074fd ("drivers: cpuidle: Add status property to ARM idle states")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I've already applied this one.

Thanks,
Rafael
