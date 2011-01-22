From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 01:31:11 +0100
Message-ID: <201101220131.11688.rjw__44861.4424014979$1295656455$gmane$org@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<201101220016.46227.rjw@sisk.pl>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 22, 2011, Linus Torvalds wrote:
> On Fri, Jan 21, 2011 at 3:16 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > I wonder if you can reproduce the failure with the
> >
> > # echo core > /sys/power/pm_test
> > # echo mem > /sys/power/state
> >
> > test?  I think you can even try to run the second command in a tight loop
> > (the first one simply triggers a switch) and see what happens.
> 
> I don't think I can. I did 60 of those "echo mem > /sys/power/state"
> in a row on top of current -git.
> 
> So I do think that the problem is connected to the actual sleeping part.
> 
> Or - and perhaps more likely - it's connected to the lid event, and
> how that interacts with user space and then eventually triggers the
> sleep event (which is quite likely - as mentioned, I think I've only
> ever seen the problem when I'm physically at the machine).

Does opening the lid wake up the machine normally?

(You probably said that already, but I can't find the answer right now,
very likely because it's 1:30 AM here and I'm a little tired).
