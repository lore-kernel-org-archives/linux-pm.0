From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Date: Wed, 20 Feb 2019 22:45:24 +0100
Message-ID: <CAJZ5v0gmFz8aK5_+0a36RwEiPScU=Z8BhD8pR50V1GRcmbXFgA@mail.gmail.com>
References: <20190206154214.576-1-harry.pan@intel.com> <20190214111543.22137-1-harry.pan@intel.com>
 <2819109.DzhZvocLkm@aspire.rjw.lan> <cf6926800899354808143bd48b4f943629c8cbe7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cf6926800899354808143bd48b4f943629c8cbe7.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pan, Harry" <harry.pan@intel.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gs0622@gmail.com" <gs0622@gmail.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 5:44 PM Pan, Harry <harry.pan@intel.com> wrote:
>
> Thanks for comments.
>
> > > +   if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
> > > +           ktime_t start;
> > > +           unsigned int elapsed_msecs;
> > > +
> > > +           trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> > > +           pr_info("Syncing filesystems ... ");
> > > +           start = ktime_get();
> > > +           ksys_sync();
> > > +           elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(),
> > > start));
> > > +           pr_cont("(elapsed %d.%03d seconds) done.\n",
> > > +                   elapsed_msecs / MSEC_PER_SEC,
> > > +                   elapsed_msecs % MSEC_PER_SEC);
> >
> > One more nit.
> >
> > Since you are printing the sync time anyway, there is a little sense
> > to
> > split the message using pr_cont() that may be messed up with by any
> > intervening messages, so why don't you just print a one-line
> > pr_info("Filesystems sync: %d.%03d seconds\n", ...) message?
> >
> Yes, I agree.
> In practical, I did see intervening messages (between pr_info and
> pr_cont) when it came to long sync in kernel.
> I was hesitated in this considering not fully understanding the
> backdrop of split messages using pr_info() then pr_cont().
>
> > Also, if you change it here, I guess it would be consistent to make
> > an analogous change for hibernation.
>
> One potential last-mile need your wisdom, which is about the switch
> case of SNAPSHOT_FREEZE of the userspace interface you wrote.
> I am yet to touch it, nor understand how to validate it.

Why don't you add a "sync" helper function in main.c with the timing
and message that will be called from hibernate.c, user.c and suspend.c
(in the last one conditional on
!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC))?

That would reduce some code duplication nicely.
