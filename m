From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 00:20:43 +0100
Message-ID: <200902210020.47665.oliver__27238.2258357995$1235171916$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
	<200902202305.09992.oliver@neukum.org>
	<d6200be20902201511w4db68e96reaa3b0901437a1d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902201511w4db68e96reaa3b0901437a1d1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Samstag 21 Februar 2009 00:11:28 schrieb Arve Hj=F8nnev=E5g:
> On Fri, Feb 20, 2009 at 2:05 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Freitag 20 Februar 2009 11:46:55 schrieb Rafael J. Wysocki:
> >> On Thursday 19 February 2009, Oliver Neukum wrote:

> > With the set of runnable processes.There's always a window between
> > evaluating the current set of runnable tasks and telling the kernel to
> > sleep. IMO the most elegant solution would be a task attribute that wou=
ld
> > signal the kernel that a task should not count as keeping the system bu=
sy
> > even if it is runnable and trigger the sleep in kernel space.
>
> It is not always safe to enter suspend when no tasks are runnable. For
> instance, a key event could be on a user space queue, but the code
> that reads from that queue has been paged out.

In that case you'd have a task waiting for IO. The driver should refuse
to suspend or wake up the system as IO is completed. It may be
inefficient to suspend for such a presumably short time, but it is not
a correctness issue.

	Regards
		Oliver
