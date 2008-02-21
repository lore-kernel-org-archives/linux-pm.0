From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] power_state: get rid of write-only variable in SATA
Date: Fri, 22 Feb 2008 00:42:20 +0100
Message-ID: <20080221234220.GC25977@elf.ucw.cz>
References: <20080221125652.GA23548@elf.ucw.cz> <47BDA22F.5060300@pobox.com> <20080221193350.DA772235007@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080221193350.DA772235007@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-ide-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: jgarzik@pobox.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-02-21 11:33:50, David Brownell wrote:
> > libata uses it under the assumption that "other parts" of the system are 
> > aware of this variable.

There are no other relevant parts, except one debug printk that is
getting removed.

> > May I assume that the API has changed such that this is no longer necessary?
> 
> Yes.  The original motivation for dev->power.power_state was to let

ACK.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
