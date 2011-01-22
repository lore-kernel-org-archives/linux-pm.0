From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 10:22:21 -0800
Message-ID: <AANLkTikSsQUQ5P8=rxmhwV-WmP6zAZt50j+s9EpLj0Pm__3869.45442664928$1295720692$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
	<AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
	<201101221110.17786.rjw@sisk.pl>
	<AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
	<AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
	<AANLkTi=oHRzcK1KFSSziwXdJ1NJyt9oEyyCFDMY4KHc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=oHRzcK1KFSSziwXdJ1NJyt9oEyyCFDMY4KHc5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 22, 2011 at 9:13 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> How many CPUs do you have? If more than one, try switching offline all
> /sys/devices/system/cpu/cpu*/online before suspend.

It's an Atom with SMT, so it shows up as two CPU's.

That doesn't really explain why a regular "echo mem" works but the
pm-suspend doesn't.

             Linus
