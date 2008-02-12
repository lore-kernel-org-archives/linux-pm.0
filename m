From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] acer-wmi - Fail gracefully if ACPI is
	disabled
Date: Tue, 12 Feb 2008 16:12:25 +0100
Message-ID: <20080212151225.GA5415__42677.9042034925$1202829387$gmane$org@elte.hu>
References: <200802080145.16774.lenb@kernel.org>
	<20080211091743.GA16459@elte.hu>
	<200802111923.31736.carlos@strangeworlds.co.uk>
	<200802111955.04562.carlos@strangeworlds.co.uk>
	<alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802112038360.2920@woody.linux-foundation.org>
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
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> @@ -673,11 +673,11 @@ static int __init acpi_wmi_init(void)
>  {
>  	acpi_status result;
>  
> +	INIT_LIST_HEAD(&wmi_blocks.list);
> +
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> -	INIT_LIST_HEAD(&wmi_blocks.list);
> -

test results: i've turned the WMI options back on earlier today on 
latest -git which has your patch above, and those crashes i reported 
disappeared. So the problem is fixed.

	Ingo
