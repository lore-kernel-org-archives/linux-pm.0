From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/9] x86 idle cruft removal - v2
Date: Thu, 31 Mar 2011 12:28:36 +0200
Message-ID: <20110331102836.GA3723__22138.2358846769$1301567383$gmane$org@elte.hu>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<1301551404-8263-1-git-send-email-lenb@kernel.org>
	<20110331104549.3065ab29@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110331104549.3065ab29@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> We don't care if it doesn't work on a few machines (in fact we have
> a table to avoid that), we care that it *DOES* work on lots.
> 
> Removing it probably isn't a bad thing long term, but it's not appeared in
> the deprecated list and has not been there for several releases so it is
> not eligible for removal at this point.
> 
> People spent years getting Linux to support all this hardware and
> throwing bits out left right and centre to tidy up your current project
> is not the way it should be done.
> 
> So can we do this properly please. We have a process for good reason.
> 
> Deprecate it properly

Ok, agreed. Len, mind delaying this patch for a few releases?

> Add a printk/WARN_ON() indicating to the user it is deprecated but we
> will continue, and then give it a couple of releaes. Kerneloops.org will
> help answer whether that WARN_ON was hit.

Yeah, also add a -stable backport so that older kernel users have a chance to 
notice faster.

Thanks,

	Ingo
