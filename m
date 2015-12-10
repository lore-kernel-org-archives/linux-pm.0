From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Thu, 10 Dec 2015 01:58:26 +0100
Message-ID: <1472993.ZDhaIi32oY@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <1449678139-17782-1-git-send-email-joonas.lahtinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63062 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751054AbbLJA21 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 19:28:27 -0500
In-Reply-To: <1449678139-17782-1-git-send-email-joonas.lahtinen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, Chris Wilson <chris@chris-wilson.co.uk>, linux-pm@vger.kernel.org

On Wednesday, December 09, 2015 06:22:19 PM Joonas Lahtinen wrote:
> Introduce pm_runtime_get_noidle to for situations where it is not
> desireable to touch an idling device. One use scenario is periodic
> hangchecks performed by the drm/i915 driver which can be omitted
> on a device in a runtime idle state.
> 
> v2:
> - Fix inconsistent return value when !CONFIG_PM.
> - Update documentation for bool return value
> 
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org

Well, I don't quite see how this can be used in a non-racy way
without doing an additional pm_runtime_resume() or something like
that in the same code path.

Thanks,
Rafael

