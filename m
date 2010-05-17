From: Mike Snitzer <snitzer@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Mon, 17 May 2010 15:01:19 -0400
Message-ID: <AANLkTilE4bLZql7W0manAfJUp-S03jK-hUjLfNFxVFcx__43069.2545640797$1274123021$gmane$org@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005142308.48386.rjw@sisk.pl>
	<AANLkTilX0uhqrJtUSOC4smdH1M8V-h14J7YtRG4PPxOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilX0uhqrJtUSOC4smdH1M8V-h14J7YtRG4PPxOQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

2010/5/17 Arve Hj=F8nnev=E5g <arve@android.com>:
> 2010/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
>> On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>>> This patch series adds a suspend-block api that provides the same
>>> functionality as the android wakelock api. This version has some
>>> changes from, or requested by, Rafael. The most notable changes are:
>>> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have been added
>>> =A0 for statically allocated suspend blockers.
>>> - suspend_blocker_destroy is now called suspend_blocker_unregister
>>> - The user space mandatory _INIT ioctl has been replaced with an
>>> =A0 optional _SET_NAME ioctl.
>>>
>>> I kept the ack and reviewed by tags on two of the patches even though
>>> there were a few cosmetic changes.
>>
>> Thanks for the patches, I think they are in a pretty good shape now.
>>
>> That said, I'd like the changelogs to be a bit more descriptive, at leas=
t for
>> patch [1/8]. =A0I think it should explain (in a few words) what the purp=
ose of
>> the feature is and what problems it solves that generally a combination =
of
>> runtime PM and cpuidle is not suitable for in your opinion. =A0IOW, why =
you
>> think we need that feature.
>>
>
> How about:
>
> PM: Add opportunistic suspend support.
>
> Adds a suspend block api

In the future I think it'd be ideal if you were to always use "suspend
blocker" (rather than "suspend block").

This work has nothing to do with the block layer yet by the subject I
thought it somehow did.
