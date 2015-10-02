From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL: Linux-PM] devfreq fixes for 4.3-rc4
Date: Fri, 02 Oct 2015 15:54:45 +0200
Message-ID: <2321637.rEGvrQpaR1@vostro.rjw.lan>
References: <26450868.488131443752283554.JavaMail.weblogic@epmlwas01a>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47712 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752835AbbJBN0V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 09:26:21 -0400
In-Reply-To: <26450868.488131443752283554.JavaMail.weblogic@epmlwas01a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, myungjoo.ham@gmail.com, geliangtang@163.com, tjakobi@math.uni-bielefeld.de

On Friday, October 02, 2015 02:18:04 AM MyungJoo Ham wrote:
> Dear Rafael,
> 
> Here goes a pull-request for two bugfixes of devfreq.
> 
> 
> Cheers,
> MyungJoo
> 
> The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:
> 
>   Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_4.3_rc4
> 
> for you to fetch changes up to 6d3cbfa718eeedd70efb9eb04ce9b261b6fa5b7b:
> 
>   PM / devfreq: fix double kfree (2015-10-02 11:05:58 +0900)
> 
> ----------------------------------------------------------------
> Pull request for Rafael from devfreq targetting next RC (4.3-rcX)
> 
> There are two bugfixes included.
> 
> ----------------------------------------------------------------
> Geliang Tang (1):
>       PM / devfreq: fix double kfree
> 
> Tobias Jakobi (1):
>       PM / devfreq: Fix governor_store()
> 
>  drivers/devfreq/devfreq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Pulled, thanks!

I've queued them up for 4.3-rc5.

Thanks,
Rafael

