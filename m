From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support (v2)
Date: Thu, 24 Mar 2011 09:01:17 -0700
Message-ID: <m2y644tsmq.fsf__42275.5191837952$1300982715$gmane$org@firstfloor.org>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<alpine.LFD.2.02.1103240414450.4529@x980>
	<alpine.LFD.2.02.1103240430110.16085@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1103240430110.16085@x980> (Len Brown's message
	of "Thu, 24 Mar 2011 04:31:48 -0400 (EDT)")
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Len Brown <lenb@kernel.org> writes:

> Microsoft was able to delete APM from Windows in 2006
> with the release of Windows Vista.  5 years later it seems
> quite safe that the latest Linux kernel can also.
>
> The vintage APM laptops have become difficult to find,
> making changes in this area difficult to test.

One other use-case even on non laptops was powering off the system.
I know my desktops used to need that.

Would it make sense to retain that path? 

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
