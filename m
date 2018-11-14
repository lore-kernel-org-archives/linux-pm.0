From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Date: Wed, 14 Nov 2018 15:37:06 +0100
Message-ID: <20181114143705.GB13885@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
 <20181113145339.GD16182@dhcp22.suse.cz>
 <20181113161858.GE30990@redhat.com>
 <20181113180058.GT15120@dhcp22.suse.cz>
 <014a01d47c03$6b64eef0$422eccd0$@lge.com>
 <20181114103014.GN23419@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114103014.GN23419@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Chanho Min <chanho.min@lge.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Pavel Machek' <pavel@ucw.cz>, 'Len Brown' <len.brown@intel.com>, 'Andrew Morton' <akpm@linux-foundation.org>, "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Christian Brauner' <christian@brauner.io>, 'Anna-Maria Gleixner' <anna-maria@linutronix.de>, 'Alexander Viro' <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 'Seungho Park' <seungho1.park@lge.com>, 'Inkyu Hwang' <inkyu.hwang@lge.com>, 'Donghwan Jung' <donghwan.jung@lge.com>, 'Jongsung Kim' <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On 11/14, Michal Hocko wrote:
>
> > I don't understand why it isn't appropriate for exec to block. The
> > exec can freeze. When tasks are thawed, the killed sub-thread will die
> > and wake de_thread(). The exec will continue to work from resume.
>
> Because this is fragile.

I don't really agree, but...

> I haven't checked the full set of resources the
> task holds when in this path but I can imagine we can introduce lock
> dependency on freezing really easily.

And you are right, see another email I sent you a minute ago.

But again, we need to change de_thread to sleep without cred_guard_mutex
anyway, so I think this change is fine. At least in that it can't add the
new problems.

Oleg.
