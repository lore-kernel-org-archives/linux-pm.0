From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/9] x86 idle cruft removal - v2
Date: Thu, 31 Mar 2011 10:45:49 +0100
Message-ID: <20110331104549.3065ab29__37461.7116679021$1301564960$gmane$org@lxorguk.ukuu.org.uk>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<1301551404-8263-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1301551404-8263-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> [PATCH 6/9] x86 idle APM: delete apm_cpu_idle(), and its use of pm_idle
> [PATCH 7/9] x86 idle: do not EXPORT_SYMBOL pm_idle and default_idle

I thought someone had agreed to look after APM ?

I'm also curious why you write

"There is some doubt whether the APM idle feature
to call into the BIOS from the idle loop is reliable.
Certainly it was known to fail on some machines,
but more importantly, APM machines have not shipped
for a decade and so finding machines to test the code
is problematic."

We don't care if it doesn't work on a few machines (in fact we have
a table to avoid that), we care that it *DOES* work on lots.

Removing it probably isn't a bad thing long term, but it's not appeared in
the deprecated list and has not been there for several releases so it is
not eligible for removal at this point.

People spent years getting Linux to support all this hardware and
throwing bits out left right and centre to tidy up your current project
is not the way it should be done.

So can we do this properly please. We have a process for good reason.

Deprecate it properly

Add a printk/WARN_ON() indicating to the user it is deprecated but we
will continue, and then give it a couple of releaes. Kerneloops.org will
help answer whether that WARN_ON was hit.

And in the meantime just progress the rest of the work with it present.
If you break APM support by accident doing that then either

a) someone will jump up and down and yell regression - and debug it for
you

or

b) there will be silence because nobody noticed it broke


Alan
