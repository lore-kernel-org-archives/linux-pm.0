From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Sun, 16 May 2010 21:16:26 -0700
Message-ID: <AANLkTinP68yHYfVCW-urCrRbeSb0Mlz8JsvAs-FKoUPZ__43225.8719033145$1274069834$gmane$org@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005162142.39343.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005162142.39343.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2010/5/16 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>> This patch series adds a suspend-block api that provides the same
>> functionality as the android wakelock api. This version has some
>> changes from, or requested by, Rafael. The most notable changes are:
>> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have been added
>> =A0 for statically allocated suspend blockers.
>> - suspend_blocker_destroy is now called suspend_blocker_unregister
>> - The user space mandatory _INIT ioctl has been replaced with an
>> =A0 optional _SET_NAME ioctl.
>>
>> I kept the ack and reviewed by tags on two of the patches even though
>> there were a few cosmetic changes.
>
> I have one more comment, sorry for that.
>
> Namely, if /sys/power/policy is set to "opportunistic" and "mem" is writt=
en
> into /sys/power/state and there are no suspend blockers present except for
> the main blocker (and the blockers used only for statistics), the system =
won't
> be able to go out of an infinit suspend-resume loop (or at least it seems
> so from reading the code).
>
> I think we should prevent that from happening somehow.
>

It should get out of that loop as soon as someone blocks suspend. If
someone is constantly aborting suspend without using a suspend blocker
it will be very inefficient, but it should still work.

-- =

Arve Hj=F8nnev=E5g
