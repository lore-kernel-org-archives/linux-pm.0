From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: running wpa_supplicant during saving hibernation image
Date: Fri, 07 Nov 2014 12:13:08 +0100
Message-ID: <87ioirmfgb.fsf@lant.ki.iif.hu>
References: <8761ex1via.fsf@lant.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from listserv2.niif.hu ([193.225.14.155]:58509 "EHLO
	listserv2.niif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaKGLNT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 06:13:19 -0500
Received: from business-188-142-225-206.business.broadband.hu ([188.142.225.206] helo=lant.ki.iif.hu)
	by listserv2.niif.hu with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <wferi@niif.hu>)
	id 1XmhTe-0000bO-OB
	for linux-pm@vger.kernel.org; Fri, 07 Nov 2014 12:13:14 +0100
Received: from wferi by lant.ki.iif.hu with local (Exim 4.80)
	(envelope-from <wferi@lant.ki.iif.hu>)
	id 1XmhTZ-0006tC-0O
	for linux-pm@vger.kernel.org; Fri, 07 Nov 2014 12:13:09 +0100
In-Reply-To: <8761ex1via.fsf@lant.ki.iif.hu> (Ferenc Wagner's message of "Sun,
	02 Nov 2014 16:18:21 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Ferenc Wagner <wferi@niif.hu> writes:

> I'm running an iSCSI rooted system over WPA authenticated wireless
> network.  I'd like to enable hibernation on it (restore from S3 seems
> unreliable on this Acer Aspire 2920 notebook).  The problem is that to
> have network access for saving the hibernation image, wpa_supplicant
> must be running, but as a user space process, it's frozen before
> creating the hibernation snapshot.  Is there a way to thaw it after
> taking the snapshot, or to skip freezing it?  I found no interface for
> setting the corresponding task flag, but I may have missed something.
> It's running from rootfs, so I guess either would be safe.  -- Well,
> currently it's logging into a tmpfs file, is that permissible (being
> swappable)?

I suppose the lack of replies means there's no such interface, so I'm
considering writing a module for setting the PF_NOFREEZE task flag of a
given process.  How can I soundly implement this?  Sched.h says "only
the _current_ task can read/write to tsk->flags", but that would be
inconvenient, requiring modification of wpa_supplicant as well.  Is
there a way around, besides ptrace?  Why isn't flipping a flag bit
atomic, anyway?  Or am I completely off the map with this whole idea?
-- 
Thanks,
Feri.
