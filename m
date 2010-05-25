From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 15:33:50 -0700
Message-ID: <AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y__17899.7838673697$1274826984$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005252344.37639.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, tytso@mit.edu, linux-doc@vger.kernel.org, Greg KH <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 25, 2010 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 25 May 2010, Alan Stern wrote:
>> On Tue, 25 May 2010, Rafael J. Wysocki wrote:
>>
>> > So, basically, you'd prefer to move the entire complexity to user spac=
e.
>>
>> No, just the complexity of the userspace suspend blockers. =A0That was
>> one of the parts of the interface that people objected to, after all.
>>
>> > I'm not sure if that's a big win
>>
>> It's not a _big_ win, but it is an improvement IMO.
>>
>> > =A0and I'm not sure anyone is actually going to
>> > implement it (and some drivers would still have to be modified to part=
icipate
>> > in this framework).
>>
>> Of course drivers have to be modified. =A0The kernel-layer suspend
>> blockers aren't affected by this proposal, so they still have to be
>> implemented.
>>
>> > =A0So again, we have a hunch that the goal may be achieved
>> > in a different way, but at this point we'd rather need a _working_ _so=
lution_
>> > (in the form of code one can build and actually use).
>>
>> It's not very different from what has been submitted, and I think
>> there's little doubt that it could be built and used fairly easily.
>> All we're talking about is removing the userspace suspend-blocker API
>> and the opportunistic workqueue, replacing them with an "opportunistic"
>> entry in /sys/power/state, and setting up a userspace power manager
>> process.
>>
>> > I don't think it's realistic to expect the Android people to go and re=
design
>> > their stuff along the lines you've described, because they have a work=
ing
>> > implementation (in the kernel) that they are satisfied with.
>>
>> The redesign would be pretty small. =A0The kernel changes relative to
>> what they have submitted are minimal, mostly just removing a few of
>> their additions. =A0Furthermore, we've been told that Android _already_
>> funnels all its userspace suspend-blocker work through a single
>> process. =A0All that would be needed would be to make that process
>> initiate an opportunistic suspend whenever no userspace suspend
>> blockers were active.
>>
>> > Now, we can reject their patches, but that's not going to cause any pr=
ogress
>> > to happen, realistically. =A0Quite on the contrary, Android will conti=
nue to use
>> > wakelocks and Android driver writers will continue to ignore the mainl=
ine
>> > and the gap between the two kernel lines will only get wider and wider=
 over
>> > time.
>> >
>> > And what really is the drawback if we merge the patches? =A0Quite fran=
kly,
>> > I don't see any.
>>
>> You don't seem to appreciate how small a change Dmitry has proposed.
>> Almost all of the suspend-blocker work would remain as in the submitted
>> patches. =A0The only difference is that the userspace API and
>> opportunistic-suspend implementation would be simplified, by moving
>> some of the work out of the kernel.
>
> No, I don't really think it's going to be a small change. =A0The problem =
is that
> for the Android people changing user space is very hard, so I don't think
> this realy is an option, given that they would have to implement it thems=
elves,
> test it, validate it on multiple different hardware platforms etc. and _t=
hen_
> resubmit the feature without any guarantee that it will be merged.
>

The biggest problem here is not that it is hard to change our
user-space, but that the proposed change is inferior to what we have
now. It forces us to poll until all drivers stop aborting suspend. On
one hand we have people telling us that all code that polls is broken
and must be fixed (instead of suspending to limit the damage), and on
the other hand we have people suggesting we implement opportunistic
suspend by polling from user-space until suspend succeeds.


> So, my opinion is that we only have a choice to either take the feature a=
s is
> now, or reject it altogether and live with the consequeces in each case. =
=A0And
> quite frankly I don't feel like I'm in position to make that decision.
>



-- =

Arve Hj=F8nnev=E5g
