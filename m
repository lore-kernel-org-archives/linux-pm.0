From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 15:11:28 -0800
Message-ID: <d6200be20902201511w4db68e96reaa3b0901437a1d1@mail.gmail.com>
References: <Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
	<200902192358.13068.oliver@neukum.org>
	<200902201146.59944.rjw@sisk.pl>
	<200902202305.09992.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902202305.09992.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 20, 2009 at 2:05 PM, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag 20 Februar 2009 11:46:55 schrieb Rafael J. Wysocki:
>> On Thursday 19 February 2009, Oliver Neukum wrote:
>> > Am Donnerstag 19 Februar 2009 23:21:46 schrieb Rafael J. Wysocki:
>> > > > That's the whole point behind userspace wakelocks!  They provide a
>> > > > mechanism for userspace to tell the kernel when (as far as userspa=
ce
>> >
>> > is
>> >
>> > > > concerned) it is or is not okay to auto-sleep.
>> > >
>> > > Still, one can go further and observe that the user space can in fact
>> > > start automatic suspend by itself whenever it knows it's appropriate
>> > > ...
>> >
>> > User space initiating this is a race condition.
>>
>> Do you mean a race with the other user space processes or with the kerne=
l?
>
> With the set of runnable processes.There's always a window between
> evaluating the current set of runnable tasks and telling the kernel to sl=
eep.
> IMO the most elegant solution would be a task attribute that would signal
> the kernel that a task should not count as keeping the system busy even
> if it is runnable and trigger the sleep in kernel space.

It is not always safe to enter suspend when no tasks are runnable. For
instance, a key event could be on a user space queue, but the code
that reads from that queue has been paged out.

-- =

Arve Hj=F8nnev=E5g
