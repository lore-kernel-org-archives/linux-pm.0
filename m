From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 22:55:37 +0200
Message-ID: <200707132255.39077.rjw__49458.8517271497$1184359737$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707131146340.2555-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707131146340.2555-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 13 July 2007 17:50, Alan Stern wrote:
> On Fri, 13 Jul 2007, Rafael J. Wysocki wrote:
> 
> > Okay, I have thought it through and I think that, as an initial step, we can do
> > something like this:
> > 
> > - preload the image-saving kernel before hibernation
> > - in the hibernation code path replace device_suspend() with the shutting down of
> >   all devices without unregistering them (not very nice, but should be sufficient
> >   for a while)
> > - when we've called device_power_down() and save_processor_state(), jump to
> >   the image-saving kernel and let it run
> > - make the image-saving kernel set up everything, save the image without
> >   starting any user space (we may use the existing image-saving code for this
> >   purpose, with some modifications) and power off the system (or make it enter
> >   S4)
> > - use the existing restoration code to load the image and jump to the
> >   hibernated kernel
> > - in the restore code patch replace device_resume() with the reprobing of all
> >   devices.
> > 
> > Comments?
> 
> I doubt that re-probing devices will work.  The probe routine won't 
> expect there to be any registered children, so it will try to 
> re-register them.

I didn't mean to use .probe() for that.  I just used the term "reprobe" as
similar to "reinit", but not exactly the same.

> On the other hand, post_restore methods could be written to expect 
> something like this.

Yes, that's what I'm thinking of.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
