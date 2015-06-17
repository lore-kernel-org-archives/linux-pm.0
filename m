From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.1-rc7: Xorg broken after resume on thinkpad T40p, radeon
 problem?
Date: Wed, 17 Jun 2015 16:10:52 +0200
Message-ID: <20150617141052.GA30910@amd>
References: <20150617124347.GA22879@amd>
 <20150617124949.GA22953@amd>
 <5581711D.6030707@amd.com>
 <20150617132121.GA24634@amd>
 <1434549017.2400.3.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434549017.2400.3.camel@x220>
Sender: linux-acpi-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, rjw@rjwysocki.net, lenb@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Unfortunately, not as far as I know.
> > 
> > > If yes it might be a good idea to bisect to narrow down the problem.
> > 
> > No such luck. I may try something like "3.0" if we are really
> > desperate (2.6.X kernels probably won't won't boot with recent
> > userland), but I suspect it just never worked.
> 
> The above looks very much like the issue that made me write commit
> 45171002b01b ("radeon: add AGPMode 1 quirk for RV250"). See
> https://bugzilla.redhat.com/show_bug.cgi?id=531825 for a lot of
> background.
> 
> Does booting with radeon.agpmode=1 survive a suspend and resume cycle?

Yes, that option helps. Thanks!

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
