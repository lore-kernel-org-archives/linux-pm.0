From: Matt Reimer <mattjreimer@gmail.com>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Thu, 22 Apr 2010 16:40:58 -0700
Message-ID: <y2yf383264b1004221640rd1fca614zfa15d7e7984ab3ba__13820.5256815583$1272041590$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1003032142580.6963-100000@netrider.rowland.org>
	<201003042026.30303.rjw@sisk.pl> <20100304201548.GA1341@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100304201548.GA1341@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 4, 2010 at 1:15 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > My thought exactly. =A0This is the only approach that also solves the
>> > following race:
>> >
>> > =A0 =A0 A driver is unloaded at the same time as a suspend starts.
>> >
>> > =A0 =A0 The writeback thread gets frozen.
>> >
>> > =A0 =A0 Then before the rmmod thread is frozen, it calls del_gendisk.
>> >
>> > Delaying things by means of a workqueue (or the equivalent) might also
>> > work, but it doesn't seem as safe. =A0For example, some important
>> > writebacks might end up getting delayed until too late.
>
> Delaying writebacks during sleep should be ok... That's why we do
> sync() after userspace is frozen -- nothing really important should be
> waiting for writeback after that point.

Has this been fixed, or has a consensus about how to fix this been
achieved? I'm hitting the same problem and have some time to work on a
fix.

Matt
