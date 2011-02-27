From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH] intel_idle: disable NHM/WSM HW C-state
	auto-demotion (v3)
Date: Sun, 27 Feb 2011 17:17:53 +0100
Message-ID: <AANLkTinVCvUkmX3pnSy_Ah3fOm6hV-jAPrQXAQ971xnS__38136.8715818555$1298823552$gmane$org@mail.gmail.com>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
	<alpine.LFD.2.02.1101190035200.14668@x980>
	<alpine.LFD.2.02.1102160119430.843@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1102160119430.843@x980>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 16, 2011 at 7:22 AM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> Hardware C-state auto-demotion is a mechanism where the HW overrides
> the OS C-state request, instead demoting to a shallower state,
> which is less expensive, but saves less power.
I'm interrested, for pytimechart, to have trace information of what
actual c-state got reached after each idle request.
Do you have any info on how to get that?

Regards
Pierre
