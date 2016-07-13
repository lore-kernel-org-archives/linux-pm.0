From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Kernel stability on baytrail machines
Date: Wed, 13 Jul 2016 12:48:03 +0200
Message-ID: <20160713104802.GA18296@atrey.karlin.mff.cuni.cz>
References: <606d9b223f3c12775d108b98c4df72ae@feix.cz>
 <20160409160119.GA19362@xo-6d-61-c0.localdomain>
 <20160409201417.4436d4bd@lxorguk.ukuu.org.uk>
 <20160712194158.GA4834@laptop>
 <20160712212448.GA19237@amd>
 <864e7ac7-8041-9a81-819c-d6b60b59dd0f@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36938 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcGMKsT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 06:48:19 -0400
Content-Disposition: inline
In-Reply-To: <864e7ac7-8041-9a81-819c-d6b60b59dd0f@feix.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Feix <michal@feix.cz>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

> On Tue 2016-07-12 16:41:58, Ezequiel Garcia wrote:
> >>Hi Alan,
> >>
> >>(Adding interested people to this thread)
> >>
> >>On 09 Apr 08:14 PM, One Thousand Gnomes wrote:
> >>>>>I do feel that the importance of the mentioned bug is currently
> >>>>>underestimated. Can anyone here give a note, how much current linux
> >>>>>kernel is supposed to be stable on general baytrail machines?
> >>>>If you did not get any replies... you might want to check MAINTAINERS file, and
> >>>>put Intel x86 maintainers on Cc list.
> >>>>
> >>>>I'm sure someone cares :-).
> >>>Yes we care, and there are people looking at the various reports.
> >>>
> >>Are there any updates on the status of this issue?
> >>
> >>The current bugzilla report [1] marks this as a power management
> >>issue. However, many reports indicate that it would only freeze
> >>when running X, so it's not completely clear if it's related to
> >>the gfx driver too.
> >Does
> >
> >"intel_idle.max_cstate=1"
> >
> >fix it for you?
> Yes, it does.
> >If you feel it is X-only problem, you may want to provide details
> >about your graphics subsystem (DRM enabled? framebuffer only?) and
> >probably cc.
> It's not X-only problem. Happens even in console mode, which is KMS
> switched during boot though.
> >...actually... you may want to verify if it happens in unaccelerated X.
> As it happens even in console mode, is this relevant test?

No, no need to test with X.

Would it be possible to test in good old VGA mode?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
