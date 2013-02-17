From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bisected] 3.7-rc1 can't resume
Date: Sun, 17 Feb 2013 21:40:42 +0100
Message-ID: <3513716.1dZa4Epkei@vostro.rjw.lan>
References: <20130217174824.GA649@onny>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39133 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891Ab3BQUeL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 17 Feb 2013 15:34:11 -0500
In-Reply-To: <20130217174824.GA649@onny>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonas Heinrich <onny@project-insanity.org>
Cc: hpa@zytor.com, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sunday, February 17, 2013 05:48:25 PM Jonas Heinrich wrote:
> Hello,
> since kernel version 3.7-rc1 I can't resume my notebook (Thinkpad T43)
> from suspend2ram anymore.
> 
> I started a kernel bisection (see bisection_log in attachement). Also
> see kernel conifg @ attachement.
> 
> The culprit commit seems to be: 
> - x86, smap: Do not abuse the [f][x]rstor_checking() functions for user space
> commit e139e95590dfebab81841bf7a3ac46500f51a47c

Does the commit immediately preceding this one behave correctly?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
