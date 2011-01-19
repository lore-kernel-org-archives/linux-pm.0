From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] intel_idle: disable HW auto-demotion
Date: Wed, 19 Jan 2011 14:41:52 +0000
Message-ID: <20110119144152.GA23020__37100.8957889446$1295448275$gmane$org@srcf.ucam.org>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1101182150400.14668@x980>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 18, 2011 at 09:52:26PM -0500, Len Brown wrote:
> + * Disable HW auto demotion on tick-less idle kernels
> + */
> +static unsigned int has_nhm_snb_hw_auto_demotion;
> +#ifdef CONFIG_NO_HZ
> +static unsigned int auto_demotion;
> +#else
> +static unsigned int auto_demotion = 1;
> +#endif

What if someone boots with nohz=off?

Just so I'm clear on this - this is unrelated to the auto-popup on DMA, 
right?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
