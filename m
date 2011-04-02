From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 07/18] x86 idle: clarify AMD erratum 400
	workaround
Date: Sat, 02 Apr 2011 15:19:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104021442460.18682__35711.0164514326$1301772061$gmane$org@x980>
References: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
	<68477f71a39cd0ba9acd40e94e49969cbe1bec79.1301724243.git.len.brown@intel.com>
	<20110402082316.GA21804@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110402082316.GA21804@liondog.tnic>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: Len Brown <len.brown@intel.com>, Hans Rosenfeld <hans.rosenfeld@amd.com>, Andreas Herrmann <andreas.herrmann3@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org, borislav.petkov@amd.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > -static cpumask_var_t c1e_mask;
> > +static cpumask_var_t amd_e400_mask;
> 
> Actually, the correct name should be IMHO
> 
> 	amd_e400_c1e_mask

okay.

> > -			c1e_detected = true;
> > +			amd_e400_detected = true;
> 
> Hmm, c1e_detected is still the correct name since those two bits in
> the INT_PENDING MSR mean simply that the system can either generate an
> IO read or an SMI to enter C1E irrespective of E400. So I'd leave it
> c1e_detected.

We don't run the code that sets this flag unless
cpu_has_amd_erratum(amd_erratum_400)

so how about this?:

- c1e_detected
+ amd_e400_c1e_detected

> > -void __init init_c1e_mask(void)
> > +void __init init_amd_e400_mask(void)
> 
> Same here, init_amd_e400_c1e_mask.

done.

thanks,
Len Brown, Intel Open Source Technology Center
