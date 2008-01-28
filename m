From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: x86 suspend/hibernation code consolidation
Date: Mon, 28 Jan 2008 15:03:50 +0100
Message-ID: <20080128140350.GB27928__37000.6626043052$1201529204$gmane$org@elte.hu>
References: <200801260132.09529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801260132.09529.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> I'd like to move the 64-bit suspend/hibernation files from 
> arch/x86/kernel to arch/x86/power, modify the names of the 32-bit 
> files already in arch/x86/power and update the Makefiles accordingly, 
> but there are some changes queued for merging that touch the files in 
> question.

nice cleanup.

> When is the right time for making changes like that?

best would be after the x86.git merge. We could push this via x86.git in 
fact, to line it up with whatever other changes there might be. -mm 
would be fine too, if there are pending patches in this area in -mm. 
(and i recall you did some global-scope suspend/resume changes that 
might interfere?)

	Ingo
