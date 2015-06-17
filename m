From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: 4.1-rc7: Xorg broken after resume on thinkpad T40p, radeon
 problem?
Date: Wed, 17 Jun 2015 16:22:58 +0200
Message-ID: <1434550978.2400.13.camel@x220>
References: <20150617124347.GA22879@amd> <20150617124949.GA22953@amd>
	 <5581711D.6030707@amd.com> <20150617132121.GA24634@amd>
	 <1434549017.2400.3.camel@x220> <20150617141052.GA30910@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150617141052.GA30910@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, rjw@rjwysocki.net, lenb@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-06-17 at 16:10 +0200, Pavel Machek wrote: 
> > The above looks very much like the issue that made me write commit
> > 45171002b01b ("radeon: add AGPMode 1 quirk for RV250"). See
> > https://bugzilla.redhat.com/show_bug.cgi?id=531825 for a lot of
> > background.
> > 
> > Does booting with radeon.agpmode=1 survive a suspend and resume cycle?
> 
> Yes, that option helps. Thanks!

Then I suggest you add another quirk for your T40p (after testing
agpmode 2 also). Because this all seems to be caused by a broken BIOS,
and/or broken AGP thingy, and/or broken RV250 (or the interaction of
these things or whatever). Maddening stuff, impossible to debug.

Good luck,


Paul Bolle

