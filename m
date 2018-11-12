From: "Chanho Min" <chanho.min@lge.com>
Subject: RE: [PATCH] exec: make de_thread() freezable
Date: Mon, 12 Nov 2018 11:00:19 +0900
Message-ID: <073101d47a2b$7706e530$6514af90$@lge.com>
References: <1541752656-12857-1-git-send-email-chanho.min@lge.com> <20181109092123.GA29945@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109092123.GA29945@redhat.com>
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Oleg Nesterov' <oleg@redhat.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Pavel Machek' <pavel@ucw.cz>, 'Len Brown' <len.brown@intel.com>, 'Andrew Morton' <akpm@linux-foundation.org>, "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Christian Brauner' <christian@brauner.io>, 'Anna-Maria Gleixner' <anna-maria@linutronix.de>, 'Alexander Viro' <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 'Seungho Park' <seungho1.park@lge.com>, 'Inkyu Hwang' <inkyu.hwang@lge.com>, 'Donghwan Jung' <donghwan.jung@lge.com>, 'Jongsung Kim' <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

> Thanks, but please note another schedule() in "if
> (!thread_group_leader(tsk))"
> branch, we probably want to change it too?
> 
> Oleg.
Sounds right, The thread group leader might be frozen as well.
I'll prepare v2.
