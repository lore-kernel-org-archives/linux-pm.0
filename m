From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] suspend/resume performance improvement
Date: Wed, 27 May 2015 09:50:28 +0200
Message-ID: <20150527075028.GC1254@amd>
References: <1141174354.499851432649147087.JavaMail.weblogic@epmlwas01d>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1141174354.499851432649147087.JavaMail.weblogic@epmlwas01d>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?7J207J2A7YOd?= <eun.taik.lee@samsung.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2015-05-26 14:05:47, =EC=9D=B4=EC=9D=80=ED=83=9D wrote:
> When a task that calls state_store() to suspend
> the device has used up most of its time slice,
> suspend sometimes take too long. (User noticeable)
>=20
> Suspend/resume is a system wide operation.

It is also root-only.

> So, instead of depending on a userspace task's time
> slice, let kworker do the work to avoid a long wait
> on the runqueue.

=2E..so if you really want high priority for that operation, just renic=
e
yourself to higher priority or something...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
