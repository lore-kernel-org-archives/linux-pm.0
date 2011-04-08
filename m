From: Len Brown <lenb@kernel.org>
Subject: Re: [stable] [PATCH 1/2 2.6.37.stable] intel_idle:
 disable NHM/WSM HW C-state auto-demotion
Date: Fri, 08 Apr 2011 12:14:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104081207040.27120@x980>
References: <alpine.LFD.2.02.1103222222490.10489@x980>
	<20110323225420.GE27334@kroah.com>
	<alpine.LFD.2.02.1103232252000.12911@x980>
	<20110408131645.GB18525@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110408131645.GB18525@atrey.karlin.mff.cuni.cz>
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
Cc: linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

> Why is it stable material? Seems like small power optimalization to me...

Before this patch, an offline CPU could prevent
package-wide C-states.  There is a significant
power difference between being able to enter
a package-wide C-state vs. not.

While processor offline is not used by everybody,
some products use it routinely.  Indeed, MRST
simply can not ship without this patch.

thanks,
Len Brown, Intel Open Source Technology Center
