From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [gcv v3 15/35] drivers/cpuidle: Replace __get_cpu_var uses
Date: Wed, 28 Aug 2013 23:10:41 +0200
Message-ID: <3727720.FnSNTq1Q6N@vostro.rjw.lan>
References: <20130828193457.140443630@linux.com> <1883708.lq04OnoOJh@vostro.rjw.lan> <00000140c6b2ee60-b82c6fb6-8078-409c-a675-53124a3ac13b-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40157 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab3H1U74 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Aug 2013 16:59:56 -0400
In-Reply-To: <00000140c6b2ee60-b82c6fb6-8078-409c-a675-53124a3ac13b-000000@email.amazonses.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

On Wednesday, August 28, 2013 08:52:29 PM Christoph Lameter wrote:
> On Wed, 28 Aug 2013, Rafael J. Wysocki wrote:
> 
> > > Signed-off-by: Christoph Lameter <cl@linux.com>
> >
> > No objections from me.
> 
> Ack?

For the cpufreq changes alone if the overall idea is accepted. :-)

