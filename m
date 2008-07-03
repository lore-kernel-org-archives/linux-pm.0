From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 4/4] x86_32: mark ACPI NVS memory region
Date: Thu, 03 Jul 2008 16:44:14 +0800
Message-ID: <1215074654.3214.11.camel@rzhang-dt.sh.intel.com>
References: <1215051879.5628.36.camel@rzhang-dt.sh.intel.com>
	<20080703082720.GA4389@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080703082720.GA4389@elte.hu>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Thu, 2008-07-03 at 16:27 +0800, Ingo Molnar wrote:
> 
> * Zhang Rui <rui.zhang@intel.com> wrote:
> 
> >
> > x86_32: Mark ACPI NVS memory region.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  arch/x86/kernel/e820_32.c |   26 ++++++++++++++++++++++++++
> 
> please do this change against tip/master or linux-next, as this file
> has
> been heavily modified and unified already. See:
> 
>  http://people.redhat.com/mingo/tip.git/README
> 
>   
Okay, will re-base this patch set on top of linux-next later.

thanks,
rui
