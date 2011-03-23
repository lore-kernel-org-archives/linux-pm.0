From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Corrupted files after suspend to disk
Date: Wed, 23 Mar 2011 21:36:18 +0100
Message-ID: <201103232136.19091.rjw__16139.088132377$1300914152$gmane$org@sisk.pl>
References: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 23, 2011, richard -rw- weinberger wrote:
> Hi,
> 
> I'm facing a very strange problem on my netbook (Lenovo Ideapad S10)
> running Linux 2.6.37.4.
> After resuming from s2disk some files are corrupted.
> But when I reboot my netbook everything seems good again.
> 
> When I saw the problem the first time the ls command segfaulted always.
> I did a reboot and it worked again.
> 
> A few days later zypper crashed. After a reboot it worked again.
> And today ssh crashed. I looked a bit closer and saw it crashed
> somewhere within libcrypto.
> So I made copy libcrypto and rebooted.
> After the reboot ssh worked again but libcrypto and the copy of it hat
> a different sha1 sum!
> WTF?!
> 
> Is this a known issue?

No.

> dmesgs and config are attached.
> 
> The used distribution is openSUSE 11.4 with suspend-0.80.20100129-7.1
> (default from suse).
> I'm using ext3 as root filesystem.
> What else do you need?

Whatever you can do to narrow down the problem.  At the moment I only know
that it's there.

Thanks,
Rafael
