From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/2] acer-wmi - Fail gracefully if ACPI is
	disabled
Date: Tue, 12 Feb 2008 19:28:05 +0000
Message-ID: <200802121928.06420.carlos__13289.4681221389$1202844840$gmane$org@strangeworlds.co.uk>
References: <200802080145.16774.lenb@kernel.org>
	<200802111955.04562.carlos@strangeworlds.co.uk>
	<alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 February 2008 04:41:42 Linus Torvalds wrote:
> 
> On Mon, 11 Feb 2008, Carlos Corbacho wrote:
> > 
> > WMI drivers, like their ACPI counterparts, should also check if ACPI is
> > disabled or not, and bail out if so, otherwise we cause a crash.
> 
> Shouldn't "wmi_has_guid()" just return false if ACPI isn't enabled, and 
> the drivers should just then always give up?

Yes - that's a better fix.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
