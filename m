From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: resume from s2ram regression (bisected to ftrace...)
Date: Sun, 10 Aug 2008 19:40:12 +0200
Message-ID: <200808101940.13753.rjw__37716.4923506372$1218390090$gmane$org@sisk.pl>
References: <20080810170801.GA5739@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080810170801.GA5739@joi>
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
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 10 of August 2008, Marcin Slusarz wrote:
> Hi
> 
> Few days ago I discovered that resume from suspend to ram does not work anymore
> on my 2.6.27-rc2 (actually 796aadeb1b2db9b5d463946766c5bbfd7717158c) gentoo box.
> My computer just boots on resume. Today I had enough time to bisect it and found
> (after 1 panic and 1 build breakage) out "the reason":
> 
> $ git bisect good
> d05cdb25d80f06f77aa6bddb53cd1390d4d91a0b is first bad commit
> commit d05cdb25d80f06f77aa6bddb53cd1390d4d91a0b
> Author: Steven Rostedt <rostedt@goodmis.org>
> Date:   Mon May 12 21:20:54 2008 +0200
> 
>     ftrace: fix dynamic ftrace selftest

Does it still happen if:
- CONFIG_FTRACE is unset
- CONFIG_FTRACE is set, but CONFIG_FTRACE_STARTUP_TEST is unset?

Rafael
