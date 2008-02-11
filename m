From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc0 (#2)
Date: Mon, 11 Feb 2008 19:23:30 +0000
Message-ID: <200802111923.31736.carlos__29596.561092376$1202770254$gmane$org@strangeworlds.co.uk>
References: <200802080145.16774.lenb@kernel.org>
	<200802091142.18596.carlos@strangeworlds.co.uk>
	<20080211091743.GA16459@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080211091743.GA16459@elte.hu>
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
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 11 February 2008 09:17:43 Ingo Molnar wrote:
> no, it does not help - see the attached .config and the crash.log.

Thanks Ingo - the cause of the crash is ACPI being disabled on your system for 
some reason. I can reproduce your crash every time here with acpi=off.

The two WMI based drivers (acer-wmi, tc1100-wmi) in the kernel both need a 
simple patch each to fix this - patches to follow.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
