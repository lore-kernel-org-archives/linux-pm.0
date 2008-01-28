From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Q: x86 suspend/hibernation code consolidation
Date: Mon, 28 Jan 2008 16:01:40 +0100
Message-ID: <200801281601.41651.rjw__33200.4775562838$1201532806$gmane$org@sisk.pl>
References: <200801260132.09529.rjw@sisk.pl> <20080128140350.GB27928@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080128140350.GB27928@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Monday, 28 of January 2008, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > I'd like to move the 64-bit suspend/hibernation files from 
> > arch/x86/kernel to arch/x86/power, modify the names of the 32-bit 
> > files already in arch/x86/power and update the Makefiles accordingly, 
> > but there are some changes queued for merging that touch the files in 
> > question.
> 
> nice cleanup.
> 
> > When is the right time for making changes like that?
> 
> best would be after the x86.git merge. We could push this via x86.git in 
> fact, to line it up with whatever other changes there might be. -mm 
> would be fine too, if there are pending patches in this area in -mm.

There is one patch in acpi.git, AFAICS, so I guess I'd have to wait for both
x86.git and acpi.git with that, which means -rc1 time frame more or less.
 
> (and i recall you did some global-scope suspend/resume changes that 
> might interfere?)

Some of them are in acpi.git and some have been merged already.

Thanks,
Rafael
