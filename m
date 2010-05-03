From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Mon, 3 May 2010 15:01:41 -0700
Message-ID: <x2id6200be21005031501p7f151324wb8bbf928bc2cb25e__34554.5220691294$1272924148$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005021755320.30701-100000@netrider.rowland.org>
	<201005031703.11448.rjw@sisk.pl>
	<m2yd6200be21005031426n87ea43a0k968fd5898ce0b873@mail.gmail.com>
	<201005032349.00876.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005032349.00876.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/3 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday 03 May 2010, Arve Hj=F8nnev=E5g wrote:
>> On Mon, May 3, 2010 at 8:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Sunday 02 May 2010, Alan Stern wrote:
>> >> On Sun, 2 May 2010, Rafael J. Wysocki wrote:
>> >>
>> >> > Hmm. =A0It doesn't seem to be possible to create two different susp=
end blockers
>> >> > using the same file handle. =A0So, what exactly is a process suppos=
ed to do to
>> >> > use two suspend blockers at the same time?
>> >>
>> >> Open the file twice, thereby obtaining two file handles.
>> >
>> > Well, that's what I thought.
>> >
>> > I must admit I'm not really comfortable with this interface. =A0IMO it=
 would
>> > be better if _open() created the suspend blocker giving it a name base=
d on
>> > the name of the process that called it. =A0Something like
>> > "<process name>_<timestamp>" might work at first sight.
>> >
>> > Alternatively, "<process_name><number>", where <number> is 0 for the f=
irst
>> > suspend blocker created by the given process, 1 for the second one etc=
., also
>> > seems to be doable.
>>
>> I think it is important to let user-space specify the name. If a
>> process uses multiple suspend blockers, it is impossible to tell what
>> each one is used for if they are automatically named.
>
> Well, the problem is the only purpose of this is user space debugging, is=
n't it?
>
At the moment, yes. But having an explicit init call also simplifies
future expansion. If we ever need to add back multiple types of
suspend blockers, we can add an init call with a type argument and
have the current init call use the default type. If the past we have
had types that keeps the screen on and prevented idle sleep modes. In
the future we could for instance want to specify if a suspend blocker
should prevent suspend when the battery is low or when the lid is
closed.

> Now, while I don't think it's generally bad to provide kernel interfaces
> helping to debug user space, I'm not quite sure if that should be done at=
 the
> expense of the clarity of kernel-user space interfaces.
>
> I wonder how many cases there are in which distinguishing between suspend
> blockers used by the same user space task is practically relevant.
>

I think all of them (when more than one suspend blocker is used).

-- =

Arve Hj=F8nnev=E5g
