From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Occasional (too common) suspend problem
Date: Sun, 23 Jan 2011 01:13:04 +0800
Message-ID: <AANLkTi=oHRzcK1KFSSziwXdJ1NJyt9oEyyCFDMY4KHc5__33583.91428269$1295716438$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
	<AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
	<201101221110.17786.rjw@sisk.pl>
	<AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
	<AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
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
Cc: Dave Airlie <airlied@linux.ie>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 23, 2011 at 12:27 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Jan 22, 2011 at 7:11 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Hmm. I can certainly believe in the "BIOS is confused" idea, but I
>> don't see where that gets us.
>
> So, trying to get some more hints in what is going on, I started
> getting creative, and I have a few more clues, I think.

How many CPUs do you have? If more than one, try switching offline all
/sys/devices/system/cpu/cpu*/online before suspend.

I'm getting 1/2 working suspend-to-disk, but now with offline all the
rest of the CPUs, it seems to not hang anymore.

Jeff
