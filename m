From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] sleepy linux
Date: Thu, 27 Dec 2007 00:15:39 +0100
Message-ID: <200712270015.40165.oliver@neukum.org>
References: <20071225230731.GA29030@elf.ucw.cz> <200712262123.37152.oliver@neukum.org> <20071226203258.GE8094@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752860AbXLZXP1@vger.kernel.org>
In-Reply-To: <20071226203258.GE8094@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 26. Dezember 2007 21:32:58 schrieb Pavel Machek:
> On Wed 2007-12-26 21:23:37, Oliver Neukum wrote:
> > Am Mittwoch, 26. Dezember 2007 21:17:22 schrieb Pavel Machek:

> > > Is there an easy way to tell if all the devices are runtime suspended?
> > 
> > Do you really want to know whether they are suspended or whether they
> > could be suspended?
> 
> If they are suspended.
> 
> My plan is: let the drivers autosuspend on their own. If I see all of
> them are autosuspended, then it looks like great time to put whole
> system into s2ram...

Your calculation of cost/benefit will be wrong. A driver will have timeouts
based on the cost of a suspend/resume cycle of that device only.
You'd have to calculate of keeping the whole system awake against that.

	Regards
		Oliver
