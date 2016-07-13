From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Introduce snapshot test mode for
 hibernation
Date: Wed, 13 Jul 2016 22:26:11 +0200
Message-ID: <20160713202611.GA32111@amd>
References: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
 <20160713095005.GA27870@amd>
 <578615D5.3060501@intel.com>
 <20160713102156.GA14505@atrey.karlin.mff.cuni.cz>
 <57861A70.9090606@intel.com>
 <20160713170123.GA13546@amd>
 <CAJZ5v0jfFFKs09sQC0Fq2iiL30tJxKtaie7tWCaczO+Dm3Aa+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jfFFKs09sQC0Fq2iiL30tJxKtaie7tWCaczO+Dm3Aa+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2016-07-13 22:04:27, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2016 at 7:01 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> >>and then swapon the swap device, and do a testing. This should be safer?
> >> >Yeah, that's the way. Read-only root is other option.
> >> >
> >> >>>I guess updating documentation would be welcome from my side,
> >> >>>otherwise it should be ok.
> >> >>OK, I'll  update the documents.
> >> >Just add fat warning into the documentation.
> >> OK.
> >
> > Actually... If you could add
> >
> > printk(KERN_ALERT "Hibernation image written. If you have any
> > filesystems mounted read-write and attempt to resume, you'll corrupt
> > your data. To prevent that, remove the hibernation image.\n")
> >
> > ...I guess that would save someone's filesystem. (Yes, very high
> > loglevel. If you attempt to do this from anything else then singleuser
> > or initrd, you are asking for problems, so... lets make sure user sees
> > it.)
> 
> Please see the new version of this patch:
> https://patchwork.kernel.org/patch/9226837/

New version changes nothing, right? You still need to be sure
filesystems are not mounted r/w. So I would still like to see printk()
with warning.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
