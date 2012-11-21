From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PULL REQUEST for Rafael] PM / devfreq: pull request-2 bugfixes
Date: Wed, 21 Nov 2012 21:45:35 +0100
Message-ID: <56413964.NukgdroaIo@vostro.rjw.lan>
References: <1353494743-4581-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:58821 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964796Ab2KUUlJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Nov 2012 15:41:09 -0500
In-Reply-To: <1353494743-4581-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-pm@vger.kernel.org, sachin.kamat@linaro.org, myungjoo.ham@gmail.com, "Serge E. Hallyn" <serge@hallyn.com>

On Wednesday, November 21, 2012 07:45:43 PM MyungJoo Ham wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The following changes since commit aa0745b51987fbaf628ee0943907db177335522d:
> 
>   Merge branch 'pm-devfreq-next' into linux-next (2012-11-21 01:27:47 +0100)
> , which is HEAD of Rafael's linux-pm.git linux-next branch.
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20121121
> 
> MyungJoo Ham (2):
>       PM / devfreq: remove compiler error when a governor is module
>       PM / devfreq: missing rcu_read_lock() added for find_device_opp()

This one has a comment from Serge that looks like a valid point.  Care to address it
and resend or drop the commit in question?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
