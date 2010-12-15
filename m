From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC][PATCH 2/4] PM: Remove redundant checks from
 core device resume routines
Date: Wed, 15 Dec 2010 22:12:49 +0800
Message-ID: <AANLkTikT-8XjqBfSPAVRZRKp5BQq_D8DeUo2YN3c4ntF__28776.9023598687$1292422467$gmane$org@mail.gmail.com>
References: <201012130128.31243.rjw@sisk.pl>
	<AANLkTi=UVOQb15EdpfSeD+Qh8x779pJpsSCTyGvf-gxG@mail.gmail.com>
	<AANLkTim+UoR+GeEK8T1_jgie3gwq6Pdt_=sRiSf8qx6K@mail.gmail.com>
	<201012142058.04469.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012142058.04469.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2010/12/15 Rafael J. Wysocki <rjw@sisk.pl>:
> On Tuesday, December 14, 2010, Ming Lei wrote:

>> Seems it may apply in other cases(dpm_prepare/dpm_suspend
>> /dpm_suspend_noirq) too?
>
> I thought about that, but in these cases the status is changed after the
> callback has returned and only if it's succeeded. =A0Moreover, if the cal=
lback
> hasn't been successful, the device is not moved to the new list, so I thi=
nk
> it's better to leave that as is.

Yes, you are right, sorry for my noise, :-(


thanks,
-- =

Lei Ming
