From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] suspend/resume performance improvement
Date: Wed, 27 May 2015 02:24:59 +0200
Message-ID: <6784182.VyN0PstglH@vostro.rjw.lan>
References: <1141174354.499851432649147087.JavaMail.weblogic@epmlwas01d>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1141174354.499851432649147087.JavaMail.weblogic@epmlwas01d>
Sender: linux-kernel-owner@vger.kernel.org
To: eun.taik.lee@samsung.com
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 26, 2015 02:05:48 PM =EC=9D=B4=EC=9D=80=ED=83=9D wrote:
> When a task that calls state_store() to suspend
> the device has used up most of its time slice,
> suspend sometimes take too long. (User noticeable)
>=20
> Suspend/resume is a system wide operation.
> So, instead of depending on a userspace task's time
> slice, let kworker do the work to avoid a long wait
> on the runqueue.

All of that seems to duplicate the existing autosleep.c functionality.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
