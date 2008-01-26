From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Q: x86 suspend/hibernation code consolidation
Date: Sun, 27 Jan 2008 00:36:39 +0100
Message-ID: <200801270036.41249.rjw__11520.2316818342$1201391004$gmane$org@sisk.pl>
References: <200801260132.09529.rjw@sisk.pl> <20080126094239.GA4096@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080126094239.GA4096@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, 26 of January 2008, Pavel Machek wrote:
> Hi!
> 
> > I'd like to move the 64-bit suspend/hibernation files from arch/x86/kernel to
> > arch/x86/power, modify the names of the 32-bit files already in
> > arch/x86/power and update the Makefiles accordingly, but there are some changes
> > queued for merging that touch the files in question.
> 
> I have similar patch producing hibernation_*.S, I can send it as a
> base.

Well, it probably will have to be rebased anyway.  That's the problem: what to
base it on to avoid conflicts.

> Moving it soon  would be nice :-).

Yes, but I'm afraid not earlier than after the ACPI suspend tree is merged.

> As I'm in process of rewriting arch/x86/kernel/acpi/ , I'd prefer that
> not to be moved from under me.

I'm not going to touch that now. :-)

Greetings,
Rafael
