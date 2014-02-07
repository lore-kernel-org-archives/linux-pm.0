From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: 3.12: ethernet controller missing after resuming from suspend
 to RAM
Date: Fri, 07 Feb 2014 08:29:42 +0100
Message-ID: <52F48B66.9070407@gmail.com>
References: <52F2CC7B.80406@gmail.com> <52F33BE7.2040607@gmail.com> <2240387.gpLEHJv4c1@vostro.rjw.lan> <52F4179C.70400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52F4179C.70400@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Traverse <bastien.traverse@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/07/2014 12:15 AM, Bastien Traverse wrote:
> 
> I was also hit by the rtsx driver bug
> (https://bugs.archlinux.org/task/37720) and was delighted with its fast
> resolution. I was hoping that its fix would also address the
> disappearing Ethernet bug.

yeah, but calling this "fast resolution" is quite incorrect.

I don't blame anyone for this and I'm quite happy that a workaround has
been found at last but calling this "fast resolution" is a bit funny
compare to the PITA it was to debug this.

That's probably why I haven't tried to do a similar work for this bug.

Thanks.
