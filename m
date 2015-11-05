From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add devfreq-event entry
Date: Wed, 04 Nov 2015 19:17:14 -0800
Message-ID: <1446693434.21133.79.camel@perches.com>
References: <1446692407-18247-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:45932 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1031616AbbKEDRS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 22:17:18 -0500
In-Reply-To: <1446692407-18247-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, 2015-11-05 at 12:00 +0900, Chanwoo Choi wrote:
> This patch adds the devfreq-event[1] entry to review the patches
> as just supporter. Patches will be picked up by Myungjoo Ham on
> devfreq git repository.
> [1] https://lkml.org/lkml/2015/1/25/573
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3340,6 +3340,15 @@ L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/devfreq/
>  
> +DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
> +M:	Chanwoo Choi <cw00.choi@samsung.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Supported
> +F:	drivers/devfreq/event
> +F:	drivers/devfreq/devfreq-event.c
> +F:	include/linux/devfreq-event.h
> +F:	Documentation/devicetree/bindings/devfreq/event
> +
>  DEVICE NUMBER REGISTRY
>  M:	Torben Mathiasen <device@lanana.org>
>  W:	http://lanana.org/docs/device-list/index.html

It'd be nice to update the DEVFREQ MAINTAINERS entry (and maybe
this one as well) so it has the appropriate git repository listed.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index caddb49..ca0ae09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3349,6 +3349,7 @@ DEVICE FREQUENCY (DEVFREQ)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-pm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Maintained
 F:	drivers/devfreq/
 

