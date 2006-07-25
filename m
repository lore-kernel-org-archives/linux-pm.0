From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bus.suspend_prepare()
Date: Tue, 25 Jul 2006 11:29:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607251127420.29649@g5.osdl.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<200607251117.32105.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607251117.32105.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Tue, 25 Jul 2006, David Brownell wrote:
>
> Hmm ... I just noticed that the swsusp code path (PM_SUSPEND_DISK)
> is ignoring the new suspend_prepare() mechanism.
> =

> That doesn't seem like a good thing ... Linus, is there a reason you
> did it that way?

Just because I found that neither interesting nor testable in my =

environment.

>		  Why is there no sibling resume_complete()?  ISTR
> that Ben was the advocate of a suspend_prepare(), but the use cases
> for this call are unclear to me ...

Havign a resume_complete() would be nice for a number of things, like =

reloading firmware etc (which usually requires not just the device being =

back and fully working, but more importantly, requires user space to be =

alive again).

		Linus
