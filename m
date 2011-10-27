From: Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 1/4] freezer: make fake_signal_wake_up wake
 TASK_KILLABLE tasks too
Date: Thu, 27 Oct 2011 15:26:20 -0500
Message-ID: <CAH2r5ms-TKOKGbYJMQAN+BFNFCz9DnaKxrgxcLLTmm2Z798v6w__48845.0841549367$1320296207$gmane$org@mail.gmail.com>
References: <1317210761-11518-1-git-send-email-jlayton@redhat.com>
	<20111026155548.4a7c3dd8@corrin.poochiereds.net>
	<201110272221.06782.rjw@sisk.pl> <201110272222.39962.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201110272222.39962.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>, trond.myklebust@netapp.com, linux-kernel@vger.kernel.org, john@calva.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

FYI - I included the cifs one "cifs, freezer: add
wait_event_freezekillable and have cifs use it" (and the corequisite
fix for the build break when freezer not enabled) in my recent cifs
merge request.

On Thu, Oct 27, 2011 at 3:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, October 27, 2011, Rafael J. Wysocki wrote:
>> On Wednesday, October 26, 2011, Jeff Layton wrote:
>> > On Tue, 11 Oct 2011 21:14:28 +0200
>> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>> >
>> > > On Tuesday, October 11, 2011, Jeff Layton wrote:
>> > > > On Tue, 11 Oct 2011 08:18:48 +0200
>> > > > Pavel Machek <pavel@ucw.cz> wrote:
>> > > >
>> > > > >
>> > > > > Hi!
>> > > > >
>> > > > > > TASK_KILLABLE is often used to put tasks to sleep for quite so=
me time.
>> > > > > > One of the most common uses is to put tasks to sleep while wai=
ting for
>> > > > > > replies from a server on a networked filesystem (such as CIFS =
or NFS).
>> > > > > >
>> > > > > > Unfortunately, fake_signal_wake_up does not currently wake up =
tasks
>> > > > > > that are sleeping in TASK_KILLABLE state. This means that even=
 if the
>> > > > > > code were in place to allow them to freeze while in this sleep=
, it
>> > > > > > wouldn't work anyway.
>> > > > > >
>> > > > > > This patch changes this function to wake tasks in this state a=
s well.
>> > > > > > This should be harmless -- if the code doing the sleeping does=
n't have
>> > > > > > handling to deal with freezer events, it should just go back t=
o sleep.
>> > > > >
>> > > > > I'm pretty sure this will break something; but that does not mea=
n it
>> > > > > is bad idea, just that it should be merged early and tested a lo=
t.
>> > > > >
>> > > >
>> > > > FWIW, I looked at most of the places in the kernel that do
>> > > > TASK_KILLABLE sleeps and they look like they'll handle this correc=
tly.
>> > > > The main one I wasn't sure about was mem_cgroup_handle_oom(), but I
>> > > > think it'll do the right thing too. I certainly could have missed
>> > > > something though...
>> > > >
>> > > > In any case, would you mind merging this via the linux-pm tree for=
 3.2?
>> > >
>> > > I will push it for 3.2.
>> > >
>> >
>> > Hi Rafael,
>> >
>> > Trond asked if you would also be willing to push patches 3 and 4 in
>> > this series for 3.2 as well [1]? Note that patch #4 got another revisi=
on so
>> > we'll want to make sure that you get that one. I can resend the
>> > nfs/sunrpc patches if that will help...
>> >
>> > [1]: I think Steve F is going to push patch #2, so that one shouldn't
>> > be an issue.
>>
>> Well, I've already sent my pull request. =A0I can keep these patches in =
my
>> tree for the next pull request, though (I'm sure there will be fixes aga=
inst
>> 3.2, so they will go along with those).
>
> BTW, do you have current versions handy? =A0Or hasn't they changed?
>
> Rafael
>



-- =

Thanks,

Steve
