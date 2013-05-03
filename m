From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/10] optimize freezing tasks by reducing task wakeups
Date: Thu, 2 May 2013 17:10:26 -0700
Message-ID: <20130503001026.GZ19814@mtj.dyndns.org>
References: <1367458508-9133-1-git-send-email-ccross@android.com>
 <1678114.cijx7evM08@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:56110 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404Ab3ECAKb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2013 20:10:31 -0400
Content-Disposition: inline
In-Reply-To: <1678114.cijx7evM08@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Colin Cross <ccross@android.com>, Oleg Nesterov <oleg@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arve@android.com

Hey, Rafael.

On Thu, May 02, 2013 at 11:06:35PM +0200, Rafael J. Wysocki wrote:
> > v2 moves the skip check to freeze_task(), and expands the commit
> > messages.
> 
> The entire series makes sense to me, so are there any objections?
> 
> Tejun, Oleg??

Generally looks good to me.  I'm a bit uncomfortable with the
generic-looking expansion of the freezable API as it can't be
something which can be used in any generic manner.  It'd be great if
we just add only the used ones (do we already?) and add some sort of
lockdep annotation so that people don't use them while holding any
locks.

Thanks.

-- 
tejun
