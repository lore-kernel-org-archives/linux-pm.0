From: "Chanho Min" <chanho.min@lge.com>
Subject: RE: [PATCH v2] exec: make de_thread() freezable
Date: Wed, 14 Nov 2018 19:18:42 +0900
Message-ID: <014a01d47c03$6b64eef0$422eccd0$@lge.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com> <20181113145339.GD16182@dhcp22.suse.cz> <20181113161858.GE30990@redhat.com> <20181113180058.GT15120@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113180058.GT15120@dhcp22.suse.cz>
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Michal Hocko' <mhocko@kernel.org>, 'Oleg Nesterov' <oleg@redhat.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Pavel Machek' <pavel@ucw.cz>, 'Len Brown' <len.brown@intel.com>, 'Andrew Morton' <akpm@linux-foundation.org>, "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Christian Brauner' <christian@brauner.io>, 'Anna-Maria Gleixner' <anna-maria@linutronix.de>, 'Alexander Viro' <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 'Seungho Park' <seungho1.park@lge.com>, 'Inkyu Hwang' <inkyu.hwang@lge.com>, 'Donghwan Jung' <donghwan.jung@lge.com>, 'Jongsung Kim' <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

> > > It's been some time since I have looked into this code so bear with
me.
> > > One thing is not really clear to me. Why does it help to exclude this
> > > particular task from the freezer
> >
> > we don't exclude it,
> >
> > > when it is not sleeping in the freezer.
> >
> > Yes, it is not sleeping in __refrigerator(), but it does
> >
> > 	schedule();
> > 	freezer_count();
> >
> > so it will enter __refrigerator() right after wakeup. If it won't be
> woken
> > up we do not care, we can consider it "frozen".
> 
> Right, but this is just silencing the freezing code to exclude this
> task, right?
> 
> > > I can see how other threads need to be zapped and TASK_WAKEKILL
> doesn't
> > > do that but shouldn't we fix that instead?
> >
> > Not sure I understand, but unlikely we can (or want) to make
> __refrigerator()
> > killable.
> 
> Why would that be a problem. If the kill is fatal then why to keep the
> killed task in the fridge?
> 

Is it  different between 'the killed task is frozen' and '__refrigerator()
is killable'?
>From a general '__refrigerator()' implementation point of view I know that
it should not be killable.

> > Otherwise, how can we fix that?
> 
> We can mark all threads PF_NOFREEZE and wake them up. This would require
> some more changes of course but wouldn't that be a more appropriate
> solution? Do we want to block exec for ever just because some threads
> are in the fridge?
> 

IMHO, It seems to be difficult and buggy to control with PF_NOFREEZE.
Because,
The sub-thread can freeze and receive SIG_KILL before the marking of
PF_NOFREEZE
and it should be freezable in other cases. I don't understand why it isn't
appropriate
for exec to block. The exec can freeze. When tasks are thawed, the killed
sub-thread
will die and wake de_thread(). The exec will continue to work from resume.

Chanho
